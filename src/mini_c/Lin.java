package mini_c;

import java.util.HashSet;

class Lin implements LTLVisitor {

    private LTLgraph cfg; // graphe en cours de traduction
    private X86_64 asm; // code en cours de construction
    private HashSet<Label> visited; // instructions déjà traduites

    public Lin() {
        asm = new X86_64();
        visited = new HashSet<>();
    }

    public X86_64 translate(LTLfile ltlfile) {
        this.visit(ltlfile);
        return asm;
    }

    public void visit(Lload o) {
        String op1 = o.i + "(" + o.r1 + ")";
        String op2 = o.r2 + "";
        asm.movq(op1, op2);
        lin(o.l);
    }

    public void visit(Lstore o) {
        String op1 = o.r1 + "";
        String op2 = o.i + "(" + o.r2 + ")";
        asm.movq(op1, op2);
        lin(o.l);
    }

    public void visit(Lmubranch o) {
        // test negatif pas encore produit
        if (!visited.contains(o.l2)) {
            asm.needLabel(o.l1);
            if (o.m instanceof Mjz) {
                asm.cmpq("$0", o.r.toString());
                asm.jz(o.l1.toString());
            } else if (o.m instanceof Mjnz) {
                asm.cmpq("$0", o.r.toString());
                asm.jnz(o.l1.toString());
            } else if (o.m instanceof Mjlei) {
                asm.cmpq("$" + ((Mjlei) o.m).n, o.r.toString());
                asm.jle(o.l1.toString());
            } else if (o.m instanceof Mjgi) {
                asm.cmpq("$" + ((Mjgi) o.m).n, o.r.toString());
                asm.jg(o.l1.toString());
            }
            lin(o.l2);
            lin(o.l1);

        // test positif pas encore produit
        } else if (!visited.contains(o.l1)) {
            asm.needLabel(o.l2);
            if (o.m instanceof Mjz) {
                asm.cmpq("$0", o.r.toString());
                asm.jnz(o.l2.toString());
            } else if (o.m instanceof Mjnz) {
                asm.cmpq("$0", o.r.toString());
                asm.jz(o.l2.toString());
            } else if (o.m instanceof Mjlei) {
                asm.cmpq("$" + ((Mjlei) o.m).n, o.r.toString());
                asm.jg(o.l2.toString());
            } else if (o.m instanceof Mjgi) {
                asm.cmpq("$" + ((Mjgi) o.m).n, o.r.toString());
                asm.jle(o.l2.toString());
            }
            lin(o.l1);
            lin(o.l2);

        } else {
            asm.needLabel(o.l1);
            asm.needLabel(o.l2);
            // TODO estimer condition vraie la plus souvent
            if (o.m instanceof Mjz) {
                asm.testq("$0", o.r.toString());
                asm.jz(o.l1.toString());
            } else if (o.m instanceof Mjnz) {
                asm.testq("$0", o.r.toString());
                asm.jnz(o.l1.toString());
            } else if (o.m instanceof Mjlei) {
                asm.cmpq("$" + ((Mjlei) o.m).n, o.r.toString());
                asm.jle(o.l1.toString());
            } else if (o.m instanceof Mjgi) {
                asm.cmpq("$" + ((Mjgi) o.m).n, o.r.toString());
                asm.jg(o.l1.toString());
            }
            asm.jmp(o.l2.name);
        }

    }

    public void visit(Lmbbranch o) {
        if (!visited.contains(o.l2)) {
            asm.needLabel(o.l1);
            switch (o.m) {
                case Mjl:
                    asm.cmpq(o.r1.toString(), o.r2.toString());
                    asm.jl(o.l1.toString());
                    break;
                case Mjle:
                    asm.cmpq(o.r1.toString(), o.r2.toString());
                    asm.jle(o.l1.toString());
                    break;
            }
            lin(o.l2);
            lin(o.l1);
        } else if (!visited.contains(o.l1)) {
            asm.needLabel(o.l2);
            switch (o.m) {
                case Mjl:
                    asm.cmpq(o.r1.toString(), o.r2.toString());
                    asm.jge(o.l2.toString());
                    break;
                case Mjle:
                    asm.cmpq(o.r1.toString(), o.r2.toString());
                    asm.jg(o.l2.toString());
                    break;
            }
            lin(o.l1);
            lin(o.l2);

        } else {
            asm.needLabel(o.l1);
            asm.needLabel(o.l2);
            // TODO estimer condition vraie la plus souvent
            switch (o.m) {
                case Mjl:
                    asm.cmpq(o.r1.toString(), o.r2.toString());
                    asm.jl(o.l1.toString());
                    break;
                case Mjle:
                    asm.cmpq(o.r1.toString(), o.r2.toString());
                    asm.jle(o.l1.toString());
                    break;
            }
            asm.jmp(o.l2.name);
        }
    }

