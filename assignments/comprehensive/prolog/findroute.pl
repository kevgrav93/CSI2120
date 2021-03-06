% Author: Francisco Trindade - 7791605
% ------ AUTO GENERATED ITEMS FROM PYTHON ------
pool("Crestview",-75.73795670904249,45.344387632924054).
pool("Bellevue Manor",-75.73886856878032,45.37223315413918).
pool("Dutchie's Hole",-75.66809864107668,45.420784695340274).
pool("Bingham",-75.69570714265845,45.43364510779131).
pool("Alvin Heights",-75.65100870365318,45.45147956435529).
pool("Balena",-75.64341396386098,45.40505998694386).
pool("Bel Air",-75.76237762310991,45.35750853073128).
pool("Raven",-75.74042790502267,45.376538041017916).
pool("Britannia",-75.79935158132524,45.36063791083469).
pool("Chaudiere",-75.71353870063207,45.40984992554796).
pool("Parkdale",-75.73023035094172,45.40138661908912).
pool("Alta Vista",-75.6663971454287,45.383081724040146).
pool("Cecil Morrison",-75.64599611564647,45.417175891787146).
pool("Heron",-75.67726553077785,45.37955540833377).
pool("Brantwood",-75.67162178567759,45.406132203975446).
pool("Lisa",-75.78888493568607,45.344203611634356).
pool("McKellar",-75.7663355603181,45.383356299319395).
pool("Overbrook",-75.65712102762836,45.42506341603979).
pool("Owl",-75.66479650124089,45.35438810082107).
pool("Pushman",-75.64825277394819,45.35958959542747).
pool("Sandy Hill",-75.67679178631916,45.421628374955425).
pool("Westboro",-75.75301290567192,45.38390614815524).
pool("Windsor",-75.67593721799336,45.394532186176534).
pool("Frank Ryan",-75.78913776510414,45.35618157210449).
pool("Strathcona",-75.67270686637411,45.42814320884978).
pool("Greenboro",-75.63644623282283,45.363297932669155).
pool("Sylvia Holden",-75.68218644953257,45.40257049489391).
pool("Kiwanis",-75.65314626399277,45.43665037776025).
pool("Entrance",-75.81675609520583,45.32631894820216).
pool("General Burns",-75.72068192228832,45.3517223372365).
pool("Corkstown",-75.82733278768433,45.34609228122724).
pool("Pauline Vanier",-75.676559014967,45.366710168887366).
pool("St. Luke's",-75.68696475924723,45.41513265659813).
pool("Canterbury",-75.62883265479898,45.389521642267944).
pool("Alda Burt",-75.62566700143215,45.402733068354976).
pool("Hawthorne",-75.615926705023,45.39368089918365).
pool("Weston",-75.62613467769313,45.39596271646451).
pool("Michèle",-75.8020190093133,45.3548865821927).
pool("Parkway",-75.77593080375445,45.35631278392867).
pool("Ruth Wildgen",-75.7957485439787,45.35143574971178).
pool("Agincourt",-75.75360944568821,45.35959223124413).
pool("Elizabeth Manley",-75.61936964815708,45.36999070895657).
pool("Jules Morin",-75.68154277234615,45.433497486473115).
pool("Kingsmere",-75.7625479468355,45.36492415895533).
pool("Carleton Heights",-75.70254191613397,45.35963576001747).
pool("Rideauview",-75.70673708550083,45.367907282835596).
pool("Frank Licari",-75.65708630346525,45.36886086041407).
pool("Optimiste",-75.66850786065743,45.442237661390195).
pool("Glen Cairn",-75.88504321403646,45.29552398823589).
pool("Bearbrook",-75.56367146417631,45.43415859594989).
pool("Iona",-75.74247203669871,45.392425824249926).
pool("Meadowvale",-75.72477696260978,45.37828145083384).
pool("Reid",-75.72389983475932,45.39809949308152).
pool("Hampton",-75.73836344415304,45.38742953063268).
pool("St-Laurent",-75.64849014424264,45.436351255364265).
pool("St. Paul's",-75.64813126103986,45.43004145660221).
pool("Woodroffe",-75.77225704729584,45.37607987330218).
pool("Lions",-75.75232047849263,45.39427770813794).
pool("McNabb",-75.70274498043973,45.40897618041744).
pool("Alexander",-75.73163858599659,45.380330193754176).
pool("Champlain",-75.74496450985441,45.40431589991452).
pool("Ev Tremblay",-75.71148292845268,45.39934611083154).
poolList(X) :-
    X = ["Crestview","Bellevue Manor","Dutchie's Hole","Bingham","Alvin Heights","Balena","Bel Air","Raven","Britannia","Chaudiere","Parkdale","Alta Vista","Cecil Morrison","Heron","Brantwood","Lisa","McKellar","Overbrook","Owl","Pushman","Sandy Hill","Westboro","Windsor","Frank Ryan","Strathcona","Greenboro","Sylvia Holden","Kiwanis","Entrance","General Burns","Corkstown","Pauline Vanier","St. Luke's","Canterbury","Alda Burt","Hawthorne","Weston","Michèle","Parkway","Ruth Wildgen","Agincourt","Elizabeth Manley","Jules Morin","Kingsmere","Carleton Heights","Rideauview","Frank Licari","Optimiste","Glen Cairn","Bearbrook","Iona","Meadowvale","Reid","Hampton","St-Laurent","St. Paul's","Woodroffe","Lions","McNabb","Alexander","Champlain","Ev Tremblay"].
% ------ END OF AUTO GENERATED ITEMS ------
% ------ QUERIES MERGED FROM "prolog-solution.pl" ------
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
