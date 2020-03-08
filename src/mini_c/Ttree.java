package mini_c;

import java.util.HashMap;
import java.util.LinkedList;

abstract class Typ {
	@Override
	public boolean equals(Object o) {

		if (this.getClass() == o.getClass()) {
			return true;
		}

		if (((this instanceof Ttypenull) && (o instanceof Tint))
				|| ((o instanceof Ttypenull) && (this instanceof Tint))) {
			return true;
		}
		if (((this instanceof Ttypenull) && (o instanceof Tstructp))
				|| ((o instanceof Ttypenull) && (this instanceof Tstructp))) {
			return true;
		}
		if (((this instanceof Tvoidstar) && (o instanceof Tstructp))
				|| ((o instanceof Tvoidstar) && (this instanceof Tstructp))) {
			return true;
		}
		return false;
	}
}

class Tint extends Typ {
	Tint() {
	}

	@Override
	public String toString() {
		return "int";
	}
}

class Tstructp extends Typ {
	public Structure s;

	Tstructp(Structure s) {
		this.s = s;
	}

	@Override
	public String toString() {
		return "struct " + s.str_name + "*";
	}
}

class Tvoidstar extends Typ {
	Tvoidstar() {
	}

	@Override
	public String toString() {
		return "void*";
	}
}

class Ttypenull extends Typ {
	Ttypenull() {
	}

	@Override
	public String toString() {
		return "typenull";
	}
}

class Structure {
	public String str_name;
	public HashMap<String, Field> fields;
	// on pourra ajouter plus tard ici la taille totale de la structure

	// Added to access field in memory
	public HashMap<String, Integer> fields_i;

	Structure(String str_name) {
		this.str_name = str_name;
		this.fields = new HashMap<String, Field>();
		this.fields_i = new HashMap<String, Integer>();
	}

}

class Field {
	public String field_name;
	public Typ field_typ;
	// on pourra ajouter plus tard ici la position du champ dans la structure

	Field(String field_name, Typ field_typ) {
		this.field_name = field_name;
		this.field_typ = field_typ;
	}
}

class Decl_var {
	public Typ t;
	public String name;

	Decl_var(Typ t, String i) {
		this.t = t;
		this.name = i;
	}

	@Override
	public String toString() {
		return t.toString() + " " + name;
	}
}

// expression

abstract class Expr {
	public Typ typ; // chaque expression est décorée par son type
	boolean pure;

	abstract void accept(Visitor v);
}

class Econst extends Expr {
	public int i;

	Econst(int i) {
		this.i = i;
		this.pure = true;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Eaccess_local extends Expr {
	public String i;

	Eaccess_local(String i) {
		this.i = i;
		this.pure = true;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Eaccess_field extends Expr {
	public Expr e;
	public Field f;

	Eaccess_field(Expr e, Field f) {
		this.e = e;
		this.f = f;
		this.pure = true;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Eassign_local extends Expr {
	public String i;
	public Expr e;

	Eassign_local(String i, Expr e) {
		this.i = i;
		this.e = e;
		this.pure = false;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Eassign_field extends Expr {
	public Expr e1;
	public Field f;
	public Expr e2;

	Eassign_field(Expr e1, Field f, Expr e2) {
		this.e1 = e1;
		this.f = f;
		this.e2 = e2;
		this.pure = false;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Eunop extends Expr {
	public Unop u;
	public Expr e;

	Eunop(Unop u, Expr e) {
		this.u = u;
		this.e = e;
		this.pure = e.pure;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Ebinop extends Expr {
	public Binop b;
	public Expr e1;
	public Expr e2;

	Ebinop(Binop b, Expr e1, Expr e2) {
		this.b = b;
		this.e1 = e1;
		this.e2 = e2;
		this.pure = e1.pure && e2.pure;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Ecall extends Expr {
	public String i;
	public LinkedList<Expr> el;

	Ecall(String i, LinkedList<Expr> el) {
		this.i = i;
		this.el = el;
		this.pure = false;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Esizeof extends Expr {
	public Structure s;

	Esizeof(Structure s) {
		this.s = s;
		this.pure = true;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

// instruction

abstract class Stmt {
	abstract void accept(Visitor v);
}

class Sskip extends Stmt {
	Sskip() {
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Sexpr extends Stmt {
	public Expr e;

	Sexpr(Expr e) {
		this.e = e;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Sif extends Stmt {
	public Expr e;
	public Stmt s1;
	public Stmt s2;

	Sif(Expr e, Stmt s1, Stmt s2) {
		this.e = e;
		this.s1 = s1;
		this.s2 = s2;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Swhile extends Stmt {
	public Expr e;
	public Stmt s;

	Swhile(Expr e, Stmt s) {
		this.e = e;
		this.s = s;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Sblock extends Stmt {
	public LinkedList<Decl_var> dl;
	public LinkedList<Stmt> sl;

	Sblock(LinkedList<Decl_var> dl, LinkedList<Stmt> sl) {
		this.dl = dl;
		this.sl = sl;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

class Sreturn extends Stmt {
	public Expr e;

	Sreturn(Expr e) {
		this.e = e;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

// fonction

class Decl_fun {
	public Typ fun_typ;
	public String fun_name;
	public LinkedList<Decl_var> fun_formals;
	public Stmt fun_body;

	// For RTL
	public RTLfun rtlfun;

	Decl_fun(Typ fun_typ, String fun_name, LinkedList<Decl_var> fun_formals, Stmt fun_body) {
		this.fun_typ = fun_typ;
		this.fun_name = fun_name;
		this.fun_formals = fun_formals;
		this.fun_body = fun_body;
	}

	void accept(Visitor v) {
		v.visit(this);
	}

	@Override
	public String toString() {
		return fun_name;
	}
}

// programme = liste de fonctions

class File {
	public LinkedList<Decl_fun> funs;

	File(LinkedList<Decl_fun> funs) {
		this.funs = funs;
	}

	void accept(Visitor v) {
		v.visit(this);
	}
}

interface Visitor {
	public void visit(Econst n);

	public void visit(Eaccess_local n);

	public void visit(Eaccess_field n);

	public void visit(Eassign_local n);

	public void visit(Eassign_field n);

	public void visit(Eunop n);

	public void visit(Ebinop n);

	public void visit(Ecall n);

	public void visit(Esizeof n);

	public void visit(Sskip n);

	public void visit(Sexpr n);

	public void visit(Sif n);

	public void visit(Swhile n);

	public void visit(Sblock n);

	public void visit(Sreturn n);

	public void visit(Decl_fun n);

	public void visit(File n);
}
