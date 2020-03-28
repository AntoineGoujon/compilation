package mini_c;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

//TODO question sur assigm local and field
// est il necessaire/utile de faire optimisation faite ici??

//TODO question: meilleur moyen de faire or et and??

//TODO: ajouter unary operation neg et not

//TODO more smart constructors

public class ToRTL implements Visitor {

	static class Env extends HashMap<String, Register> {
		private static final long serialVersionUID = 1L;
	}

	static final int WORDSIZE = 8;
	private LinkedList<Env> envs = new LinkedList<>();
	Set<Register> locals;
	private RTLgraph body;

	private Label Ld, Lret;
	private Register rd, rret;

	private RTLfile rtlfile;

	public ToRTL() {
		rtlfile = new RTLfile();
	}

	public RTLfile translate(File tf) {
		this.visit(tf);
		return rtlfile;
	}

	public void branch(Expr e, Label Lt, Label Lf) {
		Register r;
		if (e instanceof Ebinop) {
			Ebinop ebinop = (Ebinop) e;
			switch (ebinop.b) {
				case Bor:
					branch(ebinop.e2, Lt, Lf);
					branch(ebinop.e1, Lt, Ld);
					return;
				case Band:
					branch(ebinop.e2, Lt, Lf);
					branch(ebinop.e1, Ld, Lf);
					return;
				case Ble:
					r = new Register();
					Ld = body.add(new Rmbbranch(Mbbranch.Mjle, r, rd, Lt, Lf));
					ebinop.e1.accept(this);
					rd = r;
					ebinop.e2.accept(this);
					return;
				case Blt:
					r = new Register();
					Ld = body.add(new Rmbbranch(Mbbranch.Mjl, r, rd, Lt, Lf));
					ebinop.e1.accept(this);
					rd = r;
					ebinop.e2.accept(this);
					return;
				default:
					// TODO: il est possible de traiter plus de cas
					break;
			}
		}
		r = new Register();
		Ld = body.add(new Rmubranch(new Mjz(), r, Lf, Lt));
		rd = r;
		e.accept(this);
	}

	@Override
	public void visit(Econst n) {
		Ld = body.add(new Rconst(n.i, rd, Ld));
	}

	@Override
	public void visit(Eaccess_local n) {
		Register r = null;
		for (Env env : envs) {
			if (env.containsKey(n.i)) {
				r = env.get(n.i);
				break;
			}
		}
		Ld = body.add(new Rmbinop(Mbinop.Mmov, r, rd, Ld));
	}

	@Override
	public void visit(Eaccess_field n) {
		Register r1 = new Register();

		Tstructp structp = (Tstructp) n.e.typ;
		int i = structp.s.fields_i.get(n.f.field_name);

		Ld = body.add(new Rload(r1, i * WORDSIZE, rd, Ld));
		rd = r1;
		n.e.accept(this);
	}

	@Override
	public void visit(Eassign_local n) {
		Register r1 = null;
		Register r2 = new Register();
		for (Env env : envs) {
			if (env.containsKey(n.i)) {
				r1 = env.get(n.i);
				break;
			}
		}
		Ld = body.add(new Rmbinop(Mbinop.Mmov, r1, rd, Ld));
		Ld = body.add(new Rmbinop(Mbinop.Mmov, r2, r1, Ld));
		rd = r2;
		n.e.accept(this);
	}

	@Override
	public void visit(Eassign_field n) {
		Register r1 = new Register();
		Register r2 = new Register();

		Tstructp structp = (Tstructp) n.e1.typ;
		int i = structp.s.fields_i.get(n.f.field_name);
		Ld = body.add(new Rmbinop(Mbinop.Mmov, r1, rd, Ld));
		Ld = body.add(new Rstore(r1, r2, i * WORDSIZE, Ld));
		rd = r2;
		n.e1.accept(this);
		rd = r1;
		n.e2.accept(this);
	}

	@Override
	public void visit(Eunop n) {
		switch (n.u) {
			case Uneg:
				Register r1 = new Register();
				Ld = body.add(new Rmbinop(Mbinop.Msub, r1, rd, Ld));
				Ld = body.add(new Rconst(0, rd, Ld));
				rd = r1;
				n.e.accept(this);
				break;
			case Unot:
				Ld = body.add(new Rmunop(new Msetei(0), rd, Ld));
				n.e.accept(this);
				break;
		}
	}

