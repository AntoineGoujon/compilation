package mini_c;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Iterator;

//TODO question: une fonction termine elle toujours par return?

public class Typing implements Pvisitor {

	static class Env extends HashMap<String, Decl_var> {
		private static final long serialVersionUID = 1L;
	}

	private LinkedList<Env> envs = new LinkedList<>();
	private HashMap<String, Structure> structs = new HashMap<>();
	private HashMap<String, Decl_fun> funs = new HashMap<>();

	private Typ returnTyp;
	private boolean returning;

	public Typing() {
		LinkedList<Decl_var> putchar_fun_formals = new LinkedList<>();
		putchar_fun_formals.add(new Decl_var(new Tint(), "c"));
		Decl_fun putchar = new Decl_fun(new Tint(), "putchar", putchar_fun_formals, new Sskip());
		funs.put(putchar.fun_name, putchar);

		LinkedList<Decl_var> sbrk_fun_formals = new LinkedList<>();
		sbrk_fun_formals.add(new Decl_var(new Tint(), "n"));
		Decl_fun sbrk = new Decl_fun(new Tvoidstar(), "sbrk", sbrk_fun_formals, new Sskip());
		funs.put(sbrk.fun_name, sbrk);
	}

	private File file;

	File getFile() {
		return file;
	}

	@Override
	public void visit(Pfile n) {
		n.l.forEach(decl -> {
			decl.accept(this);
		});
		if (!funs.containsKey("main")) {
			throw new FunctionError.UndefinedFunctionError("main", new Loc(0, 0));
		}
		file = new File(new LinkedList<>(funs.values()));
	}

	@Override
	public void visit(PTint n) {
		n.typ = new Tint();
	}

	@Override
	public void visit(PTstruct n) {
		if (!structs.containsKey(n.id)) {
			throw new StructError.UndefinedStructError(n.id, n.loc);
		}
		n.typ = new Tstructp(structs.get(n.id));
	}

	@Override
	public void visit(Pint n) {
		n.expr = new Econst(n.n);
		if (n.n == 0) {
			n.expr.typ = new Ttypenull();
		} else {
			n.expr.typ = new Tint();
		}
	}

	@Override
	public void visit(Pident n) {
		for (Env env : envs) {
			if (env.containsKey(n.id)) {
				Decl_var v = env.get(n.id);
				n.expr = new Eaccess_local(n.id);
				n.expr.typ = v.t;
				return;
			}
		}
		throw new IdentError.UndeclaredIdent(n.id, n.loc);
	}

	@Override
	public void visit(Punop n) {
		n.e1.accept(this);
		if (n.op == Unop.Uneg && !(n.e1.expr.typ.equals(new Tint()))) {
			throw new OpError.UnopError(n.loc);
		}
		n.expr = new Eunop(n.op, n.e1.expr);
		n.expr.typ = new Tint();
	}

	@Override
	public void visit(Passign n) {
		n.e1.accept(this);
		if (!(n.e1 instanceof Plvalue)) {
			throw new AssignmentError.LvalueError(n.loc);
		}
		n.e2.accept(this);

		if (!n.e1.expr.typ.equals(n.e2.expr.typ)) {
			throw new AssignmentError.IncompatibleType(n.e1.expr.typ, n.e2.expr.typ, n.loc);
		}

		if (n.e1.expr instanceof Eaccess_local) {
			Eaccess_local e = (Eaccess_local) n.e1.expr;
			n.expr = new Eassign_local(e.i, n.e2.expr);
		} else if (n.e1.expr instanceof Eaccess_field) {
			Eaccess_field e = (Eaccess_field) n.e1.expr;
			n.expr = new Eassign_field(e.e, e.f, n.e2.expr);
		}
		n.expr.typ = n.e1.expr.typ;
	}

	@Override
	public void visit(Pbinop n) {
		n.e1.accept(this);
		n.e2.accept(this);
		switch (n.op) {
			case Beq:
			case Bneq:
			case Ble:
			case Blt:
			case Bge:
			case Bgt:
				if (!n.e1.expr.typ.equals(n.e2.expr.typ)) {
					throw new OpError.InvalidOperands(n.op, n.e1.expr.typ, n.e2.expr.typ, n.loc);
				}
				break;
			case Bor:
			case Band:
				break;
			case Badd:
			case Bsub:
			case Bmul:
			case Bdiv:
				if (!n.e1.expr.typ.equals(new Tint()) || !n.e2.expr.typ.equals(new Tint())) {
					throw new OpError.InvalidOperands(n.op, n.e1.expr.typ, n.e2.expr.typ, n.loc);
				}
				break;
		}
		n.expr = new Ebinop(n.op, n.e1.expr, n.e2.expr);
		n.expr.typ = new Tint();
	}

	@Override
	public void visit(Parrow n) {
		n.e.accept(this);
		if (!(n.e.expr.typ instanceof Tstructp)) {
			throw new OpError.InvalidAccess(n.e.expr.typ, n.loc);
		}
		Tstructp structp = (Tstructp) n.e.expr.typ;
		if (!structp.s.fields.containsKey(n.f)) {
			throw new StructError.UndefinedMember(structp, n.f, n.loc);
		}
		n.expr = new Eaccess_field(n.e.expr, structp.s.fields.get(n.f));
		n.expr.typ = structp.s.fields.get(n.f).field_typ;
	}

