len([],0).
len([_],1) :- !.
len([_|T],Y) :-
   len(T,Y1),
   Y is Y1 + 1,
   !.
len([_|T],Y) :-
    Y1 is Y - 1,
    len(T,Y1),
    !.
