% Max
max([H|T], Max) :- 
    max(T, H, Max).

max([], M, M).

max([H|T], M1, Max) :-
    H =< M1,
    max(T, M1, Max).

max([H|T], M1, Max) :-
    H > M1, 
    max(T, H, Max).

% Min
min([H|T], Min) :-
    min(T, H, Min).

min([], M, M).

min([H|T], M1, Min) :-
    H < M1, 
    min(T, H, Min).

min([H|T], M1, Min) :-
    H >= M1, 
    min(T, M1, Min).

% Maxmin
maxmin([H|T], Max, Min) :-
    max([H|T], Max),
    min([H|T], Min).