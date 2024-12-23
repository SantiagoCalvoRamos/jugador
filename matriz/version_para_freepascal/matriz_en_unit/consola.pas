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

unit consola;

interface

type
     	opcions=(recoger,listar,echar,recordar,acabar);
	paquete=packed array[1..8] of char;
	valores=(uno,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	palos=(oros,copas,espadas,bastos);
        aquello=(nohay,nohaymas);

procedure nohaycartas(var aquel:aquello);
procedure echardelpalo(var palo:palos);
procedure damecarta(var palo4:palos;var valor2:valores);
procedure opcionesconsola(var opcion:opcions);
procedure cartasjugadas(var trol:boolean;var palo:palos;var valor:valores);
procedure verlicencia;
procedure el_o_la(var trol:boolean;palo:palos;valor:valores);

implementation

procedure verlicencia;
	begin
        writeln();
        writeln();
	writeln('jugador Copyright (C) 2024 Santiago Calvo Ramos');
	writeln('Este programa NO TIENE NINGUNA GARANTIA');
        writeln('para obtener mas detalles, escriba show w');
	writeln('Este es un software libre y puede redistribuirlo');
	writeln('bajo ciertas condiciones; escriba show c para obtener mas detalles.');
        writeln();
        writeln();
        end;

{
//Presentar al usuario el texto encabezando
//a la lista de cartas que hayan sido echadas
}
procedure el_o_la(var trol:boolean;palo:palos;valor:valores);
        var
           palo_txt,valor_txt:paquete;
	begin
		if trol
		then
			begin
				writeln('');
				writeln('Has escogido mi habilidad para recordar');
				writeln('las cartas que han sido jugadas');
				writeln('y aqui las listo en el orden');
                                writeln('en que han sido jugadas');
				writeln('');
			end;
		if valor <> sota
		then writeln('el ',valor,' de ',palo)
		else writeln('la ',valor,' de ',palo);
	end;


procedure leerteclado(var entrada:paquete);
var
	c:char;
	k:integer;
begin
	c:=' ';writeln('? ');
	while (c=' ') or (c=chr(13)) or (c=chr(10)) do read(c);
	k:=1;
	while (c<>' ') and (k<=8) do
		begin
			entrada[k]:=c;
			k:=k+1;
			read(c);
		end;
	if k<9
	then for k:=k to 8 do entrada[k]:=' ';
end;

procedure cabeza1;
begin
	//page;
	writeln('soy un magnifico jugador de cartas');
	writeln('mis habilidades son:');
	writeln('recoger,listar,echar,recordar o acabar');
	writeln('escoge una');
end;

procedure fallo1(var error1:boolean;var otro:opcions;nombre:paquete);
begin
	error1:=true;
	if nombre='recoger ' then begin error1:=false; otro:=recoger end;
	if nombre='listar  ' then begin error1:=false; otro:=listar end;
	if nombre='echar   ' then begin error1:=false; otro:=echar end;
	if nombre='recordar' then begin error1:=false; otro:=recordar end;
	if nombre='acabar  ' then begin error1:=false; otro:=acabar end;
	if error1=true then writeln('función incorrecta');
end;


procedure opcionesconsola(var opcion:opcions);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		cabeza1;
		while error do
			begin
				leerteclado(mediador);
				fallo1(error,opcion,mediador);
			end;
	end;

procedure fallo3(var error3:boolean;var valor:valores;nombre:paquete);
begin
	error3:=true;
	if nombre='as      ' then begin error3:=false;valor:=uno end;
	if nombre='2       ' then begin error3:=false;valor:=dos end;
	if nombre='3       ' then begin error3:=false;valor:=tres end;
	if nombre='4       ' then begin error3:=false;valor:=cuatro end;
	if nombre='5       ' then begin error3:=false;valor:=cinco end;
	if nombre='6       ' then begin error3:=false;valor:=seis end;
	if nombre='7       ' then begin error3:=false;valor:=siete end;
	if nombre='sota    ' then begin error3:=false;valor:=sota end;
	if nombre='caballo ' then begin error3:=false;valor:=caballo end;
	if nombre='rey     ' then begin error3:=false;valor:=rey end;
	if error3=true then write('funcion incorrecta');
end;

procedure cabeza2;
begin
	//page;
	writeln('has escogido mi habilidad de echar cartas');
	writeln('di me de que palo quieres que la eche');
	writeln('ya sabes oros,copas,espadas o bastos');
end;

procedure fallo2(var error2:boolean;var palo2:palos;nombre:paquete);
begin
	error2:=true;
	if nombre='oros    ' then begin error2:=false;palo2:=oros end;
	if nombre='copas   ' then begin error2:=false;palo2:=copas end;
	if nombre='espadas ' then begin error2:=false;palo2:=espadas end;
	if nombre='bastos  ' then begin error2:=false;palo2:=bastos end;
	if error2=true then writeln('funcion incorrecta');
end;

procedure echardelpalo(var palo:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		cabeza2;
		while error do
			begin
				leerteclado(mediador);
				fallo2(error,palo,mediador);
			end;
	end;

procedure cabeza3;
begin
	//page;
	writeln('has escogido mi habilidad de coger cartas');
	writeln('dime el palo y valor de la carta');
end;

procedure damecarta(var palo4:palos;var valor2:valores);
	var
		mediador:paquete;
		error:boolean;
		palote:palos;
		valote:valores;
	begin
		error:=true;
		cabeza3;
		while error do
			begin
				leerteclado(mediador);
				fallo2(error,palote,mediador);
				palo4:=palote;
			end;
		error:=true;
		while error do
			begin
				leerteclado(mediador);
				fallo3(error,valote,mediador);
				valor2:=valote;
			end;
	end;

procedure cartasjugadas(var trol:boolean;var palo:palos;var valor:valores);
	begin
		if trol
		then
			begin
				writeln('has escogido mi habilidad par recordar');
				writeln('las cartas que han sido jugadas');
				writeln('y para que lo sepas aqui las tienes');
			end;
		if valor <> sota
		then writeln('el ',valor,' de ',palo)
		else writeln('la ',valor,' de ',palo);
	end;

procedure nohaycartas(var aquel:aquello);
	begin
                case aquel of
		nohay:
			begin
                                writeln('no hay cartas');
                                //writeln(chr(27),chr(35),chr(51),'no hay cartas');
				//writeln(chr(27),chr(35),chr(52),'no hay cartas');
			end;
		nohaymas: writeln('no hay mas cartas');
		end;
	end;
end.

