conn(warszawa,wroclaw).
conn(warszawa,zakopane).
conn(warszawa,kalingrad).
conn(warszawa,wloclawek).
conn(warszawa,koszalin).
conn(koszalin,kalingrad).
conn(koszalin,wloclawek).
conn(wroclaw,zakopane).
conn(wroclaw,wloclawek).
conn(wroclaw,warszawa).

trip(From,To,[From|T]) :-
    trip(From,To,T,[To]).
trip(X,Y,Ac,Ac) :- 
    conn(X,Y).
trip(X,Y,List,Ac) :-
    conn(Z,Y),
    \+member(Z,Ac),
    \+(X==Z),
    trip(X,Z,List,[Z|Ac]).
