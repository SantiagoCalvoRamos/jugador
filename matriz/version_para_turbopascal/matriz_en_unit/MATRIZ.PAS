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






procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
procedure almacenar(var palo:palos;var valor:valores;var vuelta:boolean);
procedure cartasechadas;
procedure iniciar;
procedure vaciar;

implementation
procedure vaciar;
	var
		palo:palos;
		valor:valores;
	begin
		for palo:=oros to bastos do
			for valor:=uno to rey do
				matriz_cartas_echadas[palo,valor]:=false;
	end;

procedure iniciar;
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
			nohaycartas(aquel);
			vacio1:=true;
		end;
end;

procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
var
	cursor:valores;
begin
	echardelpalo(palo);
	vacio:=vacio1(palo);
	if vacio=false
	then
		for cursor:=rey to uno do
			if matriz_cartas_recogidas[palo,cursor]=true
			then
				valor:=cursor;
	matriz_cartas_recogidas[palo,valor]:=false;
end;

procedure cartasechadas;
          var
             i_valor,i_valor2:valores;
             i_palo,i_palo2:palos;
             trol:boolean;
             palo_txt,valor_txt:paquete;
          begin
           for i_palo:= oros to bastos do
               begin
                   for i_valor:= uno to rey do
                   begin
                        if matriz_cartas_echadas[i_palo,i_valor]=true
                        then
                            begin
                                 {el_o_la(trol,i_palo,i_valor);}
                                 i_palo2:=i_palo;
                                 i_valor2:=i_valor;
                                 valores_a_texto(i_valor2,valor_txt);
                                 palos_a_texto(i_palo2,palo_txt);
                                 if i_valor <> sota
                                 then writeln('el ',valor_txt,' de ',palo_txt)
                                 else writeln('la ',valor_txt,' de ',palo_txt);
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

procedure almacenar(var palo:palos;var valor:valores;var vuelta:boolean);
          var

                elpalo_txt,elvalor_txt:paquete;
          begin
               valores_a_texto(valor,elvalor_txt);
               palos_a_texto(palo,elpalo_txt);
               matriz_cartas_echadas[palo,valor]:=true;
               matriz_cartas_recogidas[palo,valor]:=false;
               if valor <> sota
               then writeln('echo el ',elvalor_txt,' de ',elpalo_txt)
               else writeln('echo la ',elvalor_txt,' de ',elpalo_txt);
               vuelta:=false;
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
