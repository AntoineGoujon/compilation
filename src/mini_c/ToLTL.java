package mini_c;

class ToLTL implements ERTLVisitor {

    private Coloring coloring; // coloriage de la fonction en cours de traduction
    int size_locals; // taille pour les variables locales
    LTLgraph body; // graphe en cours de construction
    Label Ld;

    private LTLfile ltlfile;

    public ToLTL() {
        ltlfile = new LTLfile();
    }

    public LTLfile translate(ERTLfile ertlfile) {
        this.visit(ertlfile);
        return ltlfile;
    }

    @Override
    public void visit(ERconst o) {
        Operand d = coloring.colors.get(o.r);
        body.graph.put(Ld, new Lconst(o.i, d, o.l));
    }

    @Override
    public void visit(ERload o) {
        Operand d1 = coloring.colors.get(o.r1);
        Operand d2 = coloring.colors.get(o.r2);

        if (d1 instanceof Reg && d2 instanceof Reg) {
            body.graph.put(Ld, new Lload(((Reg) d1).r, o.i, ((Reg) d2).r, o.l));

        } else if (d1 instanceof Reg && d2 instanceof Spilled) {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(Register.tmp1, Register.rbp, (((Spilled) d2).n), Ltmp));
            body.graph.put(Ld, new Lload(((Reg) d1).r, o.i, Register.tmp1, Ltmp));

        } else if (d1 instanceof Spilled && d2 instanceof Reg) {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lload(Register.tmp1, o.i, ((Reg) d2).r, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, ((Spilled) d1).n, Register.tmp1, Ltmp));

        } else {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(Register.tmp2, Register.rbp, (((Spilled) d2).n), Ltmp));
            Ltmp = body.add(new Lload(Register.tmp1, o.i, Register.tmp2, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, ((Spilled) d1).n, Register.tmp1, Ltmp));
        }
    }

    @Override
    public void visit(ERstore o) {
        Operand d1 = coloring.colors.get(o.r1);
        Operand d2 = coloring.colors.get(o.r2);
        if (d1 instanceof Reg && d2 instanceof Reg) {
            body.graph.put(Ld, new Lstore(((Reg) d1).r, ((Reg) d2).r, o.i, o.l));

        } else if (d1 instanceof Reg && d2 instanceof Spilled) {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(((Reg) d1).r, Register.tmp1, o.i, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, ((Spilled) d2).n, Register.tmp1, Ltmp));

        } else if (d1 instanceof Spilled && d2 instanceof Reg) {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(Register.tmp1, (((Reg) d2).r), o.i, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, (((Spilled) d1).n), Register.tmp1, Ltmp));

        } else {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(Register.tmp1, Register.tmp2, o.i, Ltmp));
            Ltmp = body.add(new Lload(Register.rbp, (((Spilled) d2).n), Register.tmp2, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, (((Spilled) d1).n), Register.tmp1, Ltmp));
        }
    }

    @Override
    public void visit(ERmunop o) {
        Operand d = coloring.colors.get(o.r);
        body.graph.put(Ld, new Lmunop(o.m, d, o.l));
    }

    @Override
    public void visit(ERmbinop o) {
        Operand d1 = coloring.colors.get(o.r1);
        Operand d2 = coloring.colors.get(o.r2);

        if (o.m == Mbinop.Mmov && d1.equals(d2)) {
            body.graph.put(Ld, new Lgoto(o.l));

        } else if (o.m == Mbinop.Mmul && d2 instanceof Spilled) {
            Spilled s2 = (Spilled) d2;
            Label Ltmp = o.l;
            Ltmp = body.add(new Lmbinop(o.m, d1, new Reg(Register.tmp1), Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, s2.n, Register.tmp1, Ltmp));
        } else if (d1 instanceof Spilled && d2 instanceof Spilled) {
            // si les deux operandes sont en memoire
            // on doit utiliser un register temporaire
            Spilled s1 = (Spilled) d1;
            Label Ltmp = o.l;
            Ltmp = body.add(new Lmbinop(o.m, new Reg(Register.tmp1), d2, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, s1.n, Register.tmp1, Ltmp));
        } else {
            body.graph.put(Ld, new Lmbinop(o.m, d1, d2, o.l));
        }
    }

    @Override
    public void visit(ERmubranch o) {
        Operand d = coloring.colors.get(o.r);
        body.graph.put(Ld, new Lmubranch(o.m, d, o.l1, o.l2));
    }

    @Override
    public void visit(ERmbbranch o) {
        Operand d1 = coloring.colors.get(o.r1);
        Operand d2 = coloring.colors.get(o.r2);
        if (d1 instanceof Spilled && d2 instanceof Spilled) {
            // si les deux operandes sont en memoire
            // on doit utiliser un register temporaire
            Spilled s1 = (Spilled) d1;
            Label Ltmp;
            Ltmp = body.add(new Lmbbranch(o.m, new Reg(Register.tmp1), d2, o.l1, o.l2));
            body.graph.put(Ld, new Lload(Register.rbp, s1.n, Register.tmp1, Ltmp));
        } else {
            body.graph.put(Ld, new Lmbbranch(o.m, d1, d2, o.l1, o.l2));
        }
    }

    @Override
    public void visit(ERgoto o) {
        body.graph.put(Ld, new Lgoto(o.l));
    }

    @Override
    public void visit(ERcall o) {
        body.graph.put(Ld, new Lcall(o.s, o.l));
    }

    @Override
    public void visit(ERalloc_frame o) {
        Label Ltmp = o.l;
        // simplification cas m=0
        if (coloring.nlocals != 0) {
            Ltmp = body.add(new Lmunop(new Maddi(-8 * coloring.nlocals), new Reg(Register.rsp), Ltmp));
        }
        Ltmp = body.add(new Lmbinop(Mbinop.Mmov, new Reg(Register.rsp), new Reg(Register.rbp), Ltmp));
        body.graph.put(Ld, new Lpush(new Reg(Register.rbp), Ltmp));
    }

    @Override
    public void visit(ERdelete_frame o) {
        Label Ltmp = o.l;
        // simplification cas m=0
        if (coloring.nlocals == 0) {
            body.graph.put(Ld, new Lpop(Register.rbp, Ltmp));
        } else {
            Ltmp = body.add(new Lpop(Register.rbp, Ltmp));
            body.graph.put(Ld, new Lmbinop(Mbinop.Mmov, new Reg(Register.rbp), new Reg(Register.rsp), Ltmp));
        }
    }

    @Override
    public void visit(ERget_param o) {
        Operand d = coloring.colors.get(o.r);
        if (d instanceof Spilled) {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(Register.tmp1, Register.rbp, ((Spilled) d).n, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, o.i, Register.tmp1, Ltmp));

        } else {
            body.graph.put(Ld, new Lload(Register.rbp, o.i, ((Reg) d).r, o.l));
        }
    }

    @Override
    public void visit(ERput_param o) {
        Operand d = coloring.colors.get(o.r);
        if (d instanceof Spilled) {
            Label Ltmp = o.l;
            Ltmp = body.add(new Lstore(Register.tmp1, Register.rbp, o.i, Ltmp));
            body.graph.put(Ld, new Lload(Register.rbp, ((Spilled) d).n, Register.tmp1, Ltmp));
        } else {
            body.graph.put(Ld, new Lstore(((Reg) d).r, Register.rbp, o.i, o.l));
        }
    }

    @Override
    public void visit(ERpush_param o) {
        Operand d = coloring.colors.get(o.r);
        body.graph.put(Ld, new Lpush(d, o.l));
    }

    @Override
    public void visit(ERreturn o) {
        body.graph.put(Ld, new Lreturn());
    }

    @Override
    public void visit(ERTLfun o) {
        LTLfun ltlfun = new LTLfun(o.name);
        ltlfun.entry = o.entry;
        ltlfun.body = new LTLgraph();
        body = ltlfun.body;
        o.body.graph.forEach((L, instr) -> {
            Ld = L;
            instr.accept(this);
        });
        ltlfile.funs.add(ltlfun);
    }

    @Override
    public void visit(ERTLfile o) {
        o.funs.forEach(fun -> {
            Interference ig = new Interference(new Liveness(fun.body));
            coloring = new ColoringGA(ig);
            fun.accept(this);
        });
    }
}
