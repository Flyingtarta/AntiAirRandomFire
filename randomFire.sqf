if !(isserver)exitwith {}; //se ejecuta solo en servidor
_wait = 10; //esepra default
_rafaga = 4;//rafaga default
params ["_aa","_wait","_rafaga"];
waituntil{time > 2};

//_aa = Antiaerea = usar this;
//_wait = (opcional) espera en segundos (default 10 segundos)
//_rafaga = (opcional) espera en segundos (default 4 segundos)

if ( count(crew _aa) > 1) then {
    _aa deleteVehicleCrew commander _aa;
    };

_gunner = gunner _aa; //variable del gunner de la AA;
_pos = getpos _aa; //posicion de la antiaerea

while { count(crew _aa) > 0} do {
  _tgtpos = [[[_pos, 10]],[]] call BIS_fnc_randomPos; //genera posicion random
  _tgtpos set [2,30]; //cambiamos la altura del target a 30 metros
  _gunner dowatch _tgtpos; //forzamos al gunner a mirar el target
  _tgtpos = agltoasl _tgtpos; //lo cambia a ASL para el commandSuppressiveFire
  _gunner commandSuppressiveFire _tgtpos;//le dice al gunner que dispare
  sleep _rafaga; //tiempo de disparo
  _gunner disableai "FSM"; //corta la rafaga
  sleep (random [0,_wait,_wait*2]);//espera un tiempo de disparo
  _aa setVehicleAmmo 1; //llena la municion nuevamente
  _gunner enableAI "FSM";//le devuelve la posiblidad de disparar
};

//ByFlyingTarta
// v2.0  
