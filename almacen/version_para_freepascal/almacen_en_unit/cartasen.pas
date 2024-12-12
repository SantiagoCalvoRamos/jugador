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
unit cartasen;

interface
uses
consola;

type
	//valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;
	//palos=(oros,copas,espadas,bastos);
	//aquello=(nohay,nohaymas);
var
	prioros,pricopas,priespadas,pribastos,nuevo,
	ultioros,ulticopas,ultiespadas,ultibastos:tipopuntero;
	supalo:palos;
	suvalor:valores;
	aquel:aquello;

//[external]procedure nohaycartas(aquel:aquello);extern;
//[external]procedure damecarta(palo:paalos;valor:valores);extern;
//[external]procedure echardelpalo(palo:palos);extern;
procedure iniciar;
procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
procedure recogercarta(var palo:palos;var valor:valores);
procedure listarcartas;



implementation
//[global]
procedure iniciar;
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
	nuevos,ultimo,primero:tipopuntero;
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
			aquel:=nohay;
			nohaycartas(aquel);
			vacio1:=true;
		end
	else vacio1:=false;
end;

//Preguntar al usuario de que palo se ha de echar
//la carta comprobando si de ese palo hay cartas
//en el almacenamiento de cartas recogidas
//procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);

	var
                a_borrar,
                anterior,
		ultimo,
		primero:tipopuntero;
                aquel:aquello;
	begin
                aquel:=nohay;
                echardelpalo(palo);
		case palo of
		oros:
			begin
                                ultimo:=ultioros;
                                primero:=prioros;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                prioros:=primero^.anterior;
                                                if primero^.anterior <> nil then primero^.anterior^.siguiente:=nil;
                                                valor:=primero^.elvalor;
                                                palo:=oros;
                                                vacio:=false;
                                                dispose(a_borrar);
                                        end
                                else
                                        begin
                                                a_borrar:=primero;
                                                if primero <> nil
                                                 then
                                                        begin
                                                                valor:=primero^.elvalor;
                                                                dispose(primero);
                                                                ultioros:=nil;
                                                                prioros:=nil;
                                                                palo:= oros;
                                                                vacio:=false;
                                                        end
                                                 else nohaycartas(aquel); //writeln('no hay de ese palo');
                                        end;
                                //writeln('falta el codigo para eliminar la carta');
			end;
		copas:
			begin
                                ultimo:=ulticopas;
                                primero:=pricopas;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                pricopas:=primero^.anterior;
                                                if primero^.anterior <> nil then primero^.anterior^.siguiente:=nil;
                                                valor:=primero^.elvalor;
                                                palo:=copas;
                                                vacio:=false;
                                                dispose(a_borrar);
                                        end
                                else
                                        begin
                                                a_borrar:=primero;
                                                if primero <> nil
                                                 then
                                                        begin
                                                                valor:=primero^.elvalor;
                                                                dispose(primero);
                                                                ulticopas:=nil;
                                                                pricopas:=nil;
                                                                palo:= copas;
                                                                vacio:=false;
                                                        end
                                                 else nohaycartas(aquel);//writeln('no hay de ese palo');


                                        end;
                                //writeln('falta el codigo para eliminar la carta');
			end;
		espadas:
			begin
                                ultimo:=ultiespadas;
                                primero:=priespadas;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                priespadas:=primero^.anterior;
                                                if primero^.anterior <> nil then primero^.anterior^.siguiente:=nil;
                                                valor:=primero^.elvalor;
                                                palo:=espadas;
                                                vacio:=false;
                                                dispose(a_borrar)
                                        end
                                else
                                        begin
                                                a_borrar:=primero;
                                                if primero <> nil
                                                 then
                                                        begin
                                                                valor:=primero^.elvalor;
                                                                dispose(primero);
                                                                ultiespadas:=nil;
                                                                priespadas:=nil;
                                                                palo:=espadas;
                                                                vacio:=false;
                                                        end
                                                 else nohaycartas(aquel);//writeln('no hay de ese palo');

                                        end;
                                //writeln('falta el codigo para eliminar la carta');
			end;
		bastos:
			begin
                                ultimo:=ultibastos;
                                primero:=pribastos;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                pribastos:=primero^.anterior;
                                                if primero^.anterior <> nil then primero^.anterior^.siguiente:=nil;
                                                valor:=primero^.elvalor;
                                                palo:=bastos;
                                                vacio:=false;
                                                dispose(a_borrar)
                                        end
                                else
                                        begin
                                                a_borrar:=primero;
                                                if primero <> nil
                                                 then
                                                        begin
                                                                valor:=primero^.elvalor;
                                                                dispose(primero);
                                                                ultibastos:=nil;
                                                                pribastos:=nil;
                                                                palo:= bastos;
                                                                vacio:=false;
                                                        end
                                                 else nohaycartas(aquel);//writeln('no hay de ese palo');

                                        end;
                                //writeln('falta el codigo para eliminar la carta');
			end;
		end;
	end;


{
//[global]
procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
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
}

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

//[global]
procedure recogercarta(var palo:palos;var valor:valores);
var
	nuevos,ultimo,primero:tipopuntero;
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
			nuevos:=nuevo;
			ultimo:=ultibastos;
			primero:=pribastos;
		end;
	end;
	new(nuevos);
	nuevos^.elvalor:=valor;
	if ultimo <> nil
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
			nuevo:=nuevos;
			ulticopas:=ultimo;
			pricopas:=primero;
		end;
	espadas:
		begin
			nuevo:=nuevos;
			ultiespadas:=ultimo;
			priespadas:=primero;
		end;
	end;
	ordenar(palo);
end;

procedure listarcartas;
	var
		palo:palos;
		valor:valores;
		primero,ultimo,nuevo:tipopuntero;
		c:char;
	begin
		for palo:=oros to bastos do
		begin
			case palo of
			oros:
				begin

					ultimo:=ultioros;
					primero:=prioros;
				end;
			copas:
				begin

					ultimo:=ulticopas;
					primero:=pricopas;
				end;
			espadas:
				begin

					ultimo:=ultiespadas;
					primero:=priespadas;
				end;
			bastos:
				begin

					ultimo:=ultibastos;
					primero:=pribastos;
				end;
			end;

	                if ultimo <> nil
	                then
		                begin
			                while primero <> ultimo do
			                begin
				                if ultimo^.elvalor <> sota
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


{
//[global]
procedure listarcartas;
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
}
end.
