% Pracownia oceniona na 40/50. Program dziala bardzo wolno.

%%%%   Programowanie (L) 2013 - Pracownia 
%  
%  Wiktor Mociun, nr. indeksu: 258354
%
%         Pracownia nr.1, wersja 4:  "Stawy i Groble"
%
%  Uwaga: Komentarze do kodu są w j. angielsku, ponieważ kod programu także jest
%         w tym języku.
%  Uwaga: Program działa tylko na SWI-Prologu (testowany na v.5.10.4), w związku
%         z użyciem zaimplementowanych w prologu list asocjacyjnych (lib assoc)
%  Link: http://www.swi-prolog.org/pldoc/doc_for?object=section%282,%27A.3%27,swi%28%27/doc/Manual/assoc.html%27%29%29
%  Uwaga: Program może nieco dziwacznie operować na osiach współrzędnych, ale
%         to wynika z mojego niedopatrzenia i jest to oznaczone w odpowiednich
%         miejscach kodu
%
%  Słownik:
%   pond - staw
%   dike - grobla
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Solution idea:
%  1) Generate candidate for a result (pond set), pond by pond. Check if ponds 
%     don't overlap on each other.
%  2) Check if:
%      a) there is no 2x2 dike square on a board,
%      b) dikes create consistent path.
%     If any of these conditions isn't satisfied - generate another pond set. 
%  3) If there is any pond set that passed 2), return it. In other case solution
%     doesn't exist.
%
% Implementation:
%  I store information about pond fields (fields that belongs to one of the
%  ponds on board) in association list (called AssocList). If there's no 
%  value set for field [X,T], it must be a dike.
%
%  Board size is 'global' and stored in asserted size predicate. It is much more
%  convenient for me, to do so.
%  
%  WARNING!!! Because of assertion of 'size' predicated, user must retract it 
%             before second use of base predicate!
%
% Naming:
%   A | Acc - Accumulator
%   R - Result
%   AssocList - Association list
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% --=== SECTION: Program running ==---
%
% I use solution asserting to prevent answer duplication

stawy(Input,Result) :-
    open(Input,read,Stream),
    readFromFile(Stream,[Y,X,CheckUnsorted]),
    assertz(size(X,Y)),
    assertz(solutions(-1)), % 'Undefined procedure' protection
    generateCandidate(CheckUnsorted,1,t,R1),
    noDikeSquare(R1),
    isDikeConsistent(R1),
    buildResult(R1,Result),
    \+solutions(Result),
    assertz(solutions(Result)).

%% --=== SECTION: Generating candidates for a result ==---

generateCandidate([],_,R,R).
generateCandidate([H|T],PondID,A,R) :-
    % Reverse Y with X
    H = (Y,X,Size),
    generatePond(X,Y,PondID,Size,[],A,R1,Size),
    PondID1 is PondID + 1,
    generateCandidate(T,PondID1,R1,R).


%% --=== SECTION: Single pond generation ===--
%
% Ponds are generated using BFS algorithm.
%
% Each pond has it's own ID number.
% 'Display' is graphical field representation on a board (*, number or '_')

generatePond(_,_,_,0,_,R,R,_).
generatePond(X,Y,PondID,FieldsLeft,Buffer,AssocList,ResultAssoc,Display) :-
    FieldsLeft > 0,
    \+get_assoc([X,Y],AssocList,_),
    noNeighbours(X,Y,PondID,AssocList),
    put_assoc([X,Y],AssocList,[Display,PondID], AssocList1),
    X1 is X + 1, X2 is X - 1,
    Y1 is Y + 1, Y2 is Y - 1,
    FieldsLeft1 is FieldsLeft - 1,
    addField(X1,Y,Buffer,Buffer1),
    addField(X2,Y,Buffer1,Buffer2),
    addField(X,Y1,Buffer2,Buffer3),
    addField(X,Y2,Buffer3,Buffer4),
    pop([XN,YN],Buffer4,Buffer5),
    generatePond(XN,YN,PondID,FieldsLeft1,Buffer5,AssocList1,ResultAssoc,'_').
generatePond(_,_,PondID,FieldsLeft,Buffer,AssocList,ResultAssoc,Display) :-
    FieldsLeft > 0, 
    pop([XN,YN],Buffer,Buffer1),
    generatePond(XN,YN,PondID,FieldsLeft,Buffer1,AssocList,ResultAssoc,Display).
    
% Adding pond field candidate to a buffer
addField(X,Y,Buffer,ResultBuffer) :-
    size(XMax,YMax),
    between(1,XMax,X),between(1,YMax,Y),
    push([X,Y],Buffer,ResultBuffer).
addField(X,Y,R,R) :- % Field size restriction
    size(XMax,YMax),
    (\+between(1,XMax,X);\+between(1,YMax,Y)).

% True if field hasn't any neighbours with another Pond ID number.
noNeighbours(X,Y,PondID,AssocList) :-
    X1 is X + 1, X2 is X - 1,
    Y1 is Y + 1, Y2 is Y - 1,
    % If field [Xn,Yn] is on assoc list it must have specified pond ID number
    (get_assoc([X1,Y],AssocList,[_,E1]) -> E1==PondID ;
        \+get_assoc([X1,Y],AssocList,_)),
    (get_assoc([X2,Y],AssocList,[_,E2]) -> E2==PondID ;
        \+get_assoc([X2,Y],AssocList,_)),
    (get_assoc([X,Y1],AssocList,[_,E3]) -> E3==PondID ;
        \+get_assoc([X,Y1],AssocList,_)),
    (get_assoc([X,Y2],AssocList,[_,E4]) -> E4==PondID ;
        \+get_assoc([X,Y2],AssocList,_)).

%% --=== SECTION: Checking correctness of generated pond set ===--

% Checking if there's no 2x2 dike square on board
noDikeSquare(AssocList) :-
    size(X,Y),
    noDikeSquare(X,Y,AssocList),!.
noDikeSquare(1,2,_).
noDikeSquare(1,Y,AssocList) :-
    Y > 2,
    Y1 is Y - 1,
    size(X,_),
    noDikeSquare(X,Y1,AssocList).
noDikeSquare(X,Y,AssocList) :-
    X > 1, Y > 1,
    X1 is X - 1, Y1 is Y - 1,
    % If all 4 fields aren't checked, fail.
    ((get_assoc([X,Y],AssocList,_);
     get_assoc([X1,Y],AssocList,_);
     get_assoc([X,Y1],AssocList,_);
     get_assoc([X1,Y1],AssocList,_)) -> noDikeSquare(X1,Y,AssocList); fail).

% Dike Consistency check:
%  1) Generate list of all dikes on board.
%  2) Pick first dike from dike list and remove it from this list.
%  3) Go wherever you can (you can go only to points that are on dike list). 
%     If you go to any point - remove it from dike list.
%  Dike is consistent only when dike list is empty after point 3.
isDikeConsistent(AssocList) :-
    size(X,Y),
    buildDikeList(X,Y,DikeList,[],AssocList),!,
    goDikeGo(DikeList).

buildDikeList(0,1,R,R,_).
buildDikeList(0,Y,R,Acc,AssocList) :-
    Y > 1,
    size(X,_),
    Y1 is Y - 1,
    buildDikeList(X,Y1,R1,[],AssocList),
    append(Acc,R1,R).
buildDikeList(X,Y,R,Acc,AssocList) :-
    X > 0, Y > 0,
    X1 is X - 1,
    get_assoc([X,Y],AssocList,_),
    buildDikeList(X1,Y,R,Acc,AssocList).
buildDikeList(X,Y,R,Acc,AssocList) :-
    X > 0, Y > 0,
    X1 is X - 1,
    \+get_assoc([X,Y],AssocList,_),
    buildDikeList(X1,Y,R,[[X,Y]|Acc],AssocList).

goDikeGo([]).
goDikeGo([[X,Y]|T]) :-
    goDikeGo(X,Y,[[X,Y]|T],[]),!.
goDikeGo(_,_,[],[]).
goDikeGo(X,Y,DikeList,DikeList6) :-
    size(XMax,YMax),
    between(1,XMax,X),between(1,YMax,Y),
    select([X,Y],DikeList,DikeList2),
    X1 is X + 1,X2 is X - 1,
    Y1 is Y + 1,Y2 is Y - 1,
    goDikeGo(X,Y1,DikeList2,DikeList3),
    goDikeGo(X,Y2,DikeList3,DikeList4),
    goDikeGo(X1,Y,DikeList4,DikeList5),
    goDikeGo(X2,Y,DikeList5,DikeList6).
goDikeGo(_,_,D,D).


%% --=== SECTION: Preparing result to return ===---

% Creates board - line by line
buildResult(AssocList,Result) :-
    size(X,Y),
    buildResult(X,Y,R,[],AssocList),!,
    finalResult(R,Result).

buildResult(0,1,[Acc|_],Acc,_).
buildResult(0,Y,[Acc|R],Acc,AssocList) :-
    Y > 1,
    size(X,_),
    Y1 is Y-1,
    buildResult(X,Y1,R,[],AssocList).
buildResult(X,Y,R,Acc,AssocList) :-
    Y > 0, X > 0,
    \+get_assoc([X,Y],AssocList,_),
    X1 is X - 1,
    buildResult(X1,Y,R,['*'|Acc],AssocList).
buildResult(X,Y,R,Acc,AssocList) :-
    Y > 0, X > 0,
    get_assoc([X,Y],AssocList,[E,_]),
    X1 is X - 1,
    buildResult(X1,Y,R,[E|Acc],AssocList).

% Cleans 1-element from a board and reverse Y-axis.
finalResult(List,Result) :-
    reverse(List,Result),!.


%% --=== SECTION: Utils ===--

% FIFO - used for buffers at single pond generation
push(E,T,T1) :-
    append(T,[E],T1).
pop(E,[E|T],T).

% Read file line-by-line and place it in a list
readFromFile(Stream,[]) :-
    at_end_of_stream(Stream).
readFromFile(Stream,[H|T]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,H),
    readFromFile(Stream,T).
