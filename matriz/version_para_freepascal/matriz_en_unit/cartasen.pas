{
Copyrigth (C) 2024 Santiago Calvo Ramos

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
	cartas_recogidas:array[oros..bastos,uno..rey] of boolean;


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
                i_valor:valores;
                aquel:aquello;
                encontrado:boolean;
	begin
                encontrado:=false;
                aquel:=nohay;
                echardelpalo(palo);
                for i_valor:= rey downto uno do
                begin
                     if cartas_recogidas[palo,i_valor] and not encontrado
                     then
                         begin
                              valor:=i_valor;
                              encontrado:=true;
                              vacio:=false;
                         end
                end;

	end;


procedure recogercarta(var palo:palos;var valor:valores);
	begin
		damecarta(palo,valor);
                cartas_recogidas[palo,valor]:=true;
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
                                                if cartas_recogidas[palo,valor]=true
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
