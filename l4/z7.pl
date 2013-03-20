revall(X,R) :-
    revall(X,R,[]).
revall([],R,R):- !.
revall([H|T],X,Ac) :-
    H = [_|_],
    revall(H,H1),!,
    revall(T,X,[H1|Ac]).
revall([H|T],X,Ac) :-
    revall(T,X,[H|Ac]).
