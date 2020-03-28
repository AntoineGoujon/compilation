package mini_c;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class ColoringGA extends Coloring {

    private int K = Register.allocatable.size(); // nombre de couleurs; nombre de registres physiques
    boolean cond = false;

    ColoringGA(Interference ig) {
        colors = simplify(ig);
    }

    Map<Register, Operand> simplify(Interference ig) {
        int minimalDegree = Integer.MAX_VALUE;
        Register vMinimalDegree = null;
        for (Map.Entry<Register, Arcs> entry : ig.graph.entrySet()) {
            if (!Register.allocatable.contains(entry.getKey())) {
                Register v = entry.getKey();
                Arcs arcs = entry.getValue();
                int degree = arcs.intfs.size();
                if (degree < minimalDegree) {
                    minimalDegree = degree;
                    vMinimalDegree = null;
                }
                if ((degree == minimalDegree) && (degree < K) && (arcs.prefs.size() == 0)) {
                    vMinimalDegree = v;
                }
            }
        }
        if (vMinimalDegree != null) {
            return select(ig, vMinimalDegree);
        } else {
            return coalesce(ig);
        }
    }

    Map<Register, Operand> coalesce(Interference ig) {
        Register v1 = null, v2 = null;
        ArrayList<Register> ar = new ArrayList<>(ig.graph.keySet());
        boolean george = false;
        for (int i = 0; i < ar.size(); i++) {
            for (int j = i + 1; j < ar.size(); j++) {
                v1 = ar.get(i);
                v2 = ar.get(j);
                if (ig.graph.get(v1).prefs.contains(v2) && !ig.graph.get(v1).intfs.contains(v2)) {
                    if (v1.isPseudo() || v2.isPseudo()) {
                        if (checkGeorge(ig, v1, v2)) {
                            george = true;
                            break;
                        }
                    }
                }
            }
            if (george) {
                break;
            }
        }
        if (george) {
            if (v1.isHW()) {
                // on swappe v1 et v2
                Register rtmp = v2;
                v2 = v1;
                v1 = rtmp;
            }
            fuse(ig, v1, v2);
            Map<Register, Operand> c = simplify(ig);
            c.put(v1, c.get(v2));
            return c;
        } else {
            return freeze(ig);
        }
    }

    Map<Register, Operand> freeze(Interference ig) {
        int minimalDegree = Integer.MAX_VALUE;
        Register vMinimalDegree = null;
        for (Map.Entry<Register, Arcs> entry : ig.graph.entrySet()) {
            if (!Register.allocatable.contains(entry.getKey())) {
                Register v = entry.getKey();
                Arcs arcs = entry.getValue();
                int degree = arcs.intfs.size();
                if (degree < minimalDegree) {
                    minimalDegree = degree;
                    vMinimalDegree = null;
                }
                if ((degree == minimalDegree) && (degree < K)) {
                    vMinimalDegree = v;
                }

            }
        }
        if (vMinimalDegree != null) {
            for (Register pref : ig.graph.get(vMinimalDegree).prefs) {
                ig.graph.get(pref).prefs.remove(vMinimalDegree);
            }
            ig.graph.get(vMinimalDegree).prefs = new HashSet<>();
            return simplify(ig);
        } else {
            return spill(ig);
        }
    }

    Map<Register, Operand> spill(Interference ig) {
        HashSet<Register> nextPossibleVs = new HashSet<>();
        nextPossibleVs.addAll(ig.graph.keySet());
        nextPossibleVs.removeAll(Register.allocatable);
        if (nextPossibleVs.size() == 0) {
            Map<Register, Operand> c = new HashMap<>();
            Register.allocatable.forEach(allocReg -> {
                c.put(allocReg, new Reg(allocReg));
            });
            return c;
        } else {
            // choisit un sommet de cout minimal
            Register vMinimalCost = null; // TODO: be sure not to have null here
            double minimalCost = Double.MAX_VALUE;
            for (Register possibleV : nextPossibleVs) {
                // TODO: compute better cost
                double cost = 1.0 / ((double) ig.graph.get(possibleV).intfs.size());
                if (cost < minimalCost) {
                    vMinimalCost = possibleV;
                    minimalCost = cost;
                }
            }
            return select(ig, vMinimalCost);
        }
    }

    Map<Register, Operand> select(Interference ig, Register v) {

        // supprimer le sommet v de ig
        Arcs vArcs = ig.graph.get(v);
        ig.graph.remove(v);
        ig.graph.values().forEach(uArcs -> {
            uArcs.intfs.remove(v);
            uArcs.prefs.remove(v);
        });

        Map<Register, Operand> c = simplify(ig);

        Set<Register> potentialColors = new HashSet<>();
        potentialColors.addAll(Register.allocatable);
        vArcs.intfs.forEach(vintf -> {
            if (c.containsKey(vintf) && c.get(vintf) instanceof Reg) {
                potentialColors.remove(((Reg) c.get(vintf)).r);
            }
        });
        if (potentialColors.size() > 0) {
            c.put(v, new Reg(potentialColors.iterator().next()));
        } else {
            nlocals += 1;
            c.put(v, new Spilled(-8 * nlocals));
        }
        return c;
    }

    void fuse(Interference ig, Register v1, Register v2) {
        Arcs v1arcs = ig.graph.get(v1);
        v1arcs.intfs.forEach(v1Intfs -> {
            ig.graph.get(v1Intfs).intfs.remove(v1);
            if (!v1Intfs.equals(v2)) {
                ig.graph.get(v1Intfs).intfs.add(v2);
            }

        });
        v1arcs.prefs.forEach(v1Prefs -> {
            ig.graph.get(v1Prefs).prefs.remove(v1);
            if (!v1Prefs.equals(v2)) {
                ig.graph.get(v1Prefs).prefs.add(v2);
            }

        });
        ig.graph.remove(v1);
        ig.graph.get(v2).intfs.addAll(v1arcs.intfs);
        ig.graph.get(v2).prefs.addAll(v1arcs.prefs);
        ig.graph.get(v2).prefs.remove(v2);
        ig.graph.get(v2).intfs.remove(v2);
    }

    boolean checkGeorge(Interference ig, Register v1, Register v2) {
        if (v2.isPseudo()) {
            for (Register v1Neighbor : ig.graph.get(v1).intfs) {
                if (v1Neighbor.isHW() || ig.graph.get(v1Neighbor).intfs.size() >= K) {
                    if (!ig.graph.get(v2).intfs.contains(v1Neighbor)) {
                        return false;
                    }
                }
            }
        } else {
            for (Register v1Neighbor : ig.graph.get(v1).intfs) {
                if (v1Neighbor.isPseudo() || ig.graph.get(v1Neighbor).intfs.size() >= K) {
                    if (!ig.graph.get(v2).intfs.contains(v1Neighbor)) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}