% Francisco Trindade - 7791605 - CSI2120 Lab 1 Quiz
% Created two more lights for roomC: lightD, & lightE
% and connected these two lights to switch4 which is turned on.
% Then lightD is hardwired into fuse3. While lightE is wired into
% socketB which in turn is wired into fuse3. So the query 
% bright(roomC) returns two trues as there are two lights on in that room.

% room lighting
lit( roomA, lightA ).
lit( roomB, lightB ).
lit( roomA, lightC ).
lit( roomC, lightD ).
lit( roomC, lightE ).

    
% light switches
control( lightA, switch1 ).
control( lightB, switch2 ).
control( lightB, switch1 ).
control( lightC, switch3 ).
control( lightD, switch4 ).
control( lightE, switch4 ).
    
% wiring of lights
hardwire(lightA).
hardwire(lightB).
hardwire(lightD).
plug( lightC, socketA ).
plug( lightE, socketB ).


% fuses
fuse( lightA, fuse1 ).
fuse( lightB, fuse2 ).
fuse( socketA, fuse2 ).
fuse( lightD, fuse3 ).
fuse( socketB, fuse3 ).

% fuse ok
ok( fuse1 ).
ok( fuse2 ).
ok( fuse3 ).

% switches on
isOn( switch2 ).
isOn( switch3 ).
isOn( switch4 ).


connected(L) :- fuse(L, F),
		ok(F).

connected(L) :- plug(L,S),
		fuse(S,F),
		ok(F).

bright(X) :- lit(X, L),
	     control(L, S),
	     isOn(S),
	     connected(L).

