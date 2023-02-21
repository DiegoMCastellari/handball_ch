USE handball;

CREATE TABLE posicion (
	idPosicion INT NOT NULL AUTO_INCREMENT,
    posicion VARCHAR(50) NOT NULL,
    PRIMARY KEY (idPosicion)
);

CREATE TABLE estado (
	idEstado INT NOT NULL AUTO_INCREMENT,
    estado VARCHAR(50) NOT NULL,
    PRIMARY KEY (idEstado)
);

CREATE TABLE paises (
	idPais INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(100) NOT NULL,
    PRIMARY KEY (idPais)
);

CREATE TABLE ciudades (
	idCiudad INT NOT NULL AUTO_INCREMENT,
    ciudad VARCHAR(100) NOT NULL,
    idPais INT NOT NULL,
    PRIMARY KEY (idCiudad),
    FOREIGN KEY (idPais) REFERENCES paises(idPais)
);

CREATE TABLE arenas (
	idArena INT NOT NULL AUTO_INCREMENT,
    arena VARCHAR(500) NOT NULL,
    capacidad INT,
    PRIMARY KEY (idArena)
);

CREATE TABLE ligas (
	idLiga INT NOT NULL AUTO_INCREMENT,
    liga VARCHAR(500) NOT NULL,
    idPais INT NOT NULL,
    PRIMARY KEY (idLiga),
    FOREIGN KEY (idPais) REFERENCES paises(idPais)
);

CREATE TABLE jugadores (
	idJugador INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(500) NOT NULL,
    altura DOUBLE,
    fechaNacimiento DATE,
    idNacionalidad INT NOT NULL,
    idEstado INT NOT NULL,
    PRIMARY KEY (idJugador),
    FOREIGN KEY (idNacionalidad) REFERENCES paises(idPais),
    FOREIGN KEY (idEstado) REFERENCES estado(id)
);

CREATE TABLE clubes (
	idClub INT NOT NULL AUTO_INCREMENT,
    club VARCHAR(200) NOT NULL,
    idCiudad INT NOT NULL,
    idArena INT NOT NULL,
    idLiga INT NOT NULL,
    PRIMARY KEY (idClub),
    FOREIGN KEY (idCiudad) REFERENCES ciudades(idCiudad),
    FOREIGN KEY (idArena) REFERENCES arenas(idArena),
    FOREIGN KEY (idLiga) REFERENCES ligas(idLiga)
);

CREATE TABLE ligas (
	idLiga INT NOT NULL AUTO_INCREMENT,
    liga VARCHAR(500) NOT NULL,
    idPais INT NOT NULL,
    PRIMARY KEY (idLiga),
    FOREIGN KEY (idPais) REFERENCES paises(idPais)
);

CREATE TABLE jugadoresClubes (
	idJugadorClub INT NOT NULL AUTO_INCREMENT,
	idJugador INT NOT NULL,
    idClub INT NOT NULL,
    actual BOOL NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE,
    PRIMARY KEY (idJugadorClub),
    FOREIGN KEY (idJugador) REFERENCES jugadores(idJugador),
    FOREIGN KEY (idClub) REFERENCES clubes(idClub)
)

	
