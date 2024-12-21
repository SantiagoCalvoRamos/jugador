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
unit matriz;

interface
uses cartasen,consola;

var
   matriz_cartas_echadas:array[oros..bastos] of array[uno..rey] of boolean;






procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
procedure almacenar_carta_echada(var palo:palos;var valor:valores;var trol:boolean);
procedure listar_cartas_echadas;
procedure inicializar_almacenamiento_de_cartas_recogidas;
procedure inicializar_almacenamiento_de_cartas_echadas;

implementation
procedure inicializar_almacenamiento_de_cartas_echadas;
	var
		palo:palos;
		valor:valores;
	begin
		for palo:=oros to bastos do
			for valor:=uno to rey do
				matriz_cartas_echadas[palo,valor]:=false;
	end;

procedure inicializar_almacenamiento_de_cartas_recogidas;
	var
		palo:palos;
		valor:valores;
	begin
		for palo:=oros to bastos do
			for valor:=uno to rey do
				matriz_cartas_recogidas[palo,valor]:=false;
	end;

function vacio1(var palo:palos):boolean;
var
	aquel:aquello;
	cursor:valores;
        valor:valores;
	vacio:boolean;
	piloto:boolean;
begin
	piloto:=true;
	for cursor:=uno to rey do
		begin
			vacio:=not matriz_cartas_recogidas[palo,cursor];
			if vacio=false
			then
				begin
					vacio1:=false;
					piloto:=false;
				end;
	end;
	if piloto=true
	then
		begin
			aquel:=nohay;
			no_hay_o_no_hay_mas(aquel);
			vacio1:=true;
		end;
end;

procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
        var
                i_valor:valores;
                aquel:aquello;
                encontrado:boolean;
	begin
                encontrado:=false;
                aquel:=nohay;
                preguntar_de_que_palo_echar(palo);
                for i_valor:= rey downto uno do
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

procedure listar_cartas_echadas;
          var
             i_valor:valores;
             i_palo:palos;
             trol:boolean;
          begin
           for i_palo:= oros to bastos do
               begin
                   for i_valor:= uno to rey do
                   begin
                        if matriz_cartas_echadas[i_palo,i_valor]=true
                        then
                            begin
                                 el_o_la(trol,i_palo,i_valor);
                                 trol:=false;
                            end;
                   end;
               end;
          end;
{
procedure recogercarta(var palo:palos;var valor:valores);
	begin
		damecarta(palo,valor);
		matriz_de_cartas_recogidas[palo,valor]:=true;
	end;
}

{

//Guardar la carta echada
}
procedure almacenar_carta_echada(var palo:palos;var valor:valores;var trol:boolean);
          var
		{nuevo:cartas;}
                elpalo_txt,elvalor_txt:paquete;
          begin
               valores_a_texto(valor,elvalor_txt);
               palos_a_texto(palo,elpalo_txt);
               matriz_cartas_echadas[palo,valor]:=true;
               matriz_cartas_recogidas[palo,valor]:=false;
               if valor <> sota
               then writeln('echo el ',elvalor_txt,' de ',elpalo_txt)
               else writeln('echo la ',elvalor_txt,' de ',elpalo_txt);
               trol:=false;
          end;




{
procedure listarcartas;
	var
		palo:palos;
		valor:valores;
		piloto:boolean;
	begin
		for palo:=oros to bastos do
			begin
				piloto:=true;
				for valor:=uno to rey do
					begin
						if matriz_de_cartas_recogidas[palo,valor]=true
						then
							begin
								if valor <> sota
								then writeln('tengo el ',valor,' de ',palo)
								else writeln('tengo la ',valor,' de ',palo);
								piloto:=false;
							end;
					end;
				if piloto
				then writeln('no tengo de ',palo);
			end;
	end;
}
end.
