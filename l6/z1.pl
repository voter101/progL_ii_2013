put(E,[H|T],[E,H|T]).
get([H|T],H,T).
empty().
empty([]).
addall(E,G,S,R) :-
    findall(E,G,R1),
    reverse(R1,R2),
    putAll(R2,S,R).
putAll([],R,R).
putAll([H|T],S,R) :-
    put(H,S,S1),
    putAll(T,S1,R).
