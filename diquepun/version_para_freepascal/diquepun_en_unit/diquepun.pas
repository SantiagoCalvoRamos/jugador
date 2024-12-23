{
Copyrigth (C) 2024 Santiago Calvo Ramos

Este programa es software libre: puede redistribuirlo y/o modificarlo bajo los términos de la Licencia Pública General de GNU publicada por la Free Software Foundation, ya sea la versión 3 de la Licencia o (a su elección) cualquier versión posterior.

Este programa se distribuye con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA; ni siquiera la garantía implícita de COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Consulte la Licencia Pública General de GNU para obtener más det
alles.

Debería haber recibido una copia de la Licencia Pública General de GNU junto con este programa. Si no es así, consulte <https://www.gnu.org/licenses/>.
}
unit diquepun;


interface

uses
        consola,
        cartasen;

type

	cartas=^carta;
	carta=record
		lospalos:palos;
		losvalores:valores;
		aotro:cartas;
	       end;
var
	raiz:cartas;
	ultimo:cartas;



procedure vaciar;
procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);
procedure cartasechadas;

implementation


procedure vaciar;
	begin
		raiz:=nil;
		ultimo:=nil;
	end;


procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);
	var
		nuevo:cartas;
	begin
		new(nuevo);
		nuevo^.lospalos:=palo;
		nuevo^.losvalores:=valor;
		if ultimo=nil
		then
			begin
				raiz:=nuevo;
				ultimo:=nuevo;
				nuevo^.aotro:=nil;
			end
		else
			begin
				ultimo^.aotro:=nuevo;
				ultimo:=nuevo;
				ultimo^.aotro:=nil;
			end;
                if valor <> sota
                then writeln('echo el ',valor,' de ',palo)
                else writeln('echo la ',valor,' de ',palo);
	end;

function vacio:boolean;
var
	aquel:aquello;
begin
	if ultimo=nil
	then
		begin
			aquel:=nohay;
			nohaycartas(aquel);
			vacio:=true;
		end
	else
		vacio:=false;
end;


procedure cartasechadas;
	var
		trol:boolean;
		palo:palos;
		valor:valores;
		cursor:cartas;
		aquel:aquello;
	begin
		if vacio=false
		then
			begin
				trol:=true;
				cursor:=raiz;
				repeat
					palo:=cursor^.lospalos;
					valor:=cursor^.losvalores;
					cartasjugadas(trol,palo,valor);
					trol:=false;
					cursor:=cursor^.aotro;
				until cursor=nil;
				aquel:=nohaymas;
				nohaycartas(aquel);
			end;
	end;
end.
