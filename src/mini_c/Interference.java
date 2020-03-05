package mini_c;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Arcs {
    Set<Register> prefs = new HashSet<>();
    Set<Register> intfs = new HashSet<>();
}

class Interference {
    Map<Register, Arcs> graph;

    Interference(Liveness lg) {
        graph = new HashMap<>();
        lg.info.values().forEach(li -> {
            if (li.instr instanceof ERmbinop) {
                ERmbinop instrbinop = (ERmbinop) li.instr;
                if (instrbinop.m == Mbinop.Mmov && instrbinop.r1 != instrbinop.r2) {
                    if (!graph.containsKey(instrbinop.r1)) {
                        graph.put(instrbinop.r1, new Arcs());
                    }
                    if (!graph.containsKey(instrbinop.r2)) {
                        graph.put(instrbinop.r2, new Arcs());
                    }
                    graph.get(instrbinop.r1).prefs.add(instrbinop.r2);
                    graph.get(instrbinop.r2).prefs.add(instrbinop.r1);

                    li.outs.forEach(o -> {
                        if (!o.equals(instrbinop.r2) && !o.equals(instrbinop.r1)) {
                            if (!graph.containsKey(o)) {
                                graph.put(o, new Arcs());
                            }
                            graph.get(o).intfs.add(instrbinop.r2);
                            graph.get(instrbinop.r2).intfs.add(o);
                        }
                    });
                }
            }
        });
        lg.info.values().forEach(li -> {
            if (!(li.instr instanceof ERmbinop && ((ERmbinop) li.instr).m == Mbinop.Mmov)) {
                li.defs.forEach(v -> {
                    li.outs.forEach(w -> {
                        if (!v.equals(w)) {
                            if (!graph.containsKey(w)) {
                                graph.put(w, new Arcs());
                            }
                            if (!graph.containsKey(v)) {
                                graph.put(v, new Arcs());
                            }
                            graph.get(v).intfs.add(w);
                            graph.get(w).intfs.add(v);
                        }
                    });

                });
            }
        });
    }

    void print() {
        System.out.println("interference:");
        for (Register r : graph.keySet()) {
            Arcs a = graph.get(r);
            System.out.println("  " + r + " pref=" + a.prefs + " intf=" + a.intfs);
        }
    }
}