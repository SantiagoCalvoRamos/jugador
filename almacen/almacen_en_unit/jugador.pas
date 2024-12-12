program jugador;

//interface
uses
 consola,
 cartasen,
 almacen;

//type
        //valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
        //opcions=(recoger,listar,echar,recordar,acabar);
        //palos=(oros,copas,espadas,bastos);

var palo:palos;
    valor:valores;
    vuelta:boolean;
    opcion:opcions;


//implementation
procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   vuelta:=true;
   echarpalo(palo,valor,vuelta);
   if vuelta=false
      then almacenar(palo,valor);
 end;

procedure opciones(var opcion:opcions;var palo:palos;var valor:valores);
begin
   palo:=oros;
   valor:=tres;
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
































































































