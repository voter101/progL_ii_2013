ex(A) --> sex(A).
ex(star(A,B)) --> ex2(A),"*",sex(B),!.
ex2(A) --> sex(A).
ex2(star(A,B)) --> sex(A), "*", ex2(B).
sex(a) --> "a",!.
sex(b) --> "b",!.
sex(A) --> "(",ex(A),")".
