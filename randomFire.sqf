//serve side
if (!isServer) exitWith {};


//_aa if its in the init of the AntiAir just put THIS
//_condition : condition to start script (ej. Radar destroyed)
//_spread: gives more spray (moves target) ej. 10/20
//_wait: time between shots, its random generated but this number is the most probable. it goes from 1 to 2 times this value.
waituntil {time > 2};

params ["_aa","_condition","_spread","_wait"];

//the only crew on the AA shold be the gunner to make it work, so it delete the commander
if ( count(crew _aa) > 1) then {
    _aa deleteVehicleCrew commander _aa;
    };

waituntil {_condition};

//define the gunner varibale
_gnr  = gunner _aa;
//saves position from the AA
_vecpos = position _aa;
//creates target
_trg  = createVehicle ["HeliHEmpty", _aa, [], 0, "FLY"];

while {(alive _gnr)} do {

  //generate target position
  _randomtrgpos = [[[_vecpos, 10]],[]] call BIS_fnc_randomPos;
  _randomposfinal = [_randomtrgpos select 0, _randomtrgpos select 1, (_randomtrgpos select 2) + 30];
  _trg setpos _randomposfinal;
  //gunner aims
  _gnr dowatch _trg;
  //make it shoot
  _gnr commandSuppressiveFire _trg;
  //give time to
   sleep 0.5;
  //gives more time shooting.
  _aa setVehicleAmmo 1;
  //new target to give spray
  _randomtrgpos = [[[_vecpos, 10]],[]] call BIS_fnc_randomPos;
  _randomposfinal = [(_randomtrgpos select 0) + _spread, (_randomtrgpos select 1) +  _spread, (_randomtrgpos select 2) + 30];
  _trg setpos _randomposfinal;
  _gnr dowatch _trg;
  //restart target
  _gnr forgetTarget _trg;
  //generates a random wait
  _pause = floor random [0,_wait,_wait*2];
  //wait between shots
  sleep _pause;
  //fills ammo
  _aa setVehicleAmmo 1;

};

//byFlyingTarta
