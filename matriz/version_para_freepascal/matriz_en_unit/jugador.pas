{
Copyrigth (C) 2024 Santiago Calvo Ramos

Este programa es software libre: puede redistribuirlo y/o modificarlo bajo los
términos de la Licencia Pública General de GNU publicada por la
Free Software Foundation, ya sea la versión 3 de la Licencia
o (a su elección) cualquier versión posterior.

Este programa se distribuye con la esperanza de que sea útil, pero SIN
NINGUNA GARANTÍA; ni siquiera la garantía implícita de COMERCIABILIDAD o
IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Consulte la Licencia
Pública General de GNU para obtener más detalles.

Debería haber recibido una copia de la Licencia Pública General de
GNU junto con este programa. Si no es así, consulte <https://www.gnu.org/licenses/>.
}

program jugador;
uses
 	consola,
 	cartasen,
        matriz;


var palo:palos;
    valor:valores;
    vuelta:boolean;
    opcion:opcions;


procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   vuelta:=true;
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
      verlicencia;
      iniciar;
      vaciar;
      repeat
          palo:=copas;
	  valor:=rey;
	  opciones(opcion,palo,valor);
      until opcion=acabar;
end.
