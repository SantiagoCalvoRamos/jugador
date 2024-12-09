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

program total;
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
	while (c=' ') do read(c);
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
procedure dime_una_carta(var palo4:palos;var valor2:valores);
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
				chequeo_menu_echar_palo(error,palote,mediador);
				palo4:=palote;
				{//writeln('oros copas espadas o bastos');}
			end;
		error:=true;
		while error do
			begin
				leerteclado(mediador);
                                chequeo_valor_carta(error,valote,mediador);
				valor2:=valote;
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
				writeln(chr(27),chr(35),chr(51),'no hay cartas');
				{//writeln(chr(27),chr(35),chr(52),'no hay cartas');}
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

{
//Comprobar si en el almacenamiento de cartas recogidas
//hay elementos del palo indicado en el parametro
}
function ver_si_vacio_el_palo_en_almacenamiento_de_cartas_recogidas(palo:palos;valor:valores):boolean;
var
	{//nuevos,}
	ultimo,
	primero:tipopuntero;
	aquel:aquello;
begin
	case palo of
	oros:
		begin

			ultimo:=cartas_recogidas_ultioros;
			primero:=cartas_recogidas_prioros;
		end;
	copas:
		begin

			ultimo:=cartas_recogidas_ulticopas;
			primero:=cartas_recogidas_pricopas;
		end;
	espadas:
		begin

			ultimo:=cartas_recogidas_ultiespadas;
			primero:=cartas_recogidas_priespadas;
		end;
	bastos:
		begin

			ultimo:=cartas_recogidas_ultibastos;
			primero:=cartas_recogidas_pribastos;
		end;
	end;
	if primero=nil  {//No hay cartas}
	then
		begin
			aquel:=no_hay;
			{//Presentar el mensaje de que no hay cartas}
			no_hay_o_no_hay_mas(aquel);
			ver_si_vacio_el_palo_en_almacenamiento_de_cartas_recogidas:=true;
		end
	else ver_si_vacio_el_palo_en_almacenamiento_de_cartas_recogidas:=false;
end;

{
//Preguntar al usuario de que palo se ha de echar
//la carta comprobando si de ese palo hay cartas
//en el almacenamiento de cartas recogidas
}
procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
	var
                a_borrar,
                anterior,
		ultimo,
		primero:tipopuntero;
                aquel:aquello;
	begin
                aquel:=no_hay;
                preguntar_de_que_palo_echar(palo);
		case palo of
		oros:
			begin
                                ultimo:=cartas_recogidas_ultioros;
                                primero:=cartas_recogidas_prioros;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                cartas_recogidas_prioros:=primero^.anterior;
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
                                                                cartas_recogidas_ultioros:=nil;
                                                                cartas_recogidas_prioros:=nil;
                                                                palo:= oros;
                                                                vacio:=false;
                                                        end
                                                 else no_hay_o_no_hay_mas(aquel); {//writeln('no hay de ese palo');}
                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
			end;
		copas:
			begin
                                ultimo:=cartas_recogidas_ulticopas;
                                primero:=cartas_recogidas_pricopas;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                cartas_recogidas_pricopas:=primero^.anterior;
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
                                                                cartas_recogidas_ulticopas:=nil;
                                                                cartas_recogidas_pricopas:=nil;
                                                                palo:= copas;
                                                                vacio:=false;
                                                        end
                                                 else no_hay_o_no_hay_mas(aquel);{//writeln('no hay de ese palo');}


                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
			end;
		espadas:
			begin
                                ultimo:=cartas_recogidas_ultiespadas;
                                primero:=cartas_recogidas_priespadas;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                cartas_recogidas_priespadas:=primero^.anterior;
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
                                                                cartas_recogidas_ultiespadas:=nil;
                                                                cartas_recogidas_priespadas:=nil;
                                                                palo:=espadas;
                                                                vacio:=false;
                                                        end
                                                 else no_hay_o_no_hay_mas(aquel);{//writeln('no hay de ese palo');}

                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
			end;
		bastos:
			begin
                                ultimo:=cartas_recogidas_ultibastos;
                                primero:=cartas_recogidas_pribastos;
                                if ultimo <> primero
                                then
                                        begin
                                                a_borrar:=primero;
                                                cartas_recogidas_pribastos:=primero^.anterior;
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
                                                                cartas_recogidas_ultibastos:=nil;
                                                                cartas_recogidas_pribastos:=nil;
                                                                palo:= bastos;
                                                                vacio:=false;
                                                        end
                                                 else no_hay_o_no_hay_mas(aquel);{//writeln('no hay de ese palo');}

                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
			end;
		end;
	end;


procedure ordenar_las_de_un_palo(palo:palos);
var
	{//nuevos,}
	primero,
	ultimo:tipopuntero;
	x:valores;
begin
	case palo of
	oros:
		begin

			ultimo:=cartas_recogidas_ultioros;
			primero:=cartas_recogidas_prioros;
		end;
	copas:
		begin

			ultimo:=cartas_recogidas_ulticopas;
			primero:=cartas_recogidas_pricopas;
		end;
	espadas:
		begin
     ;
			ultimo:=cartas_recogidas_ultiespadas;
			primero:=cartas_recogidas_priespadas;
		end;
	bastos:
		begin

			ultimo:=cartas_recogidas_ultibastos;
			primero:=cartas_recogidas_pribastos;
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


{
//Pedir una carta al usuario y guardarla en el
//lugar de cartas recogidas
}
procedure recoger_carta_y_guardarla(var palo:palos;var valor:valores);
var
	nuevos,ultimo,primero:tipopuntero;
begin
	dime_una_carta(palo,valor);
	case palo of
	oros:
		begin
			nuevos:=nuevo;
			ultimo:=cartas_recogidas_ultioros;
			primero:=cartas_recogidas_prioros;
		end;
	copas:
		begin
			nuevos:=nuevo;
			ultimo:=cartas_recogidas_ulticopas;
			primero:=cartas_recogidas_pricopas;
		end;
	espadas:
		begin
			nuevos:=nuevo;
			ultimo:=cartas_recogidas_ultiespadas;
			primero:=cartas_recogidas_priespadas;
		end;
	bastos:
		begin
			nuevos:=nuevo;
			ultimo:=cartas_recogidas_ultibastos;
			primero:=cartas_recogidas_pribastos;
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
			cartas_recogidas_ultioros:=ultimo;
			cartas_recogidas_prioros:=primero;
		end;
	copas:
		begin
			nuevo:=nuevos;
			cartas_recogidas_ulticopas:=ultimo;
			cartas_recogidas_pricopas:=primero;
		end;
	espadas:
		begin
			nuevo:=nuevos;
			cartas_recogidas_ultiespadas:=ultimo;
			cartas_recogidas_priespadas:=primero;
		end;
	bastos:
		begin
			nuevo:=nuevos;
			cartas_recogidas_ultibastos:=ultimo;
			cartas_recogidas_pribastos:=primero;
		end;
	end;
	ordenar_las_de_un_palo(palo);
end;

{
//Listar las cartas que han sido recogidas
}
procedure listar_cartas_recogidas;
	var
		palo:palos;
                elvalor_txt:paquete;
                elpalo_txt:paquete;
		primero,ultimo:tipopuntero;

	begin
		for palo:=oros to bastos do  {//Por cada palo}
		begin
			case palo of
			oros:
				begin

					ultimo:=cartas_recogidas_ultioros;
					primero:=cartas_recogidas_prioros;
				end;
			copas:
				begin

					ultimo:=cartas_recogidas_ulticopas;
					primero:=cartas_recogidas_pricopas;
				end;
			espadas:
				begin

					ultimo:=cartas_recogidas_ultiespadas;
					primero:=cartas_recogidas_priespadas;
				end;
			bastos:
				begin

					ultimo:=cartas_recogidas_ultibastos;
					primero:=cartas_recogidas_pribastos;
				end;
			end;

                        valores_a_texto(ultimo^.elvalor,elvalor_txt);
                        palos_a_texto(palo,elpalo_txt);
		        if ultimo <> nil {//Si hay elementos en la lista}
		        then
			begin   {//Por cada valor listar la carta}
				while primero <> ultimo do
				begin

                                        valores_a_texto(ultimo^.elvalor,elvalor_txt);
                                        palos_a_texto(palo,elpalo_txt);
					if ultimo^.elvalor <> sota
					then writeln('tengo el ',elvalor_txt,' de ',elpalo_txt)
					else writeln('tengo la ',elvalor_txt,' de ',elpalo_txt);
					ultimo:=ultimo^.siguiente;
				end;
                                if ultimo^.elvalor <> sota
                                then writeln('tengo el ',elvalor_txt,' de ',elpalo_txt)
                                else writeln('tengo la ',elvalor_txt,' de ',elpalo_txt);

			end
		        else writeln('no tengo de ',elpalo_txt);{//No hay cartas de ese palo}
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
		new(nuevo);
		nuevo^.lospalos:=palo;
		nuevo^.losvalores:=valor;
		if ultimo_de_cartas_echadas=nil
		then
			begin
				raiz_de_cartas_echadas:=nuevo;
				ultimo_de_cartas_echadas:=nuevo;
				nuevo^.aotro:=nil;
			end
		else
			begin
				ultimo_de_cartas_echadas^.aotro:=nuevo;
				ultimo_de_cartas_echadas:=nuevo;
				ultimo_de_cartas_echadas^.aotro:=nil;
			end;
		 if valor <> sota
                 then writeln('echo el ',elvalor_txt,' de ',elpalo_txt)
                 else writeln('echo la ',elvalor_txt,' de ',elpalo_txt);
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
		trol:boolean;
		palo:palos;
		valor:valores;
		cursor:cartas;
		aquel:aquello;
	begin
		if vacio=false
		then
			begin
				trol:=true; {//Se ha de presentar el texto de que se listan}
					    {//las cartas echadas.}

				cursor:=raiz_de_cartas_echadas;
				repeat
					palo:=cursor^.lospalos;
					valor:=cursor^.losvalores;
					el_o_la(trol,palo,valor);
					trol:=false;
					cursor:=cursor^.aotro;
				until cursor=nil;
				aquel:=no_hay_mas;
				no_hay_o_no_hay_mas(aquel);
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
	      	inicializar_almacenamiento_de_cartas_recogidas; {//Inicializar el almacenamiento de cartas recogidas}
      		inicializar_almacenamiento_de_cartas_echadas;   {//Inicializar el almacenamiento de cartas echadas}
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