	@Override
	public void visit(Ebinop n) {
		Mbinop op = null;
		switch (n.b) {
			case Beq:
				op = Mbinop.Msete;
				break;
			case Bneq:
				op = Mbinop.Msetne;
				break;
			case Ble:
				op = Mbinop.Msetle;
				break;
			case Blt:
				op = Mbinop.Msetl;
				break;
			case Bge:
				op = Mbinop.Msetge;
				break;
			case Bgt:
				op = Mbinop.Msetg;
				break;
			case Badd:
				if (Main.optimizeSM) {
					if (n.e1 instanceof Econst && n.e2 instanceof Econst) {
						Econst n1 = (Econst) n.e1;
						Econst n2 = (Econst) n.e2;
						Ld = body.add(new Rconst(n1.i + n2.i, rd, Ld));
						return;
					} else if (n.e1 instanceof Econst && ((Econst) n.e1).i == 0) {
						n.e2.accept(this);
						return;
					} else if (n.e2 instanceof Econst && ((Econst) n.e2).i == 0) {
						n.e1.accept(this);
						return;
					} else if (n.e1 instanceof Econst) {
						int c = ((Econst) n.e1).i;
						Ld = body.add(new Rmunop(new Maddi(c), rd, Ld));
						n.e2.accept(this);
						return;
					} else if (n.e2 instanceof Econst) {
						int c = ((Econst) n.e2).i;
						Ld = body.add(new Rmunop(new Maddi(c), rd, Ld));
						n.e1.accept(this);
						return;
					}
				}
				op = Mbinop.Madd;
				break;
			case Bsub:
				if (Main.optimizeSM) {
					if (n.e1 instanceof Econst && n.e2 instanceof Econst) {
						Econst n1 = (Econst) n.e1;
						Econst n2 = (Econst) n.e2;
						Ld = body.add(new Rconst(n1.i - n2.i, rd, Ld));
						return;
					} else if (n.e1 instanceof Econst && ((Econst) n.e1).i == 0) {
						n.e2.accept(this);
						return;
					} else if (n.e2 instanceof Econst && ((Econst) n.e2).i == 0) {
						n.e1.accept(this);
						return;
					} else if (n.e1 instanceof Econst) {
						int c = ((Econst) n.e1).i;
						Ld = body.add(new Rmunop(new Maddi(-c), rd, Ld));
						n.e2.accept(this);
						return;
					} else if (n.e2 instanceof Econst) {
						int c = ((Econst) n.e2).i;
						Ld = body.add(new Rmunop(new Maddi(-c), rd, Ld));
						n.e1.accept(this);
						return;
					}
				}
				op = Mbinop.Msub;
				break;
			case Bmul:
				if (Main.optimizeSM) {
					if (n.e1 instanceof Econst && n.e2 instanceof Econst) {
						Econst n1 = (Econst) n.e1;
						Econst n2 = (Econst) n.e2;
						Ld = body.add(new Rconst(n1.i * n2.i, rd, Ld));
						return;
					} else if (n.e1 instanceof Econst && ((Econst) n.e1).i == 0) {
						if (n.e2.pure) {
							Ld = body.add(new Rconst(0, rd, Ld));
							return;
						}
					} else if (n.e2 instanceof Econst && ((Econst) n.e2).i == 0) {
						if (n.e1.pure) {
							Ld = body.add(new Rconst(0, rd, Ld));
							return;
						}
					}
				}
				op = Mbinop.Mmul;
				break;
			case Bdiv:
				if (Main.optimizeSM) {
					if (n.e1 instanceof Econst && n.e2 instanceof Econst) {
						Econst n1 = (Econst) n.e1;
						Econst n2 = (Econst) n.e2;
						Ld = body.add(new Rconst(n1.i / n2.i, rd, Ld));
						return;
					} else if (n.e1 instanceof Econst && ((Econst) n.e1).i == 0) {
						if (n.e2.pure) {
							Ld = body.add(new Rconst(0, rd, Ld));
							return;
						}
					}
				}
				op = Mbinop.Mdiv;
				break;
			case Bor:
				Label L0 = body.add(new Rconst(0, rd, Ld));
				Label L1 = body.add(new Rconst(1, rd, Ld));
				branch(n.e2, L1, L0);
				branch(n.e1, L1, Ld);
				return;
			case Band:
				Label L0b = body.add(new Rconst(0, rd, Ld));
				Label L1b = body.add(new Rconst(1, rd, Ld));
				branch(n.e2, L1b, L0b);
				branch(n.e1, Ld, L0b);
				return;
		}
		// Default action
		Register r1 = new Register();
		Ld = body.add(new Rmbinop(op, r1, rd, Ld));
		n.e1.accept(this);
		rd = r1;
		n.e2.accept(this);
	}

