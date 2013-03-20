leaf.
% Nieprzetestowane
mirror(leaf,leaf).
mirror(node(TL,E,TR),node(TL1,E,TR1)) :-
    mirror(TL,TR1),
    mirror(TR,TL1).
% Flatten nieywdajny
flatten(leaf,[]).
flatten(node(L,E,P),R) :-
    append(R1,[E|R2],R),
    flatten(L,R1),!,
    flatten(P,R2).
% node(node(node(leaf,3,leaf),4,leaf),5,node(node(leaf,8,leaf),9,node(leaf,10,leaf))).
% node(node(node(leaf,a,leaf),b,node(node(leaf,c,leaf),d,node(leaf,e,leaf))),f,node(leaf,g,node(node(leaf,h,leaf),i,leaf)))
