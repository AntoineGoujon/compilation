package mini_c;

class FunctionError {
    static class UndefinedFunctionError extends Error {
        private static final long serialVersionUID = 1L;

        UndefinedFunctionError(String functionName, Loc l) {
            super("undefined reference to function '" + functionName + "' at " + l);
        }
    }

    static class RedefinitionError extends Error {
        private static final long serialVersionUID = 1L;

        RedefinitionError(String functionName, Loc l) {
            super("redefinition of function '" + functionName + "' at " + l);
        }
    }

    static class ParameterRedefinitionError extends Error {
        private static final long serialVersionUID = 1L;

        ParameterRedefinitionError(String paramName, Loc l) {
            super("redefinition of parameter '" + paramName + "' at " + l);
        }
    }

    static class InvalidArgumentNumber extends Error {
        private static final long serialVersionUID = 1L;

        InvalidArgumentNumber(String functionName, Loc l) {
            super("invalid argument number in function call '" + functionName + "' at " + l);
        }
    }

    static class InvalidArgumentType extends Error {
        private static final long serialVersionUID = 1L;

        InvalidArgumentType(String functionName, int nArg, Loc l) {
            super("incompatible type for argument " + nArg + " of '" + functionName + "' at " + l);
        }
    }

    static class ReturnTypeError extends Error {
        private static final long serialVersionUID = 1L;

        ReturnTypeError(Typ t1, Typ t2, Loc l) {
            super("incompatible types when returning type ‘" + t2 + "’ but ‘" + t1 + "’ was expected at " + l);
        }
    }
}

class StructError {
    static class UndefinedStructError extends Error {
        private static final long serialVersionUID = 1L;

        UndefinedStructError(String structName, Loc l) {
            super("undefined reference to struct '" + structName + "' at " + l);
        }
    }

    static class UndefinedMember extends Error {
        private static final long serialVersionUID = 1L;

        UndefinedMember(Typ structTyp, String m, Loc l) {
            super("'" + structTyp + "' has no member named '" + m + "' at " + l);
        }
    }

    static class RedefinitionError extends Error {
        private static final long serialVersionUID = 1L;

        RedefinitionError(String structName) {
            super("redefinition of 'struct " + structName + "'");
        }
    }

    static class DuplicateError extends Error {
        private static final long serialVersionUID = 1L;

        DuplicateError(String m, Loc l) {
            super("duplicate member '" + m + "' at " + l);
        }
    }
}

class IdentError {
    static class UndeclaredIdent extends Error {
        private static final long serialVersionUID = 1L;

        UndeclaredIdent(String identName, Loc l) {
            super("undeclared identifier '" + identName + "' at " + l);
        }
    }

    static class RedeclarationError extends Error {
        private static final long serialVersionUID = 1L;

        RedeclarationError(String identName, Loc l) {
            super("redeclaration of '" + identName + "' at " + l);
        }
    }
}

class OpError {
    static class UnopError extends Error {
        private static final long serialVersionUID = 1L;

        UnopError(Loc l) {
            super("wrong type argument to unary minus at " + l);
        }
    }

    static class InvalidOperands extends Error {

        private static final long serialVersionUID = 1L;

        InvalidOperands(Binop b, Typ t1, Typ t2, Loc l) {
            super("invalid operands to binary " + b + " (have ‘" + t1 + "’ and ‘" + t2 + "’) at " + l);
        }
    }

    static class InvalidAccess extends Error {

        private static final long serialVersionUID = 1L;

        InvalidAccess(Typ t, Loc l) {
            super("invalid type argument of ‘->’ (have ‘" + t + "’) at " + l);
        }
    }
}

class AssignmentError {
    static class LvalueError extends Error {
        private static final long serialVersionUID = 1L;

        LvalueError(Loc l) {
            super("lvalue required as left operand of assignment at " + l);
        }
    }

    static class IncompatibleType extends Error {
        private static final long serialVersionUID = 1L;

        IncompatibleType(Typ t1, Typ t2, Loc l) {
            super("incompatible types when assigning to type ‘" + t1 + "’ from type ‘" + t2 + "’ at " + l);
        }
    }

}