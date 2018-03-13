% Query to save the output into a file
saveRoute(Routes,File) :-
    open(File,write,Stream),
    writeList(Routes,Stream),
    close(Stream).

% Returns the head of a list
getListHead([H|_],H).

% The main method to return the list of the path
findRoute(X) :-
    write("Clean Up..."),nl,
    retractall(tree(_,_)),
    write("Sorting Pools West to East..."),nl,
    sortPoolsWestEast(SortedPools),
    write("Developing the Tree, this part takes a while let it run..."),nl,
    findChildren(SortedPools,SortedPools),
    getListHead(SortedPools,Head),
    write("Traversing the tree..."),nl,
    traverseInit(Head,TreeOrder),
    write("Developing the path..."),nl,
    runRoute(TreeOrder,PathList),
    X = PathList.

% Goes through the list and adds the distance between each step of the way
runRoute([H|T],X) :-
    runRoute(T,H,0,X1),
    append([(H,0.0)],X1,X2),
    X = X2.
runRoute([],_,_,[]).
runRoute([H|T],PrevPool,CurrDist,X) :-
    poolDistance(PrevPool,H,Dist),
    CurrDist2 is CurrDist+Dist,
    runRoute(T,H,CurrDist2,X1),
    append([(H,CurrDist2)],X1,X2),
    X = X2.

% Writes the list to a file Stream
writeList([],_).
writeList([H|T],Stream) :-
    write(Stream,H),nl(Stream),
    writeList(T,Stream).

% Go through the tree and generate the traversal list
traverseInit(Parent,X):-
    tree(Parent,Children),
    traverse(Children,X1),
    append([Parent],X1,X2),
    X = X2.
traverse([],[]).
traverse([H|T],X) :-
    tree(H,Children),
    traverse(Children,X1),
    append([H],X1,X2),
    traverse(T,X3),
    append(X2,X3,X4),
    X = X4.

% Generates the tree
findChildren(_,[]).
findChildren(SortedPools,[H|T]) :-
    findChildren(SortedPools,SortedPools,H,X),
    assertz(tree(H,X)),
    findChildren(SortedPools,T).
findChildren(_,[],_,[]).
findChildren(SortedPools,[H|T],Parent,X) :-
    findChildren(SortedPools,T,Parent,X1),
    findMinimum(SortedPools,H,X2),
    (=(X2,Parent) -> append([H],X1,X3)
    ;    append([],X1,X3)),
    X = X3.

% Checks to see which pool is the closest pool to H
findMinimum([H|_],H,nil).
findMinimum([H|T],Dest,X) :-
    findMinimum(T,Dest,H1),
    poolDistance(H,Dest,Dist),
    poolDistance(H1,Dest,Dist1),
    (Dist =< Dist1 -> X = H
    ;   X = H1).
    
% Distance Calculation between two inputted pools
poolDistance(nil,_,1000).
poolDistance(P1,P2,Dist) :-
    pool(P1,Lat1,Lon1),
    pool(P2,Lat2,Lon2),
    LatRad1 is (Lat1*pi)/180,
    LonRad1 is (Lon1*pi)/180,
    LatRad2 is (Lat2*pi)/180,
    LonRad2 is (Lon2*pi)/180,
    LatPart is sin((LatRad1-LatRad2)/2) ** 2,
    LonPart is sin((LonRad1-LonRad2)/2) ** 2,
    InnerPart is LatPart + (cos(LatRad1)*cos(LatRad2)*LonPart),
    DRad is 2*asin(sqrt(InnerPart)),
    Dist is DRad * 6371.0.
    

% Sorts the pools from West, East
sortPoolsWestEast(X) :-
    poolList(List),
    predsort(my_comp, List, X).

% Custom comparator to help sort the pools
my_comp(Comp, W1, W2) :-
    pool(W1,Lat1,_),
    pool(W2,Lat2,_),
    (   Lat1 < Lat2 -> Comp = '<'
    ;   Lat1 > Lat2 -> Comp = '>'
    ;   Lat1 =:= Lat2 -> Comp = '='
    ;   compare(Comp,W1,W2)).
