program jugador;
uses
 	consola,
 	cartasen,
        diquepun;


var palo:palos;
    valor:valores;
    vuelta:boolean;
    opcion:opcions;


procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   echarpalo(palo,valor,vuelta);
   if vuelta=false
      then almacenar(palo,valor,vuelta);
 end;

procedure opciones(var opcion:opcions;var palo:palos;var valor:valores);
begin
   palo:=oros;
   valor:=sota;
   opcionesconsola(opcion);
   case opcion of
    recoger  : recogercarta(palo,valor);
    listar   : listarcartas;
    echar    : echarcarta(palo,valor,vuelta);
    recordar : cartasechadas;
    acabar   : ;
    end;
end;

begin
      iniciar;
      vaciar;
      repeat
          palo:=copas;
	  valor:=rey;
	  opciones(opcion,palo,valor);
      until opcion=acabar;
end.
