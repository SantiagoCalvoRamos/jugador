module almacen(output,echadas);
type
	palos=(oros,copas,espadas,bastos);
	valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);
	carta=record
		palo:palos;
		valor:valores;
		end;
	aquel=(nohay,nohaymas);
var
	echadas:file of carta;
	asociado:file of carta;
	elpalo:palos;
	elvalor:valores;
	replica:carta;

[external]procedure nohaycartas(aquello:aquel);extern;
[external]procedure cartasjugadas(var trol:boolean;elpalo:palos;elvalor:valores);extern;
[global]procedure vaciar;
	begin
		rewrite(echadas);
	end;
[global]procedure almacenar(var elpalo:palos;elvalor:valores);
	var
		cartas:carta;
	begin
		replica.palo:=elpalo;
		replica.valor:=elvalor;
		if elvalor<>sota then write('echo el ',elvalor, 'de ',elpalo)
                                                            else write('echo la',elvalor,' de ',elpalo);
		write(echadas,replica);
	end;

	function vacio:boolean;
	var
		aquello:aquel;
	begin
		reset(echadas);
		if eof(echadas);
		then 
		          begin
			aquello:=nohay;
			nohaycartas:=aquello;
			vacio:=true;
		          end
		 else
			vacio:=false;
	end;
	
[global]procedure cartasechadas;
	var
		cartas:carta;
		aquello:aquel;
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
				aquello:=nohaymas;
				nohaycartas(aquello);
			end;
		end;
	end.
