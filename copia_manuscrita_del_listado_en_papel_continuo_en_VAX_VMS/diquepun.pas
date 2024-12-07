module diquepunt(output);
type
	palos=(oros,copas,espadas,bastos);
	valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	cartas=^carta;
	carta=record
		lospalos:palos;
		losvalores:valores;
		aotro:cartas;
	       end;
var
	raiz:cartas;
	ultimo:cartas;

[external]procedure cartasjugadas(trol:boolean;palo:palos;valor:valores);extern;
[external]procedure nohaycartas(aquello:aquel);extern;
[global]procedure vaciar;
	begin
		raiz:=nil;
		ultimo:=nil;
	end;
[global]procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);
	var
		nuevo:cartas
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
		writln('echo el ',valor,' de ',palo);
	end;

function vacio:boolean;
var
	aquello:aquel;
begin
	if ultimo=nil
	then
		begin
			aquello:=nohay;
			nohaycartas(aquello);
			vacio:=true;
		end
	else
		vacio:=false;
end;

[global]procedure cartasechadas;
	var
		trol:boolean;
		palo:palos;
		valor:valores;
		cursor:cartas;
		aquello:aquel;
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
				aquello=nohaymas;
				nohaycartas(aquello);
			end;
	end;
end.
