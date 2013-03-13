% Wersja chyba poprawna - nieprzetestowana
len([],[]).
len([H|T],[H1|T1]) :-
    len(T,T1).

reverse(X,Y) :-
    len(X,Y),
    reverse(X,[],Y).

reverse([],A,A).
reverse([H|T],A,Y) :-
    reverse(T,[H|A],Y).
