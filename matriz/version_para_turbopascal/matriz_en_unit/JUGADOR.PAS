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


procedure echar_una_carta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   vuelta:=true;
   echar_carta_de_un_palo(palo,valor,vuelta);
   if vuelta=false
      then almacenar_carta_echada(palo,valor,vuelta);
 end;

{
//Presentar el menu principal de opciones

}
procedure menu_principal(var opcion:opcions;var palo:palos;var valor:valores);
begin
   palo:=oros;
   valor:=tres;
   opciones_consola(opcion);
   case opcion of
    recoger  : recoger_carta_y_guardarla(palo,valor);
    listar   : listar_cartas_recogidas;                 {//Lista las cartas recogidas}
    echar    : echar_una_carta(palo,valor,vuelta);
    recordar : listar_cartas_echadas;                {//Listar las cartas echadas}
    acabar   : ;
    end;
end;

procedure inicializacion;
	begin
	      	verlicencia;
	      	iniciar_consola;
	      	inicializar_almacenamiento_de_cartas_recogidas; {//Inicializar el almacenamiento de cartas recogidas}
      		inicializar_almacenamiento_de_cartas_echadas;   {//Inicializar el almacenamiento de cartas echadas}
      		{iniciar_matriz_cartas_recogidas;}
      		{iniciar_matriz_cartas_echadas;}
	end;

procedure bucle_del_programa;
	begin
      		repeat
          		palo:=copas;
	  		valor:=rey;
          		menu_principal(opcion,palo,valor);{//Presenta el menu principal de opciones}
      		until opcion=acabar;
	end;

begin
      inicializacion;
      bucle_del_programa;
end.
