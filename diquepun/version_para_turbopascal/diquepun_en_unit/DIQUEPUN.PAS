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
                then writeln('echo el ',valor_a_txt(valor)^,' de ',palo_a_txt(palo)^)
                else writeln('echo la ',valor_a_txt(valor)^,' de ',palo_a_txt(palo)^);
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
