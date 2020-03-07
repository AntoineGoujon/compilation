package mini_c;

import java.util.LinkedList;
import java.util.List;

class ToERTL implements RTLVisitor {

    private ERTLfile ertl;
    private ERTLgraph body;
    private Label Ld;

    public ToERTL() {
        ertl = new ERTLfile();
    }

    public ERTLfile translate(RTLfile rtl) {
        this.visit(rtl);
        return ertl;
    }

    public void visit(Rconst o) {
        body.graph.put(Ld, new ERconst(o.i, o.r, o.l));
    }

    public void visit(Rload o) {
        body.graph.put(Ld, new ERload(o.r1, o.i, o.r2, o.l));
    }

    public void visit(Rstore o) {
        body.graph.put(Ld, new ERstore(o.r1, o.r2, o.i, o.l));
    }

    public void visit(Rmunop o) {
        body.graph.put(Ld, new ERmunop(o.m, o.r, o.l));
    }

    public void visit(Rmbinop o) {
        if (o.m == Mbinop.Mdiv) {
            Label Ltmp = o.l;
            Ltmp = body.add(new ERmbinop(Mbinop.Mmov, Register.rax, o.r2, Ltmp));
            Ltmp = body.add(new ERmbinop(Mbinop.Mdiv, o.r1, Register.rax, Ltmp));
            body.graph.put(Ld, new ERmbinop(Mbinop.Mmov, o.r2, Register.rax, Ltmp));
        } else {
            body.graph.put(Ld, new ERmbinop(o.m, o.r1, o.r2, o.l));
        }
    }

    public void visit(Rmubranch o) {
        body.graph.put(Ld, new ERmubranch(o.m, o.r, o.l1, o.l2));
    }

    public void visit(Rmbbranch o) {
        body.graph.put(Ld, new ERmbbranch(o.m, o.r1, o.r2, o.l1, o.l2));
    }

    public void visit(Rcall o) {

        Label Ltmp = o.l;

        int a = Math.min(Register.parameters.size(), o.rl.size());
        int b = Math.max(0, o.rl.size() - Register.parameters.size());

        if (b > 0) {
            Ltmp = body.add(new ERmunop(new Maddi(b * 8), Register.rsp, Ltmp));
        }
        Ltmp = body.add(new ERmbinop(Mbinop.Mmov, Register.result, o.r, Ltmp));
        Ltmp = body.add(new ERcall(o.s, a, Ltmp));

        for (int j = Register.parameters.size(); j < o.rl.size(); j++) {
            Ltmp = body.add(new ERpush_param(o.rl.get(j), Ltmp));
        }
        for (int j = 0; j < a; j++) {
            Ltmp = body.add(new ERmbinop(Mbinop.Mmov, o.rl.get(j), Register.parameters.get(j), Ltmp));
        }
        body.graph.put(Ld, new ERgoto(Ltmp));
    }

    public void visit(Rgoto o) {
        body.graph.put(Ld, new ERgoto(o.l));
    }

    public void visit(RTLfun o) {
        ERTLfun ertlfun = new ERTLfun(o.name, o.formals.size());
        ertlfun.locals = o.locals;
        ertlfun.body = new ERTLgraph();
        body = ertlfun.body;

        Label Ltmp = o.entry;
        int a = Math.min(Register.parameters.size(), o.formals.size());
        int b = Math.max(0, o.formals.size() - Register.parameters.size());

        for (int j = 0; j < b; j++) {
            // TODO: not Weird "+2"
            Ltmp = body.add(new ERget_param((j + 2) * 8, o.formals.get(a + j), Ltmp));
        }
        for (int j = 0; j < a; j++) {
            Ltmp = body.add(new ERmbinop(Mbinop.Mmov, Register.parameters.get(j), o.formals.get(j), Ltmp));
        }

        List<Register> cs = new LinkedList<>();
        for (Register csr : Register.callee_saved) {
            Register r = new Register();
            Ltmp = body.add(new ERmbinop(Mbinop.Mmov, csr, r, Ltmp));
            ertlfun.locals.add(r);
            cs.add(r);
        }

        Ltmp = body.add(new ERalloc_frame(Ltmp));
        ertlfun.entry = Ltmp;

        o.body.graph.entrySet().forEach(entry -> {
            Ld = entry.getKey();
            entry.getValue().accept(this);
        });

        Ltmp = body.add(new ERreturn());
        Ltmp = body.add(new ERdelete_frame(Ltmp));
        for (int i = 0; i < Register.callee_saved.size(); i++) {
            Ltmp = body.add(new ERmbinop(Mbinop.Mmov, cs.get(i), Register.callee_saved.get(i), Ltmp));
        }
        body.graph.put(o.exit, new ERmbinop(Mbinop.Mmov, o.result, Register.rax, Ltmp));

        ertl.funs.add(ertlfun);
    }

    public void visit(RTLfile o) {
        o.funs.forEach(fun -> {
            fun.accept(this);
        });
    }
}