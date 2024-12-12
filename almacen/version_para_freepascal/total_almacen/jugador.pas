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
program total(output,echadas,asociado);


type
        //Cartas de la baraja espanola
	valores=(el_as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	palos=(oros,copas,espadas,bastos);

        //Opciones en el menu de entrada
        opcions=(recoger,listar,echar,recordar,acabar);

        //Tipo de datos representando las cartas
        carta=record
		palo:palos;
		valor:valores;
	end;

        //Base de datos a listaas dinamicas
	tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;

        //Para leer la entrada desde el teclado
	paquete=array[1..8] of char;

        //Si hay cartas o no hay en el sistema de almacenamiento
    	aquello=(nohay,nohaymas);



var
        //Las cartas
        palo:palos;
    	valor:valores;

    	vuelta:boolean;

        //Opciones del menu
    	opcion:opcions;

        //Archivos para guardar los datos
	asociado:file of carta;
	echadas:file of carta;

	elpalo:palos;
	elvalor:valores;
	replica:carta;

        //Punteros para usar en el almacenamiento dinamico
        prioros,
        pricopas,
        priespadas,
        pribastos,
        nuevo,
        ultioros,
        ulticopas,
        ultiespadas,
        ultibastos:tipopuntero;

        supalo:palos;
	suvalor:valores;
	aquel:aquello;



procedure leerteclado(var entrada:paquete);
var
	c:char;
	k:integer;
begin
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

procedure echardelpalo(var palo3:palos);
	var
		mediador:paquete;
		error:boolean;
	begin
		error:=true;
		cabeza2;
		while error do
			begin
				leerteclado(mediador);
				fallo2(error,palo3,mediador);
			end;
	end;

procedure cabeza3;
begin
	//page;
	writeln('has escogido mi habilidad de recoger cartas');
	writeln('di me el palo y valor de la carta');
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

procedure vaciar;
	begin
		assign(echadas,'echadas');
		rewrite(echadas);
		assign(asociado,'asociado');
                rewrite(asociado);
	end;


procedure almacenar(var elpalo:palos;elvalor:valores);
	var
		cartas:carta;
	begin
		replica.palo:=elpalo;
		replica.valor:=elvalor;
		if elvalor<>sota
		then
			write('echo el ',elvalor, 'de ',elpalo)
                else
                	write('echo la',elvalor,' de ',elpalo);
		write(echadas,replica);
	end;

function vacio:boolean;
	var
		aquel:aquello;
	begin
		reset(echadas);
		if eof(echadas)
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
		cartas:carta;
		aquel:aquello;
		trol:boolean;
	begin
		if vacio=false
		then
			begin
				trol:=true;
				rewrite(asociado);
				while not eof(echadas) do
					begin
						read(echadas,cartas);
						elpalo:=cartas.palo;
						elvalor:=cartas.valor;
						write(asociado,cartas);
						cartasjugadas(trol,elpalo,elvalor);
						trol:=false;
					end;
				reset(asociado);
				rewrite(echadas);
				while not eof(asociado) do
					begin
						read(asociado,cartas);
						write(echadas,cartas);
					end;
				aquel:=nohaymas;
				nohaycartas(aquel);
			end;
		end;

procedure echarcarta(var palo:palos;var valor:valores;var vuelta:boolean);
 begin
   echarpalo(palo,valor,vuelta);
   if vuelta=false
      then almacenar(palo,valor);
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

