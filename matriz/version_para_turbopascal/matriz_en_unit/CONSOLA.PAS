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
unit consola;

interface

type
     	opcions=(recoger,listar,echar,recordar,acabar);
	paquete=packed array[1..8] of char;
	valores=(uno,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	palos=(oros,copas,espadas,bastos);
        aquello=(nohay,nohaymas);
        p=^paquete;

var
        oros_ptxt,
        copas_ptxt,
        espadas_ptxt,
        bastos_ptxt,
        uno_ptxt,
        dos_ptxt,
        tres_ptxt,
        cuatro_ptxt,
        cinco_ptxt,
        seis_ptxt,
        siete_ptxt,
        sota_ptxt,
        caballo_ptxt,
        rey_ptxt:p;
        oros_str,copas_str,espadas_str,bastos_str:paquete;

procedure leerteclado(var entrada:paquete);
procedure nohaycartas(var aquel:aquello);
procedure echardelpalo(var palo:palos);
procedure texto_menu_echar_palo;
procedure damecarta(var palo4:palos;var valor2:valores);
procedure opcionesconsola(var opcion:opcions);
procedure cartasjugadas(var trol:boolean;var palo:palos;var valor:valores);
procedure verlicencia;
procedure iniciar_consola;
function valor_a_txt(var valor:valores):p;
function palo_a_txt(var palo:palos):p;
procedure palos_a_texto(var palo:palos;var txt:paquete);
procedure valores_a_texto(var valor:valores;var txt:paquete);
procedure escribir_el_o_la(var elpalo:palos;var elvalor:valores);
procedure chequeo_menu_echar_palo(var error2:boolean;var palo2:palos;var nombre:paquete);

implementation

procedure iniciar_consola;
          begin
               new(oros_ptxt);
               new(copas_ptxt);
               new(espadas_ptxt);
               new(bastos_ptxt);
               new(uno_ptxt);
               new(dos_ptxt);
               new(tres_ptxt);
               new(cuatro_ptxt);
               new(cinco_ptxt);
               new(seis_ptxt);
               new(siete_ptxt);
               new(sota_ptxt);
               new(caballo_ptxt);
               new(rey_ptxt);

               oros_ptxt^       :='oros    ';
               copas_ptxt^      :='copas   ';
               espadas_ptxt^    :='espadas ';
               bastos_ptxt^     :='bastos  ';
               uno_ptxt^        :='uno     ';
               dos_ptxt^        :='dos     ';
               tres_ptxt^       :='tres    ';
               cuatro_ptxt^     :='cuatro  ';
               cinco_ptxt^      :='cinco   ';
               seis_ptxt^       :='seis    ';
               siete_ptxt^      :='siete   ';
               sota_ptxt^       :='sota    ';
               caballo_ptxt^    :='caballo ';
               rey_ptxt^        :='rey     ';
          end;

procedure verlicencia;
	begin
        writeln('');
        writeln('');
	writeln('jugador Copyright (C) 2024 Santiago Calvo Ramos');
	writeln('Este programa NO TIENE NINGUNA GARANTIA');
        writeln('para obtener mas detalles, escriba show w');
	writeln('Este es un software libre y puede redistribuirlo');
	writeln('bajo ciertas condiciones; escriba show c para obtener mas detalles.');
        writeln('');
        writeln('');
        end;

procedure leerteclado(var entrada:paquete);
var
	c:char;
	k:integer;
begin
	c:=' ';writeln('? ');
	while (c=' ') or (c=chr(13)) or (c=chr(10)) do read(c);
	k:=1;
	while (c<>' ') and (c<>chr(13)) and (c<>chr(10)) and (k<=8) do
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
	{//page;}
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
	if error1=true then writeln('funcion incorrecta');
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

procedure texto_menu_echar_palo;
begin
	{page;}
	writeln('Has escogido mi habilidad de echar cartas');
	writeln('dime de que palo quieres que la eche');
	writeln('ya sabes oros,copas,espadas o bastos');
end;

procedure chequeo_menu_echar_palo(var error2:boolean;var palo2:palos;var nombre:paquete);
begin
	error2:=true;
	if nombre='oros    ' then begin error2:=false;palo2:=oros end;
	if nombre='copas   ' then begin error2:=false;palo2:=copas end;
	if nombre='espadas ' then begin error2:=false;palo2:=espadas end;
	if nombre='bastos  ' then begin error2:=false;palo2:=bastos end;
	if error2=true  then
                           begin
                                   writeln('');
                                   write(nombre);
                                   write(':palo incorrecto');
                                   writeln('');
                           end;
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


procedure palos_a_texto(var palo:palos;var txt:paquete);
         begin

                   if ord(palo)=ord(oros)    then txt:='oros    ';
                   if ord(palo)=ord(copas)   then txt:='copas   ';
                   if ord(palo)=ord(espadas) then txt:='espadas ';
                   if ord(palo)=ord(bastos)  then txt:='bastos  ';
         end;

procedure valores_a_texto(var valor:valores;var txt:paquete);
         begin

                   if ord(valor)=ord(uno)       then  txt:='uno     ';
                   if ord(valor)=ord(dos)       then  txt:='dos     ';
                   if ord(valor)=ord(tres)      then  txt:='tres    ';
                   if ord(valor)=ord(cuatro)    then  txt:='cuatro  ';
                   if ord(valor)=ord(cinco)     then  txt:='cinco   ';
                   if ord(valor)=ord(seis)      then  txt:='seis    ';
                   if ord(valor)=ord(siete)     then  txt:='siete   ';
                   if ord(valor)=ord(sota)      then  txt:='sota    ';
                   if ord(valor)=ord(caballo)   then  txt:='caballo ';
                   if ord(valor)=ord(rey)       then  txt:='rey     ';
         end;



procedure echardelpalo(var palo:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		texto_menu_echar_palo;
		while error do
			begin
				leerteclado(mediador);
				fallo2(error,palo,mediador);
			end;
	end;

procedure cabeza3;
begin
	{//page;}
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

function valor_a_txt(var valor:valores):p;
         begin
              case valor of
                   uno:         begin valor_a_txt:=uno_ptxt; end;
                   dos:         begin valor_a_txt:=dos_ptxt; end;
                   tres:        begin valor_a_txt:=tres_ptxt;end;
                   cuatro:      begin valor_a_txt:=cuatro_ptxt;end;
                   cinco:       begin valor_a_txt:=cinco_ptxt;end;
                   seis:        begin valor_a_txt:=seis_ptxt;end;
                   siete:       begin valor_a_txt:=siete_ptxt;end;
                   sota:        begin valor_a_txt:=sota_ptxt;end;
                   caballo:     begin valor_a_txt:=caballo_ptxt;end;
                   rey:         begin valor_a_txt:=rey_ptxt;end;
              end;
         end;

function palo_a_txt(var palo:palos):p;
         begin
              case palo of
                   oros:     begin palo_a_txt:=oros_ptxt;end;
                   copas:    begin palo_a_txt:=copas_ptxt;end;
                   espadas:  begin palo_a_txt:=espadas_ptxt;end;
                   bastos:   begin palo_a_txt:=bastos_ptxt;end;
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
		then writeln('el ',valor_a_txt(valor)^,' de ',palo_a_txt(palo)^)
		else writeln('la ',valor_a_txt(valor)^,' de ',palo_a_txt(palo)^);
	end;

procedure nohaycartas(var aquel:aquello);
	begin
                case aquel of
		nohay:
			begin
                                writeln('no hay cartas');
                                {//writeln(chr(27),chr(35),chr(51),'no hay cartas');}
				{//writeln(chr(27),chr(35),chr(52),'no hay cartas');}
			end;
		nohaymas: writeln('no hay mas cartas');
		end;
	end;

procedure escribir_el_o_la(var elpalo:palos;var elvalor:valores);
          begin
               if elvalor<>sota
                then writeln('echo el ',valor_a_txt(elvalor)^,' de ',palo_a_txt(elpalo)^)
                else writeln('echo la ',valor_a_txt(elvalor)^,' de ',palo_a_txt(elpalo)^);
          end;

end.

