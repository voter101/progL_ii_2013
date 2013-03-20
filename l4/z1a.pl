% Nie działa dla dwóch nieukonkretnionych zmiennych
len(X,L) :-
    len(X,L,0).
len([],X,X) :- !.
len([_|T],L,A) :-
    A1 is A + 1,
    len(T,L,A1). 
