{
Este programa es software libre: puede redistribuirlo y/o modificarlo bajo los términos de la Licencia Pública General de GNU publicada por la Free Software Foundation, ya sea la versión 3 de la Licencia o (a su elección) cualquier versión posterior.

Este programa se distribuye con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA; ni siquiera la garantía implícita de COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Consulte la Licencia Pública General de GNU para obtener más det
alles.

Debería haber recibido una copia de la Licencia Pública General de GNU junto con este programa. Si no es así, consulte <https://www.gnu.org/licenses/>.
}
unit cartasen;

interface
uses
	consola;

type
        tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;

var
	prioros,pricopas,priespadas,pribastos,nuevo,
	ultioros,ulticopas,ultiespadas,ultibastos:tipopuntero;
	supalo:palos;
	suvalor:valores;
	aquel:aquello;



procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);
procedure recogercarta(var palo:palos;var valor:valores);
procedure listarcartas;
procedure iniciar;



implementation

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

function vacio1(var palo:palos;var valor:valores):boolean;
var
	nuevo,ultimo,primero:tipopuntero;
	aquel:aquello;
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

procedure ordenar(palo:palos);
var
	nuevos,primero,ultimo:tipopuntero;
	x:valores;
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


procedure recogercarta(var palo:palos;var valor:valores);
var
	nuevo,ultimo,primero:tipopuntero;
begin
	damecarta(palo,valor);
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
	new(nuevo);
	nuevo^.elvalor:=valor;
	if ultimo <> nil
	then
		begin
			nuevo^.anterior:=nil;
			nuevo^.siguiente:=ultimo;
			ultimo^.anterior:=nuevo;
			ultimo:=nuevo;
		end
	else
		begin
			ultimo:=nuevo;
			ultimo^.anterior:=nil;
			ultimo^.siguiente:=nil;
			primero:=ultimo;
		end;
	case palo of
	oros:
		begin

			ultioros:=ultimo;
			prioros:=primero;
		end;
	copas:
		begin

			ulticopas:=ultimo;
			pricopas:=primero;
		end;
	espadas:
		begin

			ultiespadas:=ultimo;
			priespadas:=primero;
		end;
        bastos:
		begin

			ultibastos:=ultimo;
			pribastos:=primero;
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