    public void visit(Lgoto o) {
        if (visited.contains(o.l)) {
            asm.needLabel(o.l);
            asm.jmp(o.l.name);
        } else {
            lin(o.l);
        }
    }

    public void visit(Lreturn o) {
        asm.ret();
    }

    public void visit(Lconst o) {
        asm.movq(o.i, o.o.toString());
        lin(o.l);
    }

    public void visit(Lmunop o) {
        if (o.m instanceof Maddi) {
            String op1 = "$" + ((Maddi) o.m).n;
            String op2 = o.o.toString();
            asm.addq(op1, op2);
        } else if (o.m instanceof Msetei) {
            asm.cmpq(((Msetei) o.m).n, o.o.toString());
            asm.sete(Register.addressLowestByte(o.o.toString()));
            asm.movzbq(Register.addressLowestByte(o.o.toString()), o.o.toString());

        } else if (o.m instanceof Msetnei) {
            asm.cmpq(((Msetnei) o.m).n, o.o.toString());
            asm.setne(Register.addressLowestByte(o.o.toString()));
            asm.movzbq(Register.addressLowestByte(o.o.toString()), o.o.toString());

        } else {
            // TODO never get to this case
        }
        lin(o.l);
    }

    public void visit(Lmbinop o) {
        String op1 = o.o1.toString();
        String op2 = o.o2.toString();
        switch (o.m) {
            case Mmov:
                asm.movq(op1, op2);
                break;
            case Madd:
                asm.addq(op1, op2);
                break;
            case Msub:
                asm.subq(op1, op2);
                break;
            case Mmul:
                asm.imulq(op1, op2);
                break;
            case Mdiv:
                asm.cqto();
                asm.idivq(op1);
                break;
            case Msete:
                asm.cmpq(op1, op2);
                asm.sete(Register.addressLowestByte(op2));
                asm.movzbq(Register.addressLowestByte(op2), op2); // TODO faux
                break;
            case Msetne:
                asm.cmpq(op1, op2);
                asm.setne(Register.addressLowestByte(op2));
                asm.movzbq(Register.addressLowestByte(op2), op2);
                break;
            case Msetl:
                asm.cmpq(op1, op2);
                asm.setl(Register.addressLowestByte(op2));
                asm.movzbq(Register.addressLowestByte(op2), op2);
                break;
            case Msetle:
                asm.cmpq(op1, op2);
                asm.setle(Register.addressLowestByte(op2));
                asm.movzbq(Register.addressLowestByte(op2), op2);
                break;
            case Msetg:
                asm.cmpq(op1, op2);
                asm.setg(Register.addressLowestByte(op2));
                asm.movzbq(Register.addressLowestByte(op2), op2);
                break;
            case Msetge:
                asm.cmpq(op1, op2);
                asm.setge(Register.addressLowestByte(op2));
                asm.movzbq(Register.addressLowestByte(op2), op2);
                break;
        }
        lin(o.l);
    }

    public void visit(Lpush o) {
        asm.pushq(o.o.toString());
        lin(o.l);
    }

    public void visit(Lpop o) {
        asm.popq(o.r.toString());
        lin(o.l);
    }

    public void visit(Lcall o) {
        asm.call(o.s);
        lin(o.l);
    }

    public void visit(LTLfun ltlfun) {
        cfg = ltlfun.body;
        asm.label(ltlfun.name);
        lin(ltlfun.entry);
    }

    public void visit(LTLfile ltlfile) {
        asm.globl("main");
        ltlfile.funs.forEach(ltlfun -> {
            ltlfun.accept(this);
        });
    }

    private void lin(Label l) {
        if (visited.contains(l)) {
            asm.needLabel(l);
            asm.jmp(l.name);
        } else {
            visited.add(l);
            asm.label(l);
            cfg.graph.get(l).accept(this);
        }
    }
}
