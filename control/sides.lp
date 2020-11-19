#include "../abc/action-MPP.lp".


% Determine left/right x-coordinates
side(X, left) :- SX = #max{ X' : position((X',_)) },  X<=(SX+1)/2, position((X,_)).
side(X, right) :- SX = #max{ X' : position((X',_)) }, X> (SX+1)/2, position((X,_)).

% Group robots into left/rigth side wrt their initial position
:- side(X,right), side(X', left), position(R,(X,_),T), position(R,(X',_),T+1), isRobot(R).
:- side(X,right), side(X', left), position(R,(X,_),T), position(R,(X',_),T+1), isRobot(R).

% Forbid robots to occupy a position on the other side
% This is also accomplished above
% check for robot, better to be specific
% isLeft(R,X) :- side(X,left), position(R,(X,_),_), isRobot(R).
% isRight(R,X) :- side(X,right), position(R,(X,_),_), isRobot(R).


% foo(x)
% foo(x) :- true
% :- not foo(x)
