package mini_c;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class ColoringGAcopy extends Coloring {

    private int K = Register.allocatable.size(); // nombre de couleurs; nombre de registres physiques
    private Map<Register, Set<Register>> potentialColors;

    ColoringGAcopy(Interference ig) {
        ig.graph.forEach((v, e) -> {
            if (!Register.allocatable.contains(v)) {
                Set<Register> pcolors = new HashSet<>();
                pcolors.addAll(Register.allocatable);
                pcolors.removeAll(e.intfs);
                potentialColors.put(v, pcolors);
            } else {
                Set<Register> pcolors = new HashSet<>();
                pcolors.add(v);
                potentialColors.put(v, pcolors);
            }
        });
        simplify(ig);
        // colors.forEach((r, op) -> {
        // if (op instanceof Reg) {
        // // if (ig.graph.get(r).intfs.contains(((Reg)op).r))
        // // throw new Error("1");
        // if (graphinit.get(r).intfs.contains(((Reg)op).r))
        // throw new Error("2");
        // }
        // if (op instanceof Spilled) {
        // System.out.println("spilled" + r.name + " " + ((Spilled)op).n);
        // }
        // });
    }

    void simplify(Interference ig) {
        int minimalDegree = Integer.MAX_VALUE;
        Register vMinimalDegree = null;
        for (Map.Entry<Register, Arcs> entry : ig.graph.entrySet()) {
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
        if (vMinimalDegree != null) {
            select(ig, vMinimalDegree);
        } else {
            coalesce(ig);
        }
    }

    void coalesce(Interference ig) {
        // Register v1 = null, v2 = null;
        // ArrayList<Register> ar = new ArrayList<>(ig.graph.keySet());
        // boolean george = false;
        // for (int i = 0; i < ar.size(); i++) {
        // for (int j = i + 1; j < ar.size(); j++) {
        // v1 = ar.get(i);
        // v2 = ar.get(j);
        // if (ig.graph.get(v1).prefs.contains(v2) &&
        // !ig.graph.get(v1).intfs.contains(v2)) {

        // if (checkGeorge(ig, v1, v2)) {
        // george = true;
        // break;
        // }
        // }
        // }
        // if (george) {
        // break;
        // }
        // }
        // if (george && !(colors.containsKey(v1) && colors.containsKey(v2)) && false) {
        // if (colors.containsKey(v1)) {
        // // on swappe v1 et v2
        // Register rtmp = v2;
        // v2 = v1;
        // v1 = rtmp;
        // }
        // fuse(ig, v1, v2);
        // simplify(ig);
        // colors.put(v1, colors.get(v2));
        // } else {
        freeze(ig);
        // }
    }

    void freeze(Interference ig) {
        int minimalDegree = Integer.MAX_VALUE;
        Register vMinimalDegree = null;
        for (Map.Entry<Register, Arcs> entry : ig.graph.entrySet()) {
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
        if (vMinimalDegree != null) {
            for (Register pref : ig.graph.get(vMinimalDegree).prefs) {
                ig.graph.get(pref).prefs.remove(vMinimalDegree);
            }
            ig.graph.get(vMinimalDegree).prefs = new HashSet<>();
            simplify(ig);
        } else {
            spill(ig);
        }
    }

    void spill(Interference ig) {
        if (ig.graph.size() == 0) {
            colors = new HashMap<>();
            Register.allocatable.forEach(allocReg -> {
                colors.put(allocReg, new Reg(allocReg));
            });
        } else {
            Register vMinimalCost = null;
            double minimalCost = Double.MAX_VALUE;
            for (Map.Entry<Register, Arcs> entry : ig.graph.entrySet()) {
                Register v = entry.getKey();
                Arcs arcs = entry.getValue();
                double cost = 1.0 / ((double) arcs.intfs.size());
                if (cost < minimalCost) {
                    vMinimalCost = v;
                    minimalCost = cost;
                }
            }
            select(ig, vMinimalCost);
        }
    }

    void select(Interference ig, Register v) {
        Arcs vArcs = ig.graph.get(v);
        ig.graph.remove(v);
        ig.graph.values().forEach(uArcs -> {
            uArcs.intfs.remove(v);
            uArcs.prefs.remove(v);
        });

        simplify(ig);
        if (colors.containsKey(v)) {
            return;
        }
        Set<Register> possibleColors = new HashSet<>();
        possibleColors.addAll(Register.allocatable);
        vArcs.intfs.forEach(u -> {
            if (colors.containsKey(u) && colors.get(u) instanceof Reg) {
                possibleColors.remove(((Reg) colors.get(u)).r);
            }
        });
        if (possibleColors.size() != 0) {
            Register color = possibleColors.iterator().next();
            colors.put(v, new Reg(color));
        } else {
            nlocals += 1;
            colors.put(v, new Spilled(-8 * nlocals));
        }
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