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
	valores=(el_as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	opcions=(recoger,listar,echar,recordar,acabar);
	palos=(oros,copas,espadas,bastos);	
	tipopuntero=^colas;
	colas=  record
		        elvalor:valores;
		        siguiente:tipopuntero;
		        anterior:tipopuntero;
		end;	
	paquete= array[1..8] of char;
    	aquello=(nohay,nohaymas);
	cartas=^carta;
	carta=  record
		        lospalos:palos;
		        losvalores:valores;
		        aotro:cartas;
	        end;


var 	
	palo:palos;
    	valor:valores;
    	vuelta:boolean;
    	opcion:opcions;
	asociado:file of carta;
	echadas:file of carta;
	elpalo:palos;
	elvalor:valores;
	replica:carta;
   	prioros,pricopas,priespadas,pribastos,nuevo,ultioros,ulticopas,ultiespadas,ultibastos:tipopuntero;
	supalo:palos;
	suvalor:valores;
	aquel:aquello;
	raiz:cartas;
	ultimo:cartas;	
	cartas_recogidas:array[oros..bastos,el_as..rey] of boolean;
        cartas_echadas:array[oros..bastos,el_as..rey] of boolean;


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
	if nombre='as      ' then begin error3:=false;valor:=el_as end;
	if nombre='2       ' then begin error3:=false;valor:=dos end;
	if nombre='3       ' then begin error3:=false;valor:=tres end;
	if nombre='4       ' then begin error3:=false;valor:=cuatro end;
	if nombre='5       ' then begin error3:=false;valor:=cinco end;
	if nombre='6       ' then begin error3:=false;valor:=seis end;
	if nombre='7       ' then begin error3:=false;valor:=siete end;
	if nombre='sota    ' then begin error3:=false;valor:=sota end;
	if nombre='caballo ' then begin error3:=false;valor:=sota end;
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

procedure echardelpalo(var palo3:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		texto_menu_echar_palo;
		while error do  //Repetir hasta leer un palo correcto
			begin
				leerteclado(mediador);
				chequeo_menu_echar_palo(error,palo3,mediador);
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

procedure nohaycartas(var siaquello:aquello);
	begin
		case siaquello of
		nohay:
			begin
				writeln(chr(27),chr(35),chr(51),'no hay cartas');
				writeln(chr(27),chr(35),chr(52),'no hay cartas');
			end;
		nohaymas: writeln('no hay mas cartas');
		end;
	end;

procedure iniciar;
	var
		palo:palos;
		valor:valores;
	begin
		for palo:=oros to bastos do
			for valor:=el_as to rey do
                                cartas_recogidas[palo,valor]:=false;
	end;

function vacio1(var palo:palos):boolean;
var
	aquel:aquello;
	cursor:valores;
	vacio:boolean;
	piloto:boolean;
begin
	piloto:=true;
	for cursor:=el_as to rey do
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
	cursor:valores;
begin
	echardelpalo(palo);
	vacio:=vacio1(palo);
	if vacio=false
	then
		for cursor:=el_as to rey do
                        if cartas_recogidas[palo,cursor]=true
			then
				valor:=cursor;
        cartas_recogidas[palo,valor]:=false;
        cartas_echadas[palo,valor]:=true;
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
				for valor:=el_as to rey do
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
	begin
		raiz:=nil;
		ultimo:=nil;
	end;

procedure almacenar(var palo:palos;var valor:valores;var trol:boolean);
	var
		nuevo:cartas;
	begin
		new(nuevo);
		nuevo^.lospalos:=palo;
		nuevo^.losvalores:=valor;
		if ultimo=nil
		then
			begin
				raiz:=nuevo;
				ultimo:=nuevo;
				nuevo^.aotro:=nil;
			end
		else
			begin
				ultimo^.aotro:=nuevo;
				ultimo:=nuevo;
				ultimo^.aotro:=nil;
			end;
		writeln('echo el ',valor,' de ',palo);
	end;

function vacio:boolean;
var
	aquel:aquello;
begin
	if ultimo=nil
	then
		begin
			aquel:=nohay;
			nohaycartas(aquel);
			vacio:=true;
		end
	else
		vacio:=false;
end;

procedure cartasechadas;
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
				trol:=true;
				cursor:=raiz;
				repeat
					palo:=cursor^.lospalos;
					valor:=cursor^.losvalores;
					cartasjugadas(trol,palo,valor);
					trol:=false;
					cursor:=cursor^.aotro;
				until cursor=nil;
				aquel:=nohaymas;
				nohaycartas(aquel);
			end;
	end;
procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
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
      iniciar;
      vaciar;
      repeat
          palo:=copas;
	  valor:=rey;
	  opciones(opcion,palo,valor);
      until opcion=acabar;
end.	

