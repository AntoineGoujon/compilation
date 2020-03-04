package mini_c;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

class LiveInfo {
    ERTL instr;
    Label[] succ; // successeurs
    Set<Label> pred; // prédécesseurs
    Set<Register> defs; // définitions
    Set<Register> uses; // utilisations
    Set<Register> ins; // variables vivantes en entrée
    Set<Register> outs; // variables vivantes en sortie

    LiveInfo(ERTL instr) {
        this.instr = instr;
        this.succ = instr.succ();
        this.defs = instr.def();
        this.uses = instr.use();
        this.pred = new HashSet<>();
        this.ins = new HashSet<>();
        this.outs = new HashSet<>();
    }

    void addPred(Label Lpred) {
        this.pred.add(Lpred);
    }

    void in() {
        this.ins = new HashSet<>();
        this.ins.addAll(this.outs);
        this.ins.removeAll(this.defs);
        this.ins.addAll(this.uses);
    }

    void out(Map<Label, LiveInfo> info) {
        this.outs = new HashSet<>();
        for (Label L: this.succ) {
            this.outs.addAll(info.get(L).ins);
        }
    }

    @Override
    public String toString() {
        return instr.toString()
                + " d=" + this.defs.toString()
                + " u=" + this.uses.toString()
                + " i=" + this.ins.toString()
                + " o=" + this.outs.toString();
    }
}

class Liveness {

    Map<Label, LiveInfo> info;

    Liveness(ERTLgraph g) {
        info = new HashMap<>();

        g.graph.entrySet().forEach(entry -> {
            Label L = entry.getKey();
            ERTL instr = entry.getValue();
            info.put(L, new LiveInfo(instr));
        });

        g.graph.entrySet().forEach(entry -> {
            Label Lpred = entry.getKey();
            for (Label L : entry.getValue().succ()) {
                info.get(L).addPred(Lpred);
            }
        });

        // Kildall Algorithm
        LinkedList<LiveInfo> WS = new LinkedList<>(info.values());
        while (WS.size() > 0) {
            LiveInfo l = WS.pop();
            Set<Register> oldIns = l.ins;
            l.out(info);
            l.in();
            if (!l.ins.equals(oldIns)) {
                l.pred.forEach(Lpred -> {
                    WS.add (info.get(Lpred));
                });
            }
        }
    }

    private void print(Set<Label> visited, Label l) {
        if (visited.contains(l))
            return;
        visited.add(l);
        LiveInfo li = this.info.get(l);
        System.out.println("  " + String.format("%3s", l) + ": " + li);
        for (Label s : li.succ)
            print(visited, s);
    }

    void print(Label entry) {
        print(new HashSet<Label>(), entry);
    }

}
