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
program jugador(output,echadas,asociado);


type
        {//Cartas de la baraja espanola}
	valores=(uno,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	palos=(oros,copas,espadas,bastos);

        {//Opciones en el menu de entrada}
        opcions=(recoger,listar,echar,recordar,acabar);

        {//Tipo de datos representando las cartas}
        carta=record
		palo:palos;
		valor:valores;
	end;

        {//Base de datos a listaas dinamicas}
	tipopuntero=^colas;
	colas=record
		elvalor:valores;
		siguiente:tipopuntero;
		anterior:tipopuntero;
		end;

        {//Para leer la entrada desde el teclado}
	paquete=array[1..8] of char;

        {//Si hay cartas o no hay en el sistema de almacenamiento}
    	aquello=(nohay,nohaymas);
        p=^paquete;


var
        {//Las cartas}
        palo:palos;
    	valor:valores;

    	vuelta:boolean;

        {//Opciones del menu}
    	opcion:opcions;

        {//Archivos para guardar los datos}
	asociado:file of carta;
	echadas:file of carta;

	elpalo:palos;
	elvalor:valores;
	replica:carta;

        {//Punteros para usar en el almacenamiento dinamico}
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

procedure cabeza2;
begin
	{//page;}
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
	{//page;}
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
		then writeln('el ',valor_a_txt(valor)^,' de ',palo_a_txt(palo)^)
		else writeln('la ',valor_a_txt(valor)^,' de ',palo_a_txt(palo)^);
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

{
//Preguntar al usuario de que palo se ha de echar
//la carta comprobando si de ese palo hay cartas
//en el almacenamiento de cartas recogidas
//procedure echar_carta_de_un_palo(var palo:palos;var valor:valores;var vacio:boolean);
}
procedure echarpalo(var palo:palos;var valor:valores;var vacio:boolean);

	var
                a_borrar,
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
                                                 else nohaycartas(aquel); {//writeln('no hay de ese palo');}
                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
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
                                                 else nohaycartas(aquel);{//writeln('no hay de ese palo');}


                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
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
                                                 else nohaycartas(aquel);{//writeln('no hay de ese palo');}

                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
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
                                                 else nohaycartas(aquel);{//writeln('no hay de ese palo');}

                                        end;
                                {//writeln('falta el codigo para eliminar la carta');}
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
		{end;}
	        if ultimo <> nil
	        then
		    begin
			while primero <> ultimo do
			begin
				if ord(ultimo^.elvalor) <> ord(sota)
				then writeln('tengo el ',valor_a_txt(ultimo^.elvalor)^,' de ',palo_a_txt(palo)^)
				else writeln('tengo la ',valor_a_txt(ultimo^.elvalor)^,' de ',palo_a_txt(palo)^);
				ultimo:=ultimo^.siguiente;
			end;
			if ultimo^.elvalor <> sota
			then writeln('tengo el ',valor_a_txt(ultimo^.elvalor)^,' de ',palo_a_txt(palo)^)
			else writeln('tengo la ',valor_a_txt(ultimo^.elvalor)^,' de ',palo_a_txt(palo)^);
		        end
	                else writeln('no tengo de ',palo_a_txt(palo)^);
                    end;
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
			writeln('echo el ',valor_a_txt(elvalor)^,' de ',palo_a_txt(elpalo)^)
                else
                	writeln('echo la',valor_a_txt(elvalor)^,' de ',palo_a_txt(elpalo)^);
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
   vuelta:=true;
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
      iniciar_consola;
      iniciar;
      vaciar;
      verlicencia;
      repeat
          palo:=copas;
	  valor:=rey;
	  opciones(opcion,palo,valor);
      until opcion=acabar;
end.

