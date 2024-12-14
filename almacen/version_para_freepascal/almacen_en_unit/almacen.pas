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
unit almacen;

interface
uses
cartasen,consola;

type
	carta=record
		palo:palos;
		valor:valores;
		end;

var
	echadas:file of carta;
	asociado:file of carta;
	replica:carta;
        elpalo:palos;
	elvalor:valores;

{
type
	palos=(oros,copas,espadas,bastos);
	valores=(as,dos,tres,cuatro,cinco,seis,siete,sota,caballo,rey);

	//aquel=(nohay,nohaymas);
var
	echadas:file of carta;
	asociado:file of carta;
	elpalo:palos;
	elvalor:valores;
	replica:carta;
}

//[external]procedure nohaycartas(aquello:aquel);extern;
//[external]procedure cartasjugadas(var trol:boolean;elpalo:palos;elvalor:valores);extern;

procedure vaciar;
procedure almacenar(var elpalo:palos;elvalor:valores);
procedure cartasechadas;


implementation
//[global]
procedure vaciar;
	begin
                assign(echadas,'echadas');
                rewrite(echadas);
                assign(asociado,'asociado');
                rewrite(asociado);
	end;

//[global]
procedure almacenar(var elpalo:palos;elvalor:valores);
	var
		cartas:carta;
	begin
		replica.palo:=elpalo;
		replica.valor:=elvalor;
		if elvalor<>sota
                then writeln('echo el ',elvalor,' de ',elpalo)
                else writeln('echo la ',elvalor,' de ',elpalo);
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

//[global]
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
	end.