	@Override
	public void visit(Ecall n) {
		List<Register> rl = new LinkedList<>();
		Ld = body.add(new Rcall(rd, n.i, rl, Ld, n.tailCall));
		n.el.forEach(e -> {
			rd = new Register();
			rl.add(rd);
			e.accept(this);
		});
	}

	@Override
	public void visit(Esizeof n) {
		int s = n.s.fields.size() * WORDSIZE;
		Ld = body.add(new Rconst(s, rd, Ld));
	}

	@Override
	public void visit(Sskip n) {
	}

	@Override
	public void visit(Sexpr n) {
		// if (n.e instanceof Eassign_local) {
		// Eassign_local nl = (Eassign_local) n.e;
		// Register r1 = null;
		// Register r2 = new Register();
		// for (Env env : envs) {
		// if (env.containsKey(nl.i)) {
		// r1 = env.get(nl.i);
		// break;
		// }
		// }
		// Ld = body.add(new Rmbinop(Mbinop.Mmov, r2, r1, Ld));
		// rd = r2;
		// nl.e.accept(this);
		// } else if (n.e instanceof Eassign_field) {
		// Eassign_field nl = (Eassign_field) n.e;
		// Register r1 = new Register();
		// Register r2 = new Register();
		// Tstructp structp = (Tstructp) nl.e1.typ;
		// int i = structp.s.fields_i.get(nl.f.field_name);
		// Ld = body.add(new Rstore(r1, r2, i * WORDSIZE, Ld));
		// rd = r2;
		// nl.e1.accept(this);
		// rd = r1;
		// nl.e2.accept(this);
		// } else {
		n.e.accept(this);
		// }
	}

	@Override
	public void visit(Sif n) {
		Label Lt, Lf;
		Label Ldtmp = Ld;
		Register rdtmp = rd;
		n.s1.accept(this);
		Lt = Ld;
		Ld = Ldtmp;
		n.s2.accept(this);
		Lf = Ld;
		rd = rdtmp;
		branch(n.e, Lt, Lf);
	}

	@Override
	public void visit(Swhile n) {
		Label Lt, Lf, Le;
		Label Ldtmp = Ld;
		Label L = new Label();
		Ld = L;
		n.s.accept(this);
		Lt = Ld;
		Lf = Ldtmp;
		branch(n.e, Lt, Lf);
		Le = Ld;
		body.graph.put(L, new Rgoto(Le));
	}

	@Override
	public void visit(Sblock n) {
		Env localEnv = new Env();
		n.dl.forEach(var -> {
			Register freshr = new Register();
			localEnv.put(var.name, freshr);
			locals.add(freshr);
		});
		envs.push(localEnv);
		Iterator<Stmt> di = n.sl.descendingIterator();
		while (di.hasNext()) {
			Stmt s = di.next();
			s.accept(this);
		}
		envs.pop();
	}

	@Override
	public void visit(Sreturn n) {
		Ld = Lret;
		rd = rret;
		n.e.accept(this);
	}

	@Override
	public void visit(Decl_fun n) {
		Env localEnv = new Env();

		RTLfun rtlfun = new RTLfun(n.fun_name);
		rtlfun.result = new Register();
		rret = rtlfun.result;
		rtlfun.exit = new Label();
		Lret = rtlfun.exit;

		rtlfun.body = new RTLgraph();
		body = rtlfun.body;

		n.fun_formals.forEach(formal -> {
			Register freshr = new Register();
			rtlfun.formals.add(freshr);
			localEnv.put(formal.name, freshr);
		});

		locals = rtlfun.locals;
		envs.push(localEnv);
		n.fun_body.accept(this);
		envs.pop();

		rtlfun.entry = Ld;
		n.rtlfun = rtlfun;
	}

	@Override
	public void visit(File n) {
		n.funs.forEach(fun -> {
			if (!fun.fun_name.equals("putchar") && !fun.fun_name.equals("sbrk")) {
				fun.accept(this);
				rtlfile.funs.add(fun.rtlfun);
			}
		});
	}
}
