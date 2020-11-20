#include "../abc/action-MPP.lp".


% Determine left/right x-coordinates
side(X, left) :- SX = #max{ X' : position((X',_)) },  X<=(SX+1)/2, position((X,_)).
side(X, right) :- SX = #max{ X' : position((X',_)) }, X> (SX+1)/2, position((X,_)).

% Group robots into left/rigth side wrt their initial position
:- isRobot(R), time(T), position(R,(X',Y'),T-1), position(R,(X,Y),T), side(X, right), side(X', left).
:- isRobot(R), time(T), position(R,(X',Y'),T-1), position(R,(X,Y),T), side(X, left), side(X', right).


% Forbid robots to occupy a position on the other side
% This is also accomplished above
% check for robot, better to be specific
% isLeft(R,X) :- side(X,left), position(R,(X,_),_), isRobot(R).
% isRight(R,X) :- side(X,right), position(R,(X,_),_), isRobot(R).


% foo(x)
% foo(x) :- true
% :- not foo(x)
