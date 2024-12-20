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

program jugador;
uses
	crt;

type
	valores=(uno,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	opcions=(recoger,listar,echar,recordar,acabar);
	palos=(oros,copas,espadas,bastos);
	tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;
	paquete= array[1..8] of char;
    	aquello=(no_hay,no_hay_mas);
	cartas=^carta;
	carta=record
		lospalos:palos;
		losvalores:valores;
		aotro:cartas;
	       end;
	p=^paquete;

var
	palo:palos;
    	valor:valores;
    	vuelta:boolean;
    	opcion:opcions;


   	cartas_recogidas_prioros,
        cartas_recogidas_pricopas,
        cartas_recogidas_priespadas,
        cartas_recogidas_pribastos,
        cartas_recogidas_ultioros,
        cartas_recogidas_ulticopas,
        cartas_recogidas_ultiespadas,
        cartas_recogidas_ultibastos,
        nuevo:tipopuntero;



	raiz_de_cartas_echadas:cartas;
	ultimo_de_cartas_echadas:cartas;

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

	matriz_cartas_recogidas : array[oros..bastos] of array[uno..rey] of boolean;
	matriz_cartas_echadas : array[oros..bastos] of array[uno..rey] of boolean;

procedure iniciar_matriz_cartas_recogidas;
	var
		palo  : palos;
		valor : valores;
	begin
		for palo := oros to bastos do for valor := uno to rey do matriz_cartas_recogidas[palo,valor]:=false;
	end;
	
procedure iniciar_matriz_cartas_echadas;
	var
		palo  : palos;
		valor : valores;
	begin
		for palo := oros to bastos do for valor := uno to rey do matriz_cartas_echadas[palo,valor]:=false;
	end;

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
{Leer de la entrada hasta ocho caracteres}
procedure leerteclado(var entrada:paquete);
var
	c:char;
	k,i:integer;
begin
        k:=0;
        c:=' ';writeln('? ');
	while (c=' ') or  (c=chr(13)) or (c=chr(10)) do read(c);
	k:=1;
	while (c<>' ') and (k<=8) do
		begin
			entrada[k]:=c;
			k:=k+1;
			read(c);
		end;
	if k<9
	then for i:=k to 8 do entrada[i]:=' ';
end;

{Texto del encabezado en el menu principal}
procedure texto_menu_opciones;
begin
	{//ClrScr;}
	writeln('');
	writeln('Soy un magnífico jugador de cartas');
	writeln('mis habilidades son:');
	writeln('recoger,listar,echar,recordar o acabar');
	writeln('escoge una');
end;

{Comprobar que se ha tecleado una opcion valida}
procedure chequeo_menu_opciones(var error1:boolean;var otro:opcions;var nombre:paquete);
begin
	error1:=true;
	if nombre='recoger '  then begin error1:=false; otro:=recoger end;
	if nombre='listar  '  then begin error1:=false; otro:=listar end;
	if nombre='echar   '  then begin error1:=false; otro:=echar end;
	if nombre='recordar'  then begin error1:=false; otro:=recordar end;
	if nombre='acabar  '  then begin error1:=false; otro:=acabar end;
	if error1=true then
                           begin
                                   write(nombre);
                                   write(':opcion incorrecta');
                                   writeln('');
                                   texto_menu_opciones;
                           end;
end;

{Pedir una opcion al usuario}
procedure opciones_consola(var opcion:opcions);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		texto_menu_opciones;
		while error do
			begin
				leerteclado(mediador);
				chequeo_menu_opciones(error,opcion,mediador);
			end;
	end;

{Comprobar que es un valor valido de carta}
procedure chequeo_valor_carta(var error3:boolean;var valor:valores;var nombre:paquete);
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
	if error3=true then
                           begin
                                   write(nombre);
                                   write(':carta incorrecta');
                                   writeln('');
                                   {writeln('as 2 3 4 5 6 7 sota caballo rey');}
                           end;
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

{
//Pedir de que palo echar la carta
//y comprobar que hay cartas recogidas
//de ese palo
}
procedure preguntar_de_que_palo_echar(var palo3:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		mediador:='--------';
		texto_menu_echar_palo;
		while error do
			begin
				leerteclado(mediador);
				chequeo_menu_echar_palo(error,palo3,mediador);
			end;
	end;


{
//Presentar el texto indicando que se requiere
//recoger una carta
}
procedure texto_dame_carta;
begin
	{//page;}
	writeln('');
	writeln('Has escogido mi habilidad de recoger cartas');
	writeln('dime el palo y valor de la carta');
end;

{//Pedir al usuario una carta, indicando este su palo y su valor}
procedure dime_una_carta(var palo:palos;var valor:valores);
	var
		mediador:paquete;
		error:boolean;
		palote:palos;
		valote:valores;
	begin
		error:=true;
                texto_dame_carta;
		while error do
			begin
				leerteclado(mediador);
				chequeo_menu_echar_palo(error,palo,mediador);
				{palo:=palote;}
				{//writeln('oros copas espadas o bastos');}
			end;
		error:=true;
		while error do
			begin
				leerteclado(mediador);
                                chequeo_valor_carta(error,valor,mediador);
				{valor:=valote;}
				{//writeln('as 2 3 4 5 6 7 sota caballo o rey');}
			end;
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
                valores_a_texto(valor,valor_txt);
                palos_a_texto(palo,palo_txt);
		if valor <> sota
		then writeln('el ',valor_txt,' de ',palo_txt)
		else writeln('la ',valor_txt,' de ',palo_txt);
	end;

{
//Pesentar el texto 'no hay cartas' o 'no hay mas cartas'
//segun se indica con el parametro siaquello
}
procedure no_hay_o_no_hay_mas(var siaquello:aquello);
	begin
		case siaquello of
		no_hay:
			begin
				{writeln(chr(27),chr(35),chr(51),'no hay cartas');}
				{//writeln(chr(27),chr(35),chr(52),'no hay cartas');}
                                writeln('no hay cartas');
			end;
		no_hay_mas: writeln('no hay mas cartas');
		end;
	end;

{
//Poner en su condicion inicial el almacenamiento de cartas recogidas
}
procedure inicializar_almacenamiento_de_cartas_recogidas;
	begin
		cartas_recogidas_prioros:=nil;
		cartas_recogidas_pricopas:=nil;
		cartas_recogidas_priespadas:=nil;
		cartas_recogidas_pribastos:=nil;
		cartas_recogidas_ultioros:=nil;
		cartas_recogidas_ulticopas:=nil;
		cartas_recogidas_ultiespadas:=nil;
		cartas_recogidas_ultibastos:=nil;
		nuevo:=nil;
	end;


procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
        var
                i_valor:valores;
                aquel:aquello;
                encontrado:boolean;
	begin
                encontrado:=false;
                aquel:=no_hay;
                preguntar_de_que_palo_echar(palo);
                for i_valor:= rey downto uno do
                begin
                     if matriz_cartas_recogidas[palo,i_valor] and not encontrado
                     then
                         begin
                              valor:=i_valor;
                              encontrado:=true;
                              vacio:=false;
                         end
                end;

	end;

{
//Pedir una carta al usuario y guardarla en el
//lugar de cartas recogidas
}
procedure recoger_carta_y_guardarla(var palo:palos;var valor:valores);
          begin
               dime_una_carta(palo,valor);
               matriz_cartas_recogidas[palo,valor]:=true;
          end;


{
//Listar las cartas que han sido recogidas
}
procedure listar_cartas_recogidas;
          var
             i_palo,i_palo2:palos;
             i_valor,i_valor2:valores;
             palo_txt,valor_txt:paquete;
          begin
               for i_palo:= oros to bastos do
                   for i_valor:= uno to rey do
                       begin
                            if matriz_cartas_recogidas[i_palo,i_valor]=true
                            then
                                begin
                                     i_valor2:=i_valor;
                                     i_palo2:=i_palo;
                                     valores_a_texto(i_valor2,valor_txt);
                                     palos_a_texto(i_palo2,palo_txt);
                                     if i_valor <> sota
		                     then writeln('el ',valor_txt,' de ',palo_txt)
		                     else writeln('la ',valor_txt,' de ',palo_txt);
                                end;
                       end;
          end;


procedure inicializar_almacenamiento_de_cartas_echadas;
	begin
		raiz_de_cartas_echadas:=nil;
		ultimo_de_cartas_echadas:=nil;
	end;

{
//Guardar la carta echada
}
procedure almacenar_carta_echada(var palo:palos;var valor:valores;var trol:boolean);
          var
		nuevo:cartas;
                elpalo_txt,elvalor_txt:paquete;
          begin
               valores_a_texto(valor,elvalor_txt);
               palos_a_texto(palo,elpalo_txt);
               matriz_cartas_echadas[palo,valor]:=true;
               matriz_cartas_recogidas[palo,valor]:=false;
               if valor <> sota
               then writeln('echo el ',elvalor_txt,' de ',elpalo_txt)
               else writeln('echo la ',elvalor_txt,' de ',elpalo_txt);
               trol:=false;
          end;

function vacio:boolean;
var
	aquel:aquello;
begin
	if ultimo_de_cartas_echadas=nil
	then
		begin
			aquel:=no_hay;
			no_hay_o_no_hay_mas(aquel);
			vacio:=true;
		end
	else
		vacio:=false;
end;

{
//Listar las cartas echadas
}
procedure listar_cartas_echadas;
          var
             i_valor:valores;
             i_palo:palos;
             trol:boolean;
          begin
           for i_palo:= oros to bastos do
               begin
                   for i_valor:= uno to rey do
                   begin
                        if matriz_cartas_echadas[i_palo,i_valor]=true
                        then
                            begin
                                 el_o_la(trol,i_palo,i_valor);
                                 trol:=false;
                            end;
                   end;
               end;
          end;


procedure echar_una_carta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   vuelta:=true;
   echar_carta_de_un_palo(palo,valor,vuelta);
   if vuelta=false
      then almacenar_carta_echada(palo,valor,vuelta);
 end;

{
//Presentar el menu principal de opciones
}
procedure menu_principal(var opcion:opcions;var palo:palos;var valor:valores);
begin
   palo:=oros;
   valor:=tres;
   opciones_consola(opcion);
   case opcion of
    recoger  : recoger_carta_y_guardarla(palo,valor);
    listar   : listar_cartas_recogidas;                 {//Lista las cartas recogidas}
    echar    : echar_una_carta(palo,valor,vuelta);
    recordar : listar_cartas_echadas;                {//Listar las cartas echadas}
    acabar   : ;
    end;
end;

procedure inicializacion;
	begin
	      	verlicencia;
	      	iniciar_consola;
	      	inicializar_almacenamiento_de_cartas_recogidas; {//Inicializar el almacenamiento de cartas recogidas}
      		inicializar_almacenamiento_de_cartas_echadas;   {//Inicializar el almacenamiento de cartas echadas}
      		iniciar_matriz_cartas_recogidas;
      		iniciar_matriz_cartas_echadas;
	end;

procedure bucle_del_programa;
	begin
      		repeat
          		palo:=copas;
	  		valor:=rey;
          		menu_principal(opcion,palo,valor);{//Presenta el menu principal de opciones}
      		until opcion=acabar;
	end;

begin
      inicializacion;
      bucle_del_programa;
end.
