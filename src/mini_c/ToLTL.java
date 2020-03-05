package mini_c;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

class ToLTL implements ERTLVisitor {

    private Coloring coloring; // coloriage de la fonction en cours de traduction
    int size_locals; // taille pour les variables locales
    LTLgraph graph; // graphe en cours de construction

    private LTLfile ltlfile;

	public ToLTL() {
		ltlfile = new LTLfile();
	}

	public LTLfile translate(ERTLfile ertlfile) {
		this.visit(ertlfile);
		return ltlfile;
	}

    public void visit(ERconst o) {
    }

    public void visit(ERload o) {
    }

    public void visit(ERstore o) {
    }

    public void visit(ERmunop o) {
    }

    public void visit(ERmbinop o) {
    }

    public void visit(ERmubranch o) {
    }

    public void visit(ERmbbranch o) {
    }

    public void visit(ERgoto o) {
    }

    public void visit(ERcall o) {
    }

    public void visit(ERalloc_frame o) {
    }

    public void visit(ERdelete_frame o) {
    }

    public void visit(ERget_param o) {
    }

    public void visit(ERpush_param o) {
    }

    public void visit(ERreturn o) {
    }

    public void visit(ERTLfun o) {
    }

    public void visit(ERTLfile o) {
        o.funs.forEach(fun -> {
            Interference ig = new Interference(new Liveness(fun.body))
            coloring = new Coloring(ig);
            fun.accept(this);
        });
    }
}
