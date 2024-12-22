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


type
	valores=(uno,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	opcions=(recoger,listar,echar,recordar,acabar);
	palos=(oros,copas,espadas,bastos);	

	paquete= array[1..8] of char;
    	aquello=(nohay,nohaymas);
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
    	
	
	elpalo:palos;
	elvalor:valores;

	raiz_de_cartas_echadas:cartas;
	ultimo_de_cartas_echadas:cartas;
	
   	
	aquel:aquello;
	cartas_recogidas:array[oros..bastos,uno..rey] of boolean;
        cartas_echadas:array[oros..bastos,uno..rey] of boolean;

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
	k,i:integer;
begin
        k:=0;
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
	then for i:=k to 8 do entrada[i]:=' ';
end;

procedure texto_menu_opciones;
begin
	//page;
	writeln('soy un magnifico jugador de cartas');
	writeln('mis habilidades son:');
	writeln('recoger,listar,echar,recordar o acabar');
	writeln('escoge una');
end;

procedure chequeo_menu_opciones(var error1:boolean;var otro:opcions;nombre:paquete);
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
                                   writeln();
                           end;
end;


procedure opcionesconsola(var opcion:opcions);
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
	if error3=true then
                           begin
                                   write(nombre);
                                   write(':carta incorrecta');
                                   writeln();
                           end;
end;

procedure texto_menu_echar_palo;
begin
	//page;
	writeln('has escogido mi habilidad de echar cartas');
	writeln('di me de que palo quieres que la eche');
	writeln('ya sabes oros,copas,espadas o bastos');
end;

procedure chequeo_menu_echar_palo(var error2:boolean;var palo2:palos;nombre:paquete);
begin
	error2:=true;
	if nombre='oros    ' then begin error2:=false;palo2:=oros end;
	if nombre='copas   ' then begin error2:=false;palo2:=copas end;
	if nombre='espadas ' then begin error2:=false;palo2:=espadas end;
	if nombre='bastos  ' then begin error2:=false;palo2:=bastos end;
	if error2=true  then
                           begin
                                   write(nombre);
                                   write(':palo incorrecto');
                                   writeln();
                           end;
end;

procedure echardelpalo(var palo:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		texto_menu_echar_palo;
		while error do  //Repetir hasta leer un palo correcto
			begin
				leerteclado(mediador);
				chequeo_menu_echar_palo(error,palo,mediador);
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
				chequeo_menu_echar_palo(error,palote,mediador);
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

procedure cartasjugadas(var trol:boolean;palo:palos;valor:valores);
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

{
//Pesentar el texto 'no hay cartas' o 'no hay mas cartas'
//segun se indica con el parametro siaquello
}
procedure no_hay_o_no_hay_mas(var siaquello:aquello);
	begin
		case siaquello of
		nohay:
			begin
				{writeln(chr(27),chr(35),chr(51),'no hay cartas');}
				{//writeln(chr(27),chr(35),chr(52),'no hay cartas');}
                                writeln('no hay cartas');
			end;
		nohaymas: writeln('no hay mas cartas');
		end;
	end;


procedure nohaycartas(var siaquello:aquello);
	begin
		case siaquello of
		nohay:
			begin
				{writeln(chr(27),chr(35),chr(51),'no hay cartas');}
				{writeln(chr(27),chr(35),chr(52),'no hay cartas');}
				writeln('no hay cartas');
			end;
		nohaymas: writeln('no hay mas cartas');
		end;
	end;

procedure iniciar;
	var
		palo  : palos;
		valor : valores;
	begin
		for palo := oros to bastos do for valor := uno to rey do cartas_recogidas[palo,valor]:=false;
	end;

function vacio1(var palo:palos):boolean;
var
	aquel:aquello;
	cursor:valores;
	vacio:boolean;
	piloto:boolean;
begin
	piloto:=true;
	for cursor:=uno to rey do
		begin
                        vacio:=not cartas_recogidas[palo,valor];
			if vacio=false
			then
				begin
					vacio1:=false;
					piloto:=false;
				end;
	        end;
	if piloto=true
	then
		begin
			aquel:=nohay;
			nohaycartas(aquel);
			vacio1:=true;
		end;
end;

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

procedure vaciar;
	var
		palo  : palos;
		valor : valores;
	begin
		for palo := oros to bastos do for valor := uno to rey do cartas_echadas[palo,valor]:=false;
	end;

procedure inicializar_almacenamiento_de_cartas_echadas;
	begin
		raiz_de_cartas_echadas:=nil;
		ultimo_de_cartas_echadas:=nil;
	end;

procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);
          begin
               cartas_echadas[palo,valor]:=true;
               cartas_recogidas[palo,valor]:=false;
               if valor <> sota
               then writeln('echo el ',valor,' de ',palo)
               else writeln('echo la ',valor,' de ',palo);
               trol:=false;
          end;

function vacio:boolean;
var
	aquel:aquello;
begin
	if ultimo_de_cartas_echadas=nil
	then
		begin
			aquel:=nohay;
			no_hay_o_no_hay_mas(aquel);
			vacio:=true;
		end
	else
		vacio:=false;
end;

procedure cartasechadas;
          var
             i_valor:valores;
             i_palo:palos;
             trol:boolean;
          begin
           for i_palo:= oros to bastos do
               begin
                   for i_valor:= uno to rey do
                   begin
                        if cartas_echadas[i_palo,i_valor]=true
                        then
                            begin
                                 el_o_la(trol,i_palo,i_valor);
                                 trol:=false;
                            end;
                   end;
               end;
          end;

procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   vuelta:=true;
   echarpalo(palo,valor,vuelta);
   if vuelta=false
      then almacenar(palo,valor,vuelta);
 end;

procedure opciones(var opcion:opcions;var palo:palos;var valor:valores);
begin
   palo:=oros;
   valor:=tres;
   opcionesconsola(opcion);
   case opcion of
    recoger  : recogercarta(palo,valor);
    listar   : listarcartas;
    echar    : echarcarta(palo,valor,vuelta);
    recordar : cartasechadas;
    acabar   : ;
    end;
end;

begin
  	verlicencia;


      iniciar;
      vaciar;
      repeat
          palo:=copas;
	  valor:=rey;
	  opciones(opcion,palo,valor);
      until opcion=acabar;
end.	

