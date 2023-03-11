use handball; 

DELIMITER $$
CREATE FUNCTION nombre_club_jugadores (id_jugador INT)
RETURNS VARCHAR(200) 
DETERMINISTIC
BEGIN
	DECLARE nombre_club VARCHAR(200);
    SET nombre_club = (SELECT clubes.club
		FROM jugadoresclubes 
		LEFT JOIN clubes
		ON jugadoresclubes.idClub = clubes.idClub
		WHERE jugadoresclubes.idJugador = id_jugador and jugadoresclubes.actual = 1);
	RETURN nombre_club;
END
$$

DELIMITER $$
CREATE FUNCTION cantidad_jugadores_en_club (id_club INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cantidad_jugadores INT;
    SET cantidad_jugadores = (SELECT COUNT(*)
		FROM jugadoresclubes 
		WHERE jugadoresclubes.idClub = id_club and jugadoresclubes.actual = 1);
	RETURN cantidad_jugadores;
END
$$

DELIMITER $$
CREATE FUNCTION cantidad_clubes_en_liga (id_liga INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cantidad_clubes INT;
    SET cantidad_clubes = (SELECT COUNT(*)
		FROM clubes 
		WHERE clubes.idLiga = id_liga);
	RETURN cantidad_clubes;
END
$$

DELIMITER $$
CREATE FUNCTION cantidad_clubes_en_liga_txt (id_liga INT)
RETURNS TEXT(1000)
NOT DETERMINISTIC
NO SQL
BEGIN
	DECLARE cantidad_clubes INT;
    DECLARE nombre_liga VARCHAR(500);
    SET cantidad_clubes = (
		SELECT COUNT(*)
		FROM clubes 
		WHERE clubes.idLiga = id_liga);
    SET nombre_liga = (
		SELECT ligas.liga
        FROM ligas
        WHERE ligas.idLiga = id_liga
    );
	RETURN CONCAT("La liga ", nombre_liga, " tiene ", cantidad_clubes, " equipos");
END
$$

DELIMITER $$
CREATE FUNCTION nombres_jugadores_en_club (id_club INT)
RETURNS TEXT(2000)
NOT DETERMINISTIC
NO SQL
BEGIN
	DECLARE lista_nombres TEXT(2000);
    DECLARE nombre_club VARCHAR(200);
    SET lista_nombres = (SELECT GROUP_CONCAT(nombre SEPARATOR ', ')
		FROM jugadores
		LEFT JOIN jugadoresclubes
		ON jugadores.idJugador = jugadoresclubes.idJugador
		WHERE jugadoresclubes.idClub = id_club and jugadoresclubes.actual = 1);
	SET nombre_club = (
		SELECT club FROM clubes
        WHERE clubes.idClub = id_club
    );
	RETURN CONCAT("Lista de jugadores del club ", nombre_club, ": ", lista_nombres);
END
$$