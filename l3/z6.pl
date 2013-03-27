% Wersja trollerska, ale treść zadania nie doprecyzowała co mamy zrobić :>
reverse(X,Y) :-
    reverse(X,[],Y),!.

reverse([],A,A).
reverse([H|T],A,Y) :-
    reverse(T,[H|A],Y).
