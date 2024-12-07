program jugador(input,output);

type valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
     opcions=(recoger,listar,echar,recordar,acabar);
     palos=(oros,copas,espadas,bastos);

var palo:palos;
    valor:valores;
    vuelta:boolean;
    opcion:opcions;

[external]procedure recogercarta(palo:palos;valor:valores);extern;
[external]procedure listarcartas;extern;
[external]procedure echarpalo(palo:palos;valor:valores;vuelta:boolean);extern;
[external]procedure cartasechadas;extern;
[external]procedure vaciar;extern;
[external]procedure iniciar;extern;
[external]procedure almacenar(palo:palos;valor:valores);extern;
[external]procedure opcionesconsola(opcion:opcions);extern;


procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
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
































































































