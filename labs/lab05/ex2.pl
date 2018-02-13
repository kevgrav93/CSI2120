leafnodes(nil, []).

leafnodes(t(A,nil,nil), [A]).

leafnodes(t(_,Left,Right), L) :-
    leafnodes(Left, LL),
    leafnodes(Right, LR),
    append(LL, LR, L),
    L \= [].
    