	@Override
	public void visit(Pcall n) {
		if (!funs.containsKey(n.f)) {
			throw new FunctionError.UndefinedFunctionError(n.f, n.loc);
		}
		Decl_fun fun = funs.get(n.f);
		if (n.l.size() != fun.fun_formals.size()) {
			throw new FunctionError.InvalidArgumentNumber(n.f, n.loc);
		}
		Iterator<Pexpr> it1 = n.l.iterator();
		Iterator<Decl_var> it2 = fun.fun_formals.iterator();
		LinkedList<Expr> el = new LinkedList<>();
		int nArg = 1;
		while (it1.hasNext() && it2.hasNext()) {
			Pexpr pexpr = it1.next();
			Decl_var dvar = it2.next();
			pexpr.accept(this);
			if (!pexpr.expr.typ.equals(dvar.t)) {
				throw new FunctionError.InvalidArgumentType(n.f, nArg, n.loc);
			} else {
				el.add(pexpr.expr);
			}
			nArg++;
		}
		n.expr = new Ecall(n.f, el);
		n.expr.typ = fun.fun_typ;
	}

	@Override
	public void visit(Psizeof n) {
		if (structs.containsKey(n.id)) {
			n.expr = new Esizeof(structs.get(n.id));
			n.expr.typ = new Tint();
		} else {
			throw new StructError.UndefinedStructError(n.id, n.loc);
		}

	}

	@Override
	public void visit(Pskip n) {
		n.stmt = new Sskip();
	}

	@Override
	public void visit(Peval n) {
		n.e.accept(this);
		n.stmt = new Sexpr(n.e.expr);
	}

	@Override
	public void visit(Pif n) {
		n.e.accept(this);
		n.s1.accept(this);
		n.s2.accept(this);
		n.stmt = new Sif(n.e.expr, n.s1.stmt, n.s2.stmt);
	}

	@Override
	public void visit(Pwhile n) {
		n.e.accept(this);
		n.s1.accept(this);
		n.stmt = new Swhile(n.e.expr, n.s1.stmt);
	}

	@Override
	public void visit(Pbloc n) {
		LinkedList<Decl_var> dl = new LinkedList<>();
		LinkedList<Stmt> sl = new LinkedList<>();
		n.vl.forEach(var -> {
			var.typ.accept(this);
		});
		Env localEnv = new Env();
		n.vl.forEach(v -> {
			if (localEnv.containsKey(v.id)) {
				throw new IdentError.RedeclarationError(v.id, n.loc);
			}
			Decl_var dv = new Decl_var(v.typ.typ, v.id);
			localEnv.put(v.id, dv);
			dl.add(dv);
		});
		envs.push(localEnv);
		n.sl.forEach(s -> {
			s.accept(this);
			sl.add(s.stmt);
		});
		envs.pop();
		n.stmt = new Sblock(dl, sl);
	}

	@Override
	public void visit(Preturn n) {
		n.e.accept(this);
		if (!n.e.expr.typ.equals(returnTyp)) {
			throw new FunctionError.ReturnTypeError(returnTyp, n.e.expr.typ, n.loc);
		}
		returning = true;
		n.stmt = new Sreturn(n.e.expr);
	}

	@Override
	public void visit(Pstruct n) {
		if (structs.containsKey(n.s)) {
			throw new StructError.RedefinitionError(n.s);
		}
		Structure struct = new Structure(n.s);
		structs.put(struct.str_name, struct);
		int i = 0;
		for (Pdeclvar var : n.fl) {
			if (struct.fields.containsKey(var.id)) {
				throw new StructError.DuplicateError(var.id, var.loc);
			}
			var.typ.accept(this);
			Field f = new Field(var.id, var.typ.typ);
			struct.fields.put(var.id, f);
			struct.fields_i.put(var.id, Integer.valueOf(i));
			i++;
		}
	}

	@Override
	public void visit(Pfun n) {
		if (funs.containsKey(n.s)) {
			throw new FunctionError.RedefinitionError(n.s, n.loc);
		}
		n.ty.accept(this);
		returnTyp = n.ty.typ;
		n.pl.forEach(var -> {
			var.typ.accept(this);
		});
		LinkedList<Decl_var> formals = new LinkedList<>();
		n.pl.forEach(var -> {
			formals.add(new Decl_var(var.typ.typ, var.id));
		});
		Decl_fun fun = new Decl_fun(n.ty.typ, n.s, formals, null);
		funs.put(fun.fun_name, fun);
		Env localEnv = new Env();
		n.pl.forEach(var -> {
			if (localEnv.containsKey(var.id)) {
				throw new FunctionError.ParameterRedefinitionError(var.id, var.loc);
			}
			localEnv.put(var.id, new Decl_var(var.typ.typ, var.id));
		});
		returning = false;
		envs.push(localEnv);
		n.b.accept(this);
		envs.pop();
		if (!returning) {
			System.err.println("warning: control reaches end of non-void function at " + n.loc);
		}
		fun.fun_body = n.b.stmt;
	}
}
