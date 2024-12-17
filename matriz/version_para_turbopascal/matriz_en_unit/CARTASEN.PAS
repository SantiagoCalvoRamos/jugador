{
Copyrigth (C) 2024 Santiago Calvo Ramos

Este programa es software libre: puede redistribuirlo
y/o modificarlo bajo los terminos de la Licencia Publica
General de GNU publicada por la Free Software Foundation,
ya sea la version 3 de la Licencia o (a su eleccion)
cualquier version posterior.

Este programa se distribuye con la esperanza de que
sea util, pero SIN NINGUNA GARANTIA; ni siquiera
la garantia implicita de COMERCIABILIDAD o IDONEIDAD
PARA UN PROPOSITO PARTICULAR. Consulte la Licencia
Publica General de GNU para obtener mas detalles.

Deberia haber recibido una copia de la Licencia Publica
General de GNU junto con este programa. Si no es asi,
consulte <https://www.gnu.org/licenses/>.
}

unit cartasen;

interface
uses
	consola;

type
        tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;

var
	prioros,pricopas,priespadas,pribastos,nuevo,
	ultioros,ulticopas,ultiespadas,ultibastos:tipopuntero;
	supalo:palos;
	suvalor:valores;
	aquel:aquello;
	matriz_cartas_recogidas : array[oros..bastos] of array[uno..rey] of boolean;
   	matriz_cartas_echadas : array[oros..bastos] of array[uno..rey] of boolean;




procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
procedure recogercarta(var palo:palos;var valor:valores);
procedure listarcartas;
procedure iniciar;



implementation

procedure iniciar;
	var
		palo  : palos;
		valor : valores;
	begin
		for palo := oros to bastos do for valor := uno to rey do matriz_cartas_recogidas[palo,valor]:=false;
	end;


{
//Pedir de que palo echar la carta
//y comprobar que hay cartas recogidas
//de ese palo
}
procedure preguntar_de_que_palo_echar(var palo3:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		mediador:='--------';
		texto_menu_echar_palo;
		while error do
			begin
				leerteclado(mediador);
				chequeo_menu_echar_palo(error,palo3,mediador);
			end;
	end;


{
//Preguntar al usuario de que palo se ha de echar
//la carta comprobando si de ese palo hay cartas
//en el almacenamiento de cartas recogidas
//procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
}
procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
        var
                i_valor:valores;
                aquel:aquello;
                encontrado:boolean;
	begin
                encontrado:=false;
                aquel:=nohay;
                preguntar_de_que_palo_echar(palo);
                for i_valor:= uno to rey do
                begin
                     if matriz_cartas_recogidas[palo,i_valor] and not encontrado
                     then
                         begin
                              valor:=i_valor;
                              encontrado:=true;
                              vacio:=false;
                         end
                end;
	end;



{
//Pedir una carta al usuario y guardarla en el
//lugar de cartas recogidas
}
procedure recogercarta(var palo:palos;var valor:valores);
          begin
               damecarta(palo,valor);
               matriz_cartas_recogidas[palo,valor]:=true;
          end;


{
//Listar las cartas que han sido recogidas
}
procedure listarcartas;
          var
             i_palo,i_palo2:palos;
             i_valor,i_valor2:valores;
             palo_txt,valor_txt:paquete;
          begin
               for i_palo:= oros to bastos do
                   for i_valor:= uno to rey do
                       begin
                            if matriz_cartas_recogidas[i_palo,i_valor]=true
                            then
                                begin
                                     i_valor2:=i_valor;
                                     i_palo2:=i_palo;
                                     valores_a_texto(i_valor2,valor_txt);
                                     palos_a_texto(i_palo2,palo_txt);
                                     if i_valor <> sota
		                     then writeln('el ',valor_txt,' de ',palo_txt)
		                     else writeln('la ',valor_txt,' de ',palo_txt);
                                end;
                       end;
          end;




end.
