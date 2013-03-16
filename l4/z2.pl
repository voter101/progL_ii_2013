connection(warszawa,wroclaw).
connection(warszawa,zakopane).
connection(warszawa,kalingrad).
connection(warszawa,wloclawek).
connection(warszawa,koszalin).
connection(koszalin,kalingrad).
connection(koszalin,wloclawek).
connection(wroclaw,zakopane).
connection(wroclaw,wloclawek).
trip(From,To,List) :-
   trip(From,To,ListT,[]).
    reverse(ListT,List).
trip(X,X,List,Ac) :-
    append(Ac,[X],List).
trip(X,Y,List,Ac) :-
    \+member(X,Ac),
    append(Ac,[X],AcN),
    connection(X,Z),
    trip(Z,Y,List,[X|Ac]).
