% Punto 1
% casa(Persona,Metros).
% departamento(Persona,Nro_De_Ambientes,Nro_De_Baños).
% loft(Persona,Año_De_Construccion).
% ubicacion(Barrio,Persona)
casa(juan,120).
casa(fer,110).
casa(rocio,90).
departamento(nico,3,2).
departamento(alf,3,1).
departamento(vale,4,1).
loft(julian,2000).
ubicacion(almagro,alf).
ubicacion(almagro,juan).
ubicacion(almagro,nico).
ubicacion(almagro,julian).
ubicacion(flores,vale).
ubicacion(flores,fer).

%Punto 2
tieneUnaCasaCopada(Persona):-
    casa(Persona,Metro_Cuadrados),Metro_Cuadrados > 100.

tieneUnDepartamentoCopado(Persona):-
    departamento(Persona,Nro_De_Ambientes,_),Nro_De_Ambientes > 3.

tieneUnDepartamentoCopado(Persona):-
    departamento(Persona,_,Nro_De_Banios), Nro_De_Banios > 1.

tieneUnLoftCopado(Persona):-
    departamento(Persona,_,Nro_De_Banios), Nro_De_Banios > 1.

vivenEnElBarrio(Barrio,Personas):-
    findall(Persona,distinct(Persona,ubicacion(Barrio,Persona)),PersonasDelBarrio),
    combinar(Personas,PersonasDelBarrio).
   
combinar([ ],[ ]).

combinar([ Persona | PersonasDelBarrio],[ Persona | Personas]):-
    combinar(PersonasDelBarrio,Personas).

combinar([_ | PersonasDelBarrio],Personas):-
    combinar(Personas,PersonasDelBarrio).

esUnBarrioCopado(Barrio):-
    ubicacion(Barrio,[Personas | _ ]),tieneUnDepartamentoCopado(Personas).
   
esUnBarrioCopado(Barrio):-
    ubicacion(Barrio,[Personas | _ ]),tieneUnaCasaCopada(Personas).

esUnBarrioCopado(Barrio):-
    ubicacion(Barrio,[Personas | _ ]),tieneUnLoftCopado(Personas).

esUnInfiernoChico(Barrio):-
    not(esUnBarrioCopado(Barrio)).

% Punto 3
tieneUnaCasaBarata(Persona):-
    casa(Persona,Metros_Cuadrados), Metros_Cuadrados  < 90.

tieneUnLoftBarato(Persona):-
    loft(Persona,Anio_De_Creacion),Anio_De_Creacion < 2005.

tieneUnDepartamentoBarato(Persona):-
    departamento(Persona,Nro_De_Ambientes,_), Nro_De_Ambientes =< 2.

esUnBarrioBarato(Barrio):-
    ubicacion(Barrio,[Personas | _ ]),tieneUnaCasaBarata(Personas).

esUnBarrioBarato(Barrio):-
    ubicacion(Barrio,[Personas | _ ]),tieneUnDepartamentoBarato(Personas).

esUnBarrioBarato(Barrio):-
    ubicacion(Barrio,[Personas | _ ]),tieneUnLoftBarato(Personas).

esUnBarrioCaro(Barrio):-
    not(esUnBarrioBarato(Barrio)).

% Punto 4
% inmueble(Propietario,Precio_De_Venta).
inmueble(juan,150000).
inmueble(nico,80000).
inmueble(alf,75000).
inmueble(julian,140000).
inmueble(vale,95000).
inmueble(fer,60000).

sePuedeComprarCasasCon250000_a(Propietarios):-
    inmueble(Propietarios,Precio),Precio < 250000.

restoPorCompra(Resto,Propietario):-
    inmueble(Propietario,Precio),
    Resto is 250000 - Precio.

sublista([ ],[ ]).

sublista([ Cabeza | Cola],[ Cabeza | Sublista]):- sublista(Cola,Sublista).
    
sublista([_ | Cola],Sublista):- sublista(Cola,Sublista).

restoPorComprasRealizadas(Restos,Propietarios):-
    findall(Resto,distinct(Resto,restoPorCompra(Resto,_)),RestosPosibles),
    sublista(RestosPosibles,Restos),
    vendedores(Propietarios).
    
vendedores(Propietarios):-
    findall(Propietario,distinct(Propietario,inmueble(Propietario,_)),PropietariosRegistrados),
    sublista(PropietariosRegistrados,Propietarios).




