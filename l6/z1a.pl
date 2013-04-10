empty([X]-X).
get([H|T]-X,H,T-X).
put(E,A-[X|B],A-B).
addAll(E,G,X-Y,X-Z):-
    findall(E,G,Y,Z).
