package mini_c;

import java.util.Map;
import java.util.HashMap;

abstract class Coloring {
    Map<Register, Operand> colors = new HashMap<>();
    int nlocals = 0; // nombre d'emplacements sur la pile

    void print() {
        System.out.println("coloring output:");
        for (Register r : colors.keySet()) {
            Operand o = colors.get(r);
            System.out.println("  " + r + " --> " + o);
        }
    }
}