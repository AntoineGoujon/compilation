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
        if (cond) {
            return select(ig, null);
        } else {
            return coalesce(ig);
        }
    }

    Map<Register, Operand> coalesce(Interference ig) {
        if (cond) {
            return null;
        } else {
            return freeze(ig);
        }
    }

    Map<Register, Operand> freeze(Interference ig) {
        if (cond) {
            return null;
        } else {
            return spill(ig);
        }
    }

    Map<Register, Operand> spill(Interference ig) {
        if (ig.graph.size() == 0) {
            Map<Register, Operand> c = new HashMap<>();
            Register.allocatable.forEach(allocReg -> {
                c.put(allocReg, new Reg(allocReg));
            });
            return c;
        } else {
            // choisit un sommet de cout minimal
            Register v = ig.graph.keySet().iterator().next();
            return select(ig, v);
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
        if (c.containsKey(v)) {
            return c;
        }
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
            colors.put(v, new Spilled(-8 * nlocals));
        }
        return c;
    }
}