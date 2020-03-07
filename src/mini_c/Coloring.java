package mini_c;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Coloring {
    Map<Register, Operand> colors = new HashMap<>();
    int nlocals = 0; // nombre d'emplacements sur la pile

    private Map<Register, Set<Register>> todo;

    Coloring(Interference ig) {
        todo = new HashMap<>();
        Register.allocatable.forEach(allocReg -> {
            colors.put(allocReg, new Reg(allocReg));
        });

        ig.graph.forEach((v, e) -> {
            if (!Register.allocatable.contains(v)) {
                Set<Register> colors = new HashSet<>();
                colors.addAll(Register.allocatable);
                colors.removeAll(e.intfs);
                todo.put(v, colors);
            }
        });

        while (!todo.isEmpty()) {
            Register r = this.popNext(ig);
            if (r != null) {
                Register color = todo.get(r).iterator().next(); //TODO select preference first
                colors.put(r, new Reg(color));
                ig.graph.get(r).intfs.forEach(interf -> {
                    if (todo.containsKey(interf)) {
                        todo.get(interf).remove(color);
                    }
                });
            } else {
                r = todo.keySet().iterator().next();
                nlocals += 1;
                colors.put(r, new Spilled(-8*nlocals)); // TODO check pos / rbp
            }
            todo.remove(r);
        }
    }

    Register popNext(Interference ig) {
        // un registre avec une seule couleur possible,
        // pour lequel on a une arête de préférence vers cette couleur
        for (Map.Entry<Register, Set<Register>> entry : todo.entrySet()) {
            if (entry.getValue().size() == 1) {
                Register color = entry.getValue().iterator().next();
                for (Register pref : ig.graph.get(entry.getKey()).prefs) {
                    if (colors.containsKey(pref)) {
                        Operand o = colors.get(pref);
                        if (o instanceof Reg) {
                            Reg re = (Reg) o;
                            if (re.r.equals(color)) {
                                return entry.getKey();
                            }
                        }
                    }
                }
            }
        }
        // un registre avec une seule couleur possible,
        for (Map.Entry<Register, Set<Register>> entry : todo.entrySet()) {
            if (entry.getValue().size() == 1) {
                return entry.getKey();
            }
        }
        // un registre avec une préférence dont la couleur est connue
        for (Map.Entry<Register, Set<Register>> entry : todo.entrySet()) {
            if (entry.getValue().size() >= 1) {
                for (Register pref : ig.graph.get(entry.getKey()).prefs) {
                    if (colors.containsKey(pref)) {
                        return entry.getKey();
                    }
                }
            }
        }
        // un registre avec au moins une couleur possible
        for (Map.Entry<Register, Set<Register>> entry : todo.entrySet()) {
            if (entry.getValue().size() >= 1) {
                return entry.getKey();
            }
        }
        return null;
    }

    void print() {
        System.out.println("coloring output:");
        for (Register r : colors.keySet()) {
            Operand o = colors.get(r);
            System.out.println("  " + r + " --> " + o);
        }
    }
}