use handball;

CREATE OR REPLACE VIEW v_jugadores
AS 
	SELECT j.idJugador, nombre, pais as nacionalidad, fechaNacimiento, estado, posicion, altura, club, fechaInicio
	FROM jugadores as j
	LEFT JOIN estado_actividad as ea
	ON j.idEstado = ea.idEstado
	LEFT JOIN paises as p
	ON j.idNacionalidad = p.idPais
	LEFT JOIN (SELECT jp.idJugador, po.posicion 
		FROM jugadoresposiciones as jp
		LEFT JOIN posicion as po
		ON jp.idPosicion = po.idPosicion) as jpjoin
	ON j.idJugador = jpjoin.idJugador
	LEFT JOIN (select jugadoresclubes.idJugador, clubes.club, jugadoresclubes.fechaInicio from jugadoresclubes
		LEFT JOIN clubes
		ON jugadoresclubes.idClub = clubes.idClub
		where actual =1) as club_join
	ON j.idJugador = club_join.idJugador
	where j.idEstado = 1;

CREATE OR REPLACE VIEW v_jugadores_retirados
AS 
	SELECT j.idJugador, nombre, fechaNacimiento, pais as nacionalidad, estado, posicion, altura
	FROM jugadores as j
	LEFT JOIN estado_actividad as ea
	ON j.idEstado = ea.idEstado
	LEFT JOIN paises as p
	ON j.idNacionalidad = p.idPais
	LEFT JOIN (SELECT jp.idJugador, po.posicion 
		FROM jugadoresposiciones as jp
		LEFT JOIN posicion as po
		ON jp.idPosicion = po.idPosicion) as jpjoin
	ON j.idJugador = jpjoin.idJugador
	where j.idEstado = 2;
    
CREATE OR REPLACE VIEW v_clubes 
AS 
	SELECT idClub, club, arena, liga, ciudad, pais 
	FROM clubes AS c
	LEFT JOIN (
		SELECT arenas.idArena, arenas.arena
		FROM arenas
	) as arenas_sel
	ON c.idArena = arenas_sel.idArena
	LEFT JOIN ligas
	ON c.idLiga = ligas.idLiga
	LEFT JOIN (SELECT ciudades.idCiudad, ciudades.ciudad, paises.pais
		FROM ciudades
		LEFT JOIN paises
		ON ciudades.idPais = paises.idPais) as ciudadjoin
		ON c.idCiudad = ciudadjoin.idCiudad;
     
CREATE OR REPLACE VIEW v_ciudades 
AS 
	SELECT ciudades.idCiudad, ciudades.ciudad, paises.pais
	FROM ciudades
	LEFT JOIN paises
	ON ciudades.idPais = paises.idPais;
     
CREATE OR REPLACE VIEW v_ligas 
AS 
	SELECT idLiga, liga, pais from ligas
	LEFT JOIN paises
	ON ligas.idPais = paises.idPais;  

CREATE OR REPLACE VIEW v_arenas 
AS 
	select arenas.idArena, arena, capacidad, ciudad, pais, club 
	from arenas
	LEFT JOIN (
		SELECT idArena, club, ciudad, pais  FROM clubes
		LEFT JOIN (SELECT ciudades.idCiudad, ciudades.ciudad, paises.pais
			FROM ciudades
			LEFT JOIN paises
			ON ciudades.idPais = paises.idPais) as ciudadjoin
			ON clubes.idCiudad = ciudadjoin.idCiudad
	) as clubes_data
	ON arenas.idArena = clubes_data.idArena;