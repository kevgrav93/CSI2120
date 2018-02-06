addAlternate(L, S) :-
    addPositive(L, 0, S).

% Add
addPositive([], A, A).

addPositive([H|T], A, S) :-
    A1 is A+H,
    addNegative(T, A1, S).

% Subtract
addNegative([], A, A).

addNegative([H|T], A, S) :-
    A1 is A-H,
    addPositive(T, A1, S).
    
