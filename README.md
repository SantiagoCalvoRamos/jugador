# jugador Copyrigth (C) 2024 Santiago Calvo Ramos

Este código fue escrito originalmente para se compilado y ejecutado
en el ordenador VAX-VMS de la Escuela Uinversitaria de Ingeniería
Ténica de Telecomunición (EUITT) de la Universid Politécnica de
Madrid (UPM) durante el primer quinquenio de la década de los ochentas.

El código consiste en manejar una baraja española y guardar en la mano
las cartas que se vayan recogiendo según las normas del juego, que
aquí no se tienen en cuenta, y echar una de ellas (la de mas peso)
guardando constancia de que cartas han sido echadas.

Originalmente el código fuente fué dividido en módulos compilables de
manera separada para posteriormente ser enlazados para construir el
ejecutable. Para el almacenamiento de las cartas que han sido recogidas
o echadas se usaron: punteros y su listas enlazadas en el módulo
diquepun, archivos en el módulo almacen y matrices en el módulo matriz.
Los módulos comunes son consola y jugador, que se enlazaran con alguno
de los otros según se quiera el tipo de almacenamiento usado para guardar
las cartas recogidas o echadas.

El módulo consola se encarga de la entrada y salida al usuario por el
terminal en modo texto. Y finalemnte en el módulo jugador se encuentra
la entrada al programa principal con su inicialización y el bucle principal
del programa.
 
