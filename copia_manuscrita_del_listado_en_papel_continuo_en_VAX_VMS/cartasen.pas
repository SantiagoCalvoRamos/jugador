module cartasenmano(input,output);
type
	valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;
	palos=(oros,copas,espadas,bastos);
	aquello=(nohay,nohaymas);
var
	prioros,pricoppas,priespadas,pribastos,nuevo,
	ultioros,ulticopas,ultiespadas,ultivastos:tipopuntero;
	supalo:palo;
	suvalor:valores;
	aquel:aquello;
[external]procedure nohaycartas(aquel:aquello);extern;
[external]procedure damecarta(palo:paalos;valor:valores);extern;
[external]procedure echardelpalo(palo:palos);extern;

[global]procedure iniciar;
	begin
		prioros:=nil;
		pricopas:=nil;
		priespadas:=nil;
		pribastos:=nil;
		ultioros:=nil;
		ulticopas:=nil;
		ultiespadas:=nil;
		ultibastos:=nil;
		nuevo:=nil;
	end;

function vacio1(palo:palos;valor:valores):boolean;
var
	nuevo,ultimo,primero:tipopuntero;
	aquel:aquello;
begin
	case palo of
	oros:
		begin
			nuevos:=nuevo;
			ultimo:=ultioros;
			primero:=prioros;
		end;
	copas:
		begin
			nuevos:=nuevo;
			ultimo:=ulticopas;
			primero:=pricopas;
		end;
	espadas:
		begin
			nuevos:=nuevo;
			ultimo:=ultiespadas;
			primero:=priespadas;
		end;
	bastos:
		begin
			nuevos:=nuevo;
			ultimo:=ultibastos;
			primero:=pribastos;
		end;
	end;
	if primero=nil
	then
		begin
			aquel:nohay;
			nohaycartas(aquel);
			vacio1:=true;
		end
	else vacio:=false;
end;

[global]procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
	var
		nuevos,ultimo,primero:tipopuntero;
	begin
		echardelpalo(palo);
		case palo of
		oros:
			begin
				nuevos:=nuevo;
				ultimo:=ultioros;
				primero:=prioros;
			end;
		copas:
			begin
				nuevos:=nuevo;
				ultimo:=ulticopas;
				primero:=pricopas;
			end;
		espadas:
			begin
				nuevos:nuevo;
				ultimo:=ultiespadas;
				primero:=priespadas;
			end;
		bastos:
			begin
				nuevos:nuevo;
				ultimo:=ultibastos;
				primero:=pribastos;
			end;
		end;
	end;


procedure ordenar(palo:palos);
var
	nuevos,primero,ultimo:tipopuntero;
	x:valores;
begin
	case palo of
	oros:
		begin
			nuevos:=nuevo;
			ultimo:=ultioros;
			primero:=prioros;
		end;
	copas:
		begin
			nuevos:=nuevo;
			ultimo:=ulticopas;
			primero:=pricopas;
		end;
	espadas:
		begin
			nuevos:=nuevo;
			ultimo:=ultiespadas;
			primero:=priespadas;
		end;
	bastos:
		begin
			nuevos:=nuevo;
			ultimo:=ultibastos;
			primero:=pribastos;
		end;
	end;
	while primero <> ultimo do
	begin
		if ultimo^.elvalor < ultimo^.siguiente^.elvalor
		then ultimo:=ultimo^.siguiente
		else
			begin
				x:=ultimo^.elvalor;
				ultimo^.elvalor:=ultimo^.siguiente^.elvalor;
				ultimo^.siguiente^.elvalor:=x;
				ultimo:=ultimo^.siguiente;
			end;
	end;
end;

[global]procedure recogercarta(var palo:palos;var valor:valores);
var
	nuevo,ultimo,primero:tipopuntero;
begin
	damecarta(palo,valor);
	case palo of
	oros:
		begin
			nuevos:=nuevo;
			ultimo:=ultioros;
			primero:=prioros;
		end;
	copas:
		begin
			nuevos:=nuevo;
			ultimo:=ulticopas;
			primero:=pricopas;
		end;
	espadas:
		begin
			nuevos:=nuevo;
			ultimo:=ultiespadas;
			primero:=priespadas;
		end;
	bastos:
		begin
			nuevos:nuevo;
			ultimo:=ultibastos;
			primero:=pribastos;
		end;
	end;
	new(nuevos);
	nuevos^.elvalor:=valor;
	if <> ultimo nil
	then
		begin
			nuevos^.anterior:=nil;
			nuevos^.siguiente:=ultimo;
			ultimo^.anterior:=nuevos;
			ultimo:=nuevos;
		end
	else
		begin
			ultimo:=nuevos;
			ultimo^.anterior:=nil;
			ultimo^.siguiente:=nil;
			primero:=ultimo;
		end;
	case palo of
	oros:
		begin
			nuevo:=nuevos;
			ultioros:=ultimo;
			prioros:=primero;
		end;
	copas:
		begin
			nuevo:nuevos;
			ulticopas:=ultimo;
			pricopas:=primero;
		end;
	espadas:
		begin
			nuevo:nuevos;
			ultiespadas:=ultimo;
			priespadas:=primero;
		end;
	end;
	ordenar(palo);
end;

[global]procedure listarcartas;
	var
		palo:palos;
		valor:valores;
		primero,ultimo,nuevos:tipopuntero;
		c:char;
	begin
		for palo:=oros to bastos do
		begin
			case palo of
			oros:
				begin
					nuevos:=nuevo;
					ultimo:=ultioros;
					primero:=prioros;
				end;
			copas:
				begin
					nuevos:=nuevo;
					ultimo:=ulticopas;
					primero:=pricopas;
				end;
			espadas:
				begin
					nuevos:=nuevo;
					ultimo:=ultiespadas;
					primero:=priespadas;
				end;
			bastos:
				begin
					nuevos:=nuevo;
					ultimo:=ultibastos;
					primero:=pribastos;
				end;
			end;
		end;
	if ultimo <> nil
	then
		begin
			while primero <> ultimo do
			begin
				if ord(ultimo^.elvalor) <> ord(sota)
				then writeln('tengo el ',ultimo^.elvalor,' de ',palo)
				else writeln('tengo la ',ultimo^.elvalor,' de ',palo);
				ultimo:=ultimo^.siguiente;
			end;
			if ultimo^.elvalor <> sota
			then writeln('tengo el ',ultimo^.elvalor,' de ',palo)
			else writeln('tengo la ',ultimo^.elvalor,' de ',palo);
		end
	else writeln('no tengo de ',palo);
	end;
end;
end.
