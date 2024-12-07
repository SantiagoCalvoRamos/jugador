module matriz(output);
type
	palos=(oros,copas,espadas,bastos);
	valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	aquello=(nohay,nohaymas);
var
	esto:array[oros..bastos,as..rey] of boolean;
procedure nohaycartas(aquel:aquello);extern;
procedure damecarta(palo:palos,valor:valores);extern;
procedure echardelpalo(palo:palos,valor:valores);extern;

procedure iniciar;
	var
		palo:palos;
		valor:valores;
	begin
		for palo:=oros to bastos do
			for valor:=as to rey do
				esto[palo,valor]:=false;
	end;

function vacio1(var palo:palos):boolean;
var
	aquel:aquello;
	cursor:valores;
	vacio:boolean;
	piloto:boolean;
begin
	piloto:=true;
	for cursor:=as to rey do	
		begin
			vacio:=not esto[palo,valor];
			if vacio=false
			then
				begin
					vacio:=false;
					piloto:=false;
				end;
	end;
	if piloto=true
	then
		begin
			aquel:=nohay;
			nohaycartas(aquel);
			vacio:=true;
		end;
end;

procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
var
	cursor:valores;
begin
	echardelpalo(palo,valor);
	vacio:=vacio(palo);
	if vacio=false
	then
		for cursor:=as to rey do
			if esto[palo,cursor]=true
			then
				valor:=cursor;
	esto[palo,valor]:=false;
end;

procedure recogercarta(var palo:palos;var valor:valores);
	begin
		damecarta(palo,valor);
		esto[palo,valor]:=true;
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
				for valor:=as to rey do
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
