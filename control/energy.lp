% - Input conversion -------------------------------------------------------------------------------
%   Map init(object(robot, R), value(energy, E)) to internal representation,
%   .e.g energy(Robot,EnergyLevel,TimeStep)
energy(robot(R),E,0) :- init(object(robot, R), value(energy, E)).
% position(  robot(R),(X,Y),0) :- init(object(robot,R),          value(at,(X,Y))).

% - Energy consumption -----------------------------------------------------------------------------

% *Generalize consumption*
% Map different actions to general consumption atoms, e.g. consume(Robot, EnergyAmount, TimeStep)
% - consume/3 -----------------------------------------------------------------------------
consume(R,1,T)  :- move(   R, _, T), not carries(R, _,T).
consume(R,2,T)  :- move(   R, _, T), carries(R, _,T).
consume(R,1,T)  :- pickup(R, _,T).
consume(R,1,T)  :- putdown(R, _,T).


% *Consumption effect*
% For each robot and time step, reflect the effect of its current consumption (via consume/3)
% towards its current energy level (via energy/3)
% position(R,C,T) :- move(R,D,T),    position(R,C',T-1),     nextto(C',D,C).
% energy(R,E,T) :- consume(R,A,T), energy(R,E,T), energy(R,E',T-1), E = E'- A.
% consume(R,A,T) :- consume(R,A,T), energy(R,E,T), energy(R,E',T), E = E'- A.


% *Inertia*
% For each robot and time step, if no energy is currently consumed, the energy level
% remains unchanged.
% position(R,C,T) :- position(R,C,T-1), not    move(R,_,T), isRobot(R), time(T).
energy(R,E,T) :- energy(R,E,T-1), not consume(R,_,T), isRobot(R), time(T).

% *Forbid Over-Consumption*
% For each robot and time step, the energy level must not be negative.
% we know this works
:- energy( R, E, T ), E >= 0, time(T), robot(R).

% - Output -----------------------------------------------------------------------------------------

#show energy/3.
