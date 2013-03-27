merge([],X,X) :- !.
merge(X,[],X) :- !.
merge([H1|T1],[H2|T2],[H1|T]) :-
    H1 =< H2,!,
    merge(T1,[H2|T2],T). 
merge([H1|T1],[H2|T2],[H2|T]) :-
    merge([H1|T1],T2,T).

merge_sort([],[]) :- !.
merge_sort([X],[X]) :- !.
merge_sort(S,T) :-
    halve(S,SL,SR),
    merge_sort(SL,TL),
    merge_sort(SR,TR),
    merge(TL,TR,T).

halve(X,L,R) :- halve(X,X,L,R).
halve(R,[],[],R) :- !.
halve(R,[_],[],R) :- !.
halve([H|T],[_,_|X],[H|L],R) :- halve(T,X,L,R).
