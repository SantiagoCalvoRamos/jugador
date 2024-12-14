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
uses consola;

{
type
	palos=(oros,copas,espadas,bastos);
	valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	aquello=(nohay,nohaymas);
}

var
	esto:array[oros..bastos,uno..rey] of boolean;
{
procedure nohaycartas(aquel:aquello);extern;
procedure damecarta(palo:palos,valor:valores);extern;
procedure echardelpalo(palo:palos,valor:valores);extern;
}

procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
procedure almacenar(var palo:palos;var valor:valores;var vuelta:boolean);
procedure recogercarta(var palo:palos;var valor:valores);
procedure listarcartas;
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
				esto[palo,valor]:=false;
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
			vacio:=not esto[palo,cursor];
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
		for cursor:=uno to rey do
			if esto[palo,cursor]=true
			then
				valor:=cursor;
	esto[palo,valor]:=false;
end;

procedure cartasechadas;
	begin
                writeln('caracteristica no implementada');
	end;

procedure recogercarta(var palo:palos;var valor:valores);
	begin
		damecarta(palo,valor);
		esto[palo,valor]:=true;
	end;

procedure almacenar(var palo:palos;var valor:valores;var vuelta:boolean);
	begin
                writeln('caracteristica no implementada');
	end;

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
						if esto[palo,valor]=true
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

end.
