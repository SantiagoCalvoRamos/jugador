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
uses consola,cartasen;


var
        cartas_echadas:array[oros..bastos,uno..rey] of boolean;

procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);


procedure cartasechadas;
procedure iniciar;
procedure vaciar;

implementation
procedure vaciar;
	begin
	end;

procedure iniciar;
	var
		palo:palos;
		valor:valores;
	begin
		for palo:=oros to bastos do
			for valor:=uno to rey do
                                cartas_echadas[palo,valor]:=false;
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
                        vacio:=not cartas_echadas[palo,cursor];
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


procedure cartasechadas;
          var
             i_valor:valores;
             i_palo:palos;
             trol:boolean;
          begin
           for i_palo:= oros to bastos do
               begin
                   for i_valor:= uno to rey do
                   begin
                        if cartas_echadas[i_palo,i_valor]=true
                        then
                            begin
                                 el_o_la(trol,i_palo,i_valor);
                                 trol:=false;
                            end;
                   end;
               end;
          end;

	
procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);
          begin
               cartas_echadas[palo,valor]:=true;
               cartas_recogidas[palo,valor]:=false;
               if valor <> sota
               then writeln('echo el ',valor,' de ',palo)
               else writeln('echo la ',valor,' de ',palo);
               trol:=false;
          end;

end.
