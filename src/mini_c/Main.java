package mini_c;

import java.io.IOException;
import java.io.InputStream;

public class Main {

  static boolean parse_only = false;
  static boolean type_only = false;
  static boolean interp_rtl = false;
  static boolean interp_ertl = false;
  static boolean interp_ltl = false;
  static boolean debug = false;
  static boolean optimizeRecTailCalls = false;
  static boolean optimizeSM = false;
  static boolean optimize = false;

  static String file = null;

  static void usage() {
    System.err.println("mini-c [--parse-only] [--type-only] file.c");
    System.exit(1);
  }

  public static void main(String[] args) throws Exception {
    for (String arg : args)
      if (arg.equals("--parse-only"))
        parse_only = true;
      else if (arg.equals("--type-only"))
        type_only = true;
      else if (arg.equals("--interp-rtl"))
        interp_rtl = true;
      else if (arg.equals("--interp-ertl"))
        interp_ertl = true;
      else if (arg.equals("--interp-ltl"))
        interp_ltl = true;
      else if (arg.equals("--debug"))
        debug = true;
      else if (arg.equals("--optimize-rec-tailcalls"))
        optimizeRecTailCalls = true;
      else if (arg.equals("--optimize-sm"))
        optimizeRecTailCalls = true;
      else if (arg.equals("--optimize")) {
        optimizeRecTailCalls = true;
        optimizeSM = true;
      } else {
        if (file != null)
          usage();
        if (!arg.endsWith(".c"))
          usage();
        file = arg;
      }
    if (file == null)
      usage();

    java.io.Reader reader = new java.io.FileReader(file);
    Lexer lexer = new Lexer(reader);
    MyParser parser = new MyParser(lexer);
    Pfile f = (Pfile) parser.parse().value;
    if (parse_only)
      System.exit(0);
    Typing typer = new Typing();
    typer.visit(f);
    File tf = typer.getFile();
    if (type_only)
      System.exit(0);
    RTLfile rtl = (new ToRTL()).translate(tf);
    if (debug)
      rtl.print();
    if (interp_rtl) {
      new RTLinterp(rtl);
      System.exit(0);
    }
    ERTLfile ertl = (new ToERTL()).translate(rtl);
    if (debug)
      ertl.print();
    if (interp_ertl) {
      new ERTLinterp(ertl);
      System.exit(0);
    }
    // Debug Kildall
    if (debug) {
      ertl.funs.forEach(fun -> {

        Coloring colored = new ColoringGA(new Interference(new Liveness(fun.body)));
        colored.print();
        Coloring colored2 = new ColoringNaive(new Interference(new Liveness(fun.body)));
        colored2.print();

        System.exit(0);

      });
    }
    LTLfile ltl = (new ToLTL()).translate(ertl);
    if (debug)
      ltl.print();
    if (interp_ltl) {
      new LTLinterp(ltl);
      System.exit(0);
    }
    X86_64 asm = (new Lin()).translate(ltl);
    asm.printToFile(file.substring(0, file.length() - 1) + "s");
  }

}
