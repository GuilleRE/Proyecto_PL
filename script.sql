SET SERVEROUTPUT ON;
--Base de Datos de La Liga
--Creacion de tablas e introduccion de datos
--Es una base de datos con los equipos, partidos, jugadores, premios y los arbitros de los partidos

DROP TABLE EQUIPOS CASCADE CONSTRAINTS;
DROP TABLE PARTIDOS CASCADE CONSTRAINTS;
DROP TABLE PREMIOS CASCADE CONSTRAINTS;
DROP TABLE ARBITROS CASCADE CONSTRAINTS;
DROP TABLE JUGADORES CASCADE CONSTRAINTS;


--La tabla equipo tiene una primary key, cod_equipo y un nombre de equipo unico ya que no puede haber dos equipos con el mismo nombre
CREATE TABLE EQUIPOS(
    COD_EQUIPO NUMBER(4),
    NOMBRE_EQUIPO VARCHAR2(20),
    PARTIDOS_JUGADOS NUMBER(2),
    VICTORIAS NUMBER(2),
    EMPATES NUMBER(2),
    DERROTAS NUMBER(2),
    GOLES_FAVOR NUMBER(2),
    GOLES_CONTRA NUMBER(2),
    DIFERENCIA_GOLES NUMBER(2),
    PUNTOS NUMBER(3),
    CONSTRAINT EQU_PK PRIMARY KEY(COD_EQUIPO),
    CONSTRAINT EQU_NOM_UNI UNIQUE(NOMBRE_EQUIPO)
);

--La table jugadores tiene una primary key, nif del jugador, una foreign key, cod_equipo que referencia al equipo para el que juega.
--Y una condicion que es si el pais es España tiene que especificarse la provincia y si no es de España la provincia tiene que ser null.
CREATE TABLE JUGADORES(
    NIF NUMBER(9),
    COD_EQUIPO NUMBER(4),
    NOMBRE VARCHAR2(20) NOT NULL,
    APELLIDO1 VARCHAR2(20) NOT NULL,
    APELLIDO2 VARCHAR2(20),
    PAIS VARCHAR2(20),
    PROVINCIA VARCHAR2(20),
    DORSAL NUMBER(3),
    CONSTRAINT JUG_PK PRIMARY KEY(NIF),
    CONSTRAINT JUG_PAI_CH CHECK((UPPER(PAIS)<>'ESPAÑA' AND UPPER(PROVINCIA)=NULL) OR UPPER(PAIS) LIKE 'ESPAÑA'),
    CONSTRAINT JUG_FK FOREIGN KEY(COD_EQUIPO) REFERENCES EQUIPOS(COD_EQUIPO)
);

--La tabla arbitros tiene una primary key, cod_arbitro y un dni unico que puede ser candidato a primary key.
CREATE TABLE ARBITROS(
    COD_ARBITRO NUMBER(4),
    NOMBRE VARCHAR2(20) NOT NULL,
    APELLIDO1 VARCHAR2(20) NOT NULL,
    APELLIDO2 VARCHAR2(20),
    DNI NUMBER(8),
    PATIDOS_DIRIGIDOS NUMBER(2),
    CONSTRAINT ARB_PK PRIMARY KEY(COD_ARBITRO),
    CONSTRAINT ARB_DNI UNIQUE(DNI)
);


--La tabla partidos constra de una primary key compuesta, cod_equipo_local y cod_equipo_visitante que a su vez es foreign key de equipo.
--Y además otra foreign key, arbitro que referencia a la tabla arbitro.
CREATE TABLE PARTIDOS(
    COD_EQUIPO_LOCAL NUMBER(4),
    COD_EQUIPO_VISITANTE NUMBER(4),
    ARBITRO NUMBER(2),
    ESTADIO VARCHAR2(80) NOT NULL,
    GOLES_LOCAL NUMBER(2),
    GOLES_VISITANTE NUMBER(2),
    TARJETAS_AMARILLAS NUMBER(2),
    TARJETAS_ROJAS NUMBER(2),
    FALTAS NUMBER(3),
    SAQUES_ESQUINA NUMBER(3),
    PENALTIS NUMBER(1),
    CONSTRAINT PAR_PK PRIMARY KEY(COD_EQUIPO_LOCAL,COD_EQUIPO_VISITANTE),
    CONSTRAINT PAR_FK FOREIGN KEY(COD_EQUIPO_LOCAL) REFERENCES EQUIPOS(COD_EQUIPO),
    CONSTRAINT PAR_FK2 FOREIGN KEY(COD_EQUIPO_VISITANTE) REFERENCES EQUIPOS(COD_EQUIPO),
    CONSTRAINT PAR_FK3 FOREIGN KEY(ARBITRO) REFERENCES ARBITROS(COD_ARBITRO)
);

--La tabla premio tiene una primary key, cod_equipo que a su vez referencia a la tabla equipos.
CREATE TABLE PREMIOS(
    COD_EQUIPO NUMBER(4),
    TIPO_PREMIO VARCHAR2(30),
    RECOMPENSA NUMBER(10),
    CONSTRAINT PRE_PK PRIMARY KEY(COD_EQUIPO),
    CONSTRAINT PRE_FK FOREIGN KEY(COD_EQUIPO) REFERENCES EQUIPOS(COD_EQUIPO)
);

--Introducción de datos tabla EQUIPOS

INSERT INTO EQUIPOS VALUES(1,'Real Madrid',35,25,6,4,73,30,43,81);
INSERT INTO EQUIPOS VALUES(2,'Barcelona',35,20,9,6,65,35,30,69);
INSERT INTO EQUIPOS VALUES(3,'Sevilla',35,17,14,4,51,29,22,65);
INSERT INTO EQUIPOS VALUES(4,'Atlético Madrid',35,19,7,9,60,41,19,64);
INSERT INTO EQUIPOS VALUES(5,'Betis',35,17,7,11,57,40,17,58);
INSERT INTO EQUIPOS VALUES(6,'Real Sociedad',35,15,11,9,34,34,0,56);
INSERT INTO EQUIPOS VALUES(7,'Villarreal',35,14,11,10,55,34,21,53);
INSERT INTO EQUIPOS VALUES(8,'Athletic',35,13,13,9,41,34,7,52);
INSERT INTO EQUIPOS VALUES(9,'Osasuna',35,12,10,13,36,46,-10,46);
INSERT INTO EQUIPOS VALUES(10,'Valencia C.F.',35,10,14,11,45,49,-4,44);
INSERT INTO EQUIPOS VALUES(11,'Celta de Vigo',35,11,10,14,41,38,3,43);
INSERT INTO EQUIPOS VALUES(12,'Rayo Vallecano',35,11,9,15,35,39,-4,42);
INSERT INTO EQUIPOS VALUES(13,'RCD Espanyol',35,10,10,15,38,50,-12,40);
INSERT INTO EQUIPOS VALUES(14,'Elche C.F.',35,10,9,16,37,48,-11,39);
INSERT INTO EQUIPOS VALUES(15,'Getafe',35,8,13,14,31,37,-6,37);
INSERT INTO EQUIPOS VALUES(16,'Cádiz',35,7,14,14,33,47,-14,35);
INSERT INTO EQUIPOS VALUES(17,'Granada',35,7,13,15,43,59,-16,34);
INSERT INTO EQUIPOS VALUES(18,'R.C.D. Mallorca',35,8,8,19,32,62,-30,32);
INSERT INTO EQUIPOS VALUES(19,'Levante',35,6,11,18,44,67,-23,39);
INSERT INTO EQUIPOS VALUES(20,'Alavés',35,7,7,21,28,60,-32,28);

--Introducción de datos tabla JUGADORES

INSERT INTO JUGADORES VALUES (1,1,'Thibaut','Courtois',null,'Belgica',null,1);
INSERT INTO JUGADORES VALUES (2,1,'Dani','Carvajal',null,'España','Leganés',2);
INSERT INTO JUGADORES VALUES (3,1,'Éder','Militão',null,'Brasil',null,3);
INSERT INTO JUGADORES VALUES (4,1,'Nacho','Fernandez','Iglesias','España','Madrid',6);
INSERT INTO JUGADORES VALUES (5,1,'Ferland','Mendy',null,'Francia',null,23);
INSERT INTO JUGADORES VALUES (6,1,'Casemiro','null',null,'Brasil',null,14);
INSERT INTO JUGADORES VALUES (7,1,'Tony','Kroos',null,'Alemania',null,8);
INSERT INTO JUGADORES VALUES (8,1,'Federico','Valverde',null,'Uruguay',null,16);
INSERT INTO JUGADORES VALUES (9,1,'Luka','Modrić',null,'Croacia',null,10);
INSERT INTO JUGADORES VALUES (10,1,'Vinícius','Junior',null,'Brasil',null,20);
INSERT INTO JUGADORES VALUES (11,1,'Karin','Benzema',null,'Francia',null,9);

INSERT INTO JUGADORES VALUES (12,2,'Marc-André','ter Stegen',null,'Alemania',null,1);
INSERT INTO JUGADORES VALUES (13,2,'Dani','Alves',null,'Brasil',null,8);
INSERT INTO JUGADORES VALUES (14,2,'Ronald','Araújo',null,'Uruguay',null,4);
INSERT INTO JUGADORES VALUES (15,2,'Gerard','Piqué','Bernabéu','España','Barcelona',3);
INSERT INTO JUGADORES VALUES (16,2,'Jordi','Alba','Ramos','España','Barcelona',18);
INSERT INTO JUGADORES VALUES (17,2,'Frenkie','de Jong',null,'Países Bajos',null,21);
INSERT INTO JUGADORES VALUES (18,2,'Sergio','Busquets','Burgos','España','Barcelona',5);
INSERT INTO JUGADORES VALUES (19,2,'Pablo Martín','Páez','Gavira','España','Sevilla',30);
INSERT INTO JUGADORES VALUES (20,2,'Ferran','Torres','García','España','Valencia',19);
INSERT INTO JUGADORES VALUES (21,2,'Pierre-Emerick','Aubameyang',null,'Francia',null,25);
INSERT INTO JUGADORES VALUES (22,2,'Memphis','Depay',null,'Países Bajos',null,9);

INSERT INTO JUGADORES VALUES (23,3,'Jan','Oblak',null,'Eslovenia',null,13);
INSERT INTO JUGADORES VALUES (24,3,'Stefan','Savić',null,'Montenegro',null,15);
INSERT INTO JUGADORES VALUES (25,3,'José María','Giménez',null,'Uruguay',null,2);
INSERT INTO JUGADORES VALUES (26,3,'Reinildo','Mandava',null,'Mozambique',null,23);
INSERT INTO JUGADORES VALUES (27,3,'Geoffrey','Kondogbia',null,'Francia',null,4);
INSERT INTO JUGADORES VALUES (28,3,'Marcos','Llorente','Moreno','España','Madrid',14);
INSERT INTO JUGADORES VALUES (29,3,'Yannick','Carrasco',null,'Bélgica',null,21);
INSERT INTO JUGADORES VALUES (30,3,'Rodrigo','De Paul',null,'Argentina',null,5);
INSERT INTO JUGADORES VALUES (31,3,'Koke','Resurrección','Merodio','España','Madrid',6);
INSERT INTO JUGADORES VALUES (32,3,'Antoine','Griezmann',null,'Francia',null,8);
INSERT INTO JUGADORES VALUES (33,3,'Luis','Suárez','Díaz','Uruguay',null,9);

INSERT INTO JUGADORES VALUES (34,4,'Yassine','Bounou',null,'Marruecos',null,13);
INSERT INTO JUGADORES VALUES (35,4,'Marcos','Acuña',null,'Argentina',null,19);
INSERT INTO JUGADORES VALUES (36,4,'Diego Carlos','Santos','Silva','Brasil',null,20);
INSERT INTO JUGADORES VALUES (37,4,'Jules','Koundé',null,'Francia',null,23);
INSERT INTO JUGADORES VALUES (38,4,'Gonzalo','Montiel',null,'Argentina',null,2);
INSERT INTO JUGADORES VALUES (39,4,'Thomas','Delaney','Hansen','Dinamarca',null,18);
INSERT INTO JUGADORES VALUES (40,4,'Nemanja','Gudelj',null,'Serbia',null,6);
INSERT INTO JUGADORES VALUES (41,4,'Ivan','Rakitić',null,'Suiza',null,10);
INSERT INTO JUGADORES VALUES (42,4,'Alejandro Darío','Gómez',null,'Argentina',null,24);
INSERT INTO JUGADORES VALUES (43,4,'Youssef','En-Nesyri',null,'Marruecos',null,15);
INSERT INTO JUGADORES VALUES (44,4,'Jesús Manuel','Corona',null,'México',null,5);

INSERT INTO JUGADORES VALUES (45,5,'Rui','Silva',null,'Portugal',null,13);
INSERT INTO JUGADORES VALUES (46,5,'Héctor','Bellerín','Moruno','España','Barcelona',19);
INSERT INTO JUGADORES VALUES (47,5,'Germán','Pezzella',null,'Argentina',null,16);
INSERT INTO JUGADORES VALUES (48,5,'Edgar','González','Estrada','España','Barcelona',3);
INSERT INTO JUGADORES VALUES (49,5,'Alexandre','Moreno','Lopera','España','Barcelona',15);
INSERT INTO JUGADORES VALUES (50,5,'Guido','Rodríguez',null,'Argentina',null,21);
INSERT INTO JUGADORES VALUES (51,5,'William','Silva','Carvalho','Portugal',null,14);
INSERT INTO JUGADORES VALUES (52,5,'Sergio','Canales','Madrazo','España','Cantabria',10);
INSERT INTO JUGADORES VALUES (53,5,'Nabil','Fekir',null,'Francia',null,8);
INSERT INTO JUGADORES VALUES (54,5,'Juan Miguel','Jiménez','López','España','Málaga',7);
INSERT INTO JUGADORES VALUES (55,5,'Borja','Iglesias','Quintás','España','La Coruña',9);

INSERT INTO JUGADORES VALUES (56,6,'Alejandro','Remiro','Gargallo','España','Pamplona',1);
INSERT INTO JUGADORES VALUES (57,6,'Diego','Rico','Salguero','España','Burgos',15);
INSERT INTO JUGADORES VALUES (58,6,'Robin','Le Normand',null,'Francia',null,24);
INSERT INTO JUGADORES VALUES (59,6,'Igor','Zubeldia','Elorza','España','San Sebastián',5);
INSERT INTO JUGADORES VALUES (60,6,'Joseba','Zaldua','Bengoetxea','España','San Sebastián',2);
INSERT INTO JUGADORES VALUES (61,6,'Asier','Illarramendi','Andonegi','España','Guipúzcoa',4);
INSERT INTO JUGADORES VALUES (62,6,'Martín','Zubimendi','Ibáñez','España','San Sebastián',3);
INSERT INTO JUGADORES VALUES (63,6,'Mikel','Merino','Zazón','España','Pamplona',8);
INSERT INTO JUGADORES VALUES (64,6,'Alexander','Sørloth',null,'Noruega',null,23);
INSERT INTO JUGADORES VALUES (65,6,'David Josué','Jiménez','Silva','España','Gran Canaria',21);
INSERT INTO JUGADORES VALUES (66,6,'Alexander','Isak',null,'Suecia',null,19);

--Introducción de datos tabla ARBITROS

INSERT INTO ARBITROS VALUES (1,'Javier','ALBEROLA','ROJAS',11111111,19);
INSERT INTO ARBITROS VALUES (2,'Adrián','CUADRA','VEGA',11111112,19);
INSERT INTO ARBITROS VALUES (3,'Guillermo','CUADRA','FERN�?NDEZ',11111113,19);
INSERT INTO ARBITROS VALUES (4,'Ricardo','DE BURGOS','BENGOETXEA',11111114,19);
INSERT INTO ARBITROS VALUES (5,'Carlos','DEL CERRO','GRANDE',11111115,19);
INSERT INTO ARBITROS VALUES (6,'Isidro','D�?AZ DE MERA','ESCUDEROS',11111116,19);
INSERT INTO ARBITROS VALUES (7,'Jorge','FIGUEROA','V�?ZQUEZ',11111117,19);
INSERT INTO ARBITROS VALUES (8,'Jesús','GIL','MANZANO',11111118,19);
INSERT INTO ARBITROS VALUES (9,'Pablo','GONZ�?LEZ','FUERTES',11111119,19);
INSERT INTO ARBITROS VALUES (10,'Alejandro','HERN�?NDEZ','HERN�?NDEZ',11111121,19);
INSERT INTO ARBITROS VALUES (11,'Santiago','JAIME','LATRE',11111122,19);
INSERT INTO ARBITROS VALUES (12,'Juan','MART�?NEZ','MUNUERA',11111123,19);
INSERT INTO ARBITROS VALUES (13,'Antonio Miguel','MATEU','LAHOZ',11111124,19);
INSERT INTO ARBITROS VALUES (14,'Mario','MELERO','LÓPEZ',11111125,19);
INSERT INTO ARBITROS VALUES (15,'José Luis','MUNUERA','MONTERO',11111126,19);
INSERT INTO ARBITROS VALUES (16,'Alejandro','MUÑIZ','RUIZ',11111127,19);
INSERT INTO ARBITROS VALUES (17,'Miguel �?ngel','ORTIZ','ARIAS',11111128,19);
INSERT INTO ARBITROS VALUES (18,'Valentín','PIZARRO','GÓMEZ',11111129,19);
INSERT INTO ARBITROS VALUES (19,'José María','S�?NCHEZ','MART�?NEZ',11111131,19);
INSERT INTO ARBITROS VALUES (20,'César','SOTO','GRADO',11111132,19);

--Introducción de datos tabla PARTIDOS

INSERT INTO PARTIDOS VALUES (5,16,4,'Benito Villamarín',2,0,1,0,28,13,0);
INSERT INTO PARTIDOS VALUES (2,14,8,'Coliseum',0,0,3,0,17,10,0);
INSERT INTO PARTIDOS VALUES (17,12,15,'Son Moix',2,1,1,0,21,8,0);
INSERT INTO PARTIDOS VALUES (3,4,19,'Wanda Metropolitano',1,1,7,0,32,9,0);
INSERT INTO PARTIDOS VALUES (19,20,3,'Ciudad de Valencia',3,1,13,1,29,7,0);

--Introducción de datos tabla PREMIOS

INSERT INTO PREMIOS VALUES (1,'1 Campions',900000);
INSERT INTO PREMIOS VALUES (2,'2 Campions',800000);
INSERT INTO PREMIOS VALUES (3,'3 Campions',700000);
INSERT INTO PREMIOS VALUES (4,'4 Campions',600000);
INSERT INTO PREMIOS VALUES (5,'1 Europa',500000);
INSERT INTO PREMIOS VALUES (6,'3 Europa',400000);

COMMIT;

--2 Procimientos
--Procedimiento para actualizar los datos de las tabla equipo y arbitro al introducir los datos de un partido
CREATE OR REPLACE PROCEDURE ACTUALIZAR_GOLES(
COD_LOCAL NUMBER,
COD_VISITANTE NUMBER,
COD_ARBI NUMBER,
GOLES_LOCALES NUMBER,
GOLES_VISITANTES NUMBER
)
IS
BEGIN
    IF GOLES_LOCALES>GOLES_VISITANTES THEN
        UPDATE equipos SET PARTIDOS_JUGADOS=PARTIDOS_JUGADOS+1, VICTORIAS=VICTORIAS+1, GOLES_FAVOR=GOLES_FAVOR+GOLES_LOCALES, GOLES_CONTRA=GOLES_CONTRA+GOLES_VISITANTES, DIFERENCIA_GOLES=GOLES_FAVOR-GOLES_CONTRA, PUNTOS=PUNTOS+3 WHERE COD_EQUIPO=COD_LOCAL;
        UPDATE equipos SET PARTIDOS_JUGADOS=PARTIDOS_JUGADOS+1, DERROTAS=DERROTAS+1, GOLES_FAVOR=GOLES_FAVOR+GOLES_VISITANTES, GOLES_CONTRA=GOLES_CONTRA+GOLES_LOCALES, DIFERENCIA_GOLES=GOLES_FAVOR-GOLES_CONTRA WHERE COD_EQUIPO=COD_VISITANTE;
    ELSIF GOLES_LOCALES<GOLES_VISITANTES THEN
        UPDATE equipos SET PARTIDOS_JUGADOS=PARTIDOS_JUGADOS+1, VICTORIAS=VICTORIAS+1, GOLES_FAVOR=GOLES_FAVOR+GOLES_VISITANTES, GOLES_CONTRA=GOLES_CONTRA+GOLES_LOCALES, DIFERENCIA_GOLES=GOLES_FAVOR-GOLES_CONTRA, PUNTOS=PUNTOS+3 WHERE COD_EQUIPO=COD_VISITANTE;
        UPDATE equipos SET PARTIDOS_JUGADOS=PARTIDOS_JUGADOS+1, DERROTAS=DERROTAS+1, GOLES_FAVOR=GOLES_FAVOR+GOLES_LOCALES, GOLES_CONTRA=GOLES_CONTRA+GOLES_VISITANTES, DIFERENCIA_GOLES=GOLES_FAVOR-GOLES_CONTRA WHERE COD_EQUIPO=COD_LOCAL;
    ELSE
        UPDATE equipos SET PARTIDOS_JUGADOS=PARTIDOS_JUGADOS+1, EMPATES=EMPATES+1, GOLES_FAVOR=GOLES_FAVOR+GOLES_LOCALES, GOLES_CONTRA=GOLES_CONTRA+GOLES_VISITANTES, DIFERENCIA_GOLES=GOLES_FAVOR-GOLES_CONTRA, PUNTOS=PUNTOS+1 WHERE COD_EQUIPO=COD_LOCAL; 
        UPDATE equipos SET PARTIDOS_JUGADOS=PARTIDOS_JUGADOS+1, EMPATES=EMPATES+1, GOLES_FAVOR=GOLES_FAVOR+GOLES_VISITANTES, GOLES_CONTRA=GOLES_CONTRA+GOLES_LOCALES, DIFERENCIA_GOLES=GOLES_FAVOR-GOLES_CONTRA, PUNTOS=PUNTOS+2 WHERE COD_EQUIPO=COD_LOCAL;
    END IF;
    UPDATE arbitros SET patidos_dirigidos=patidos_dirigidos+1 WHERE cod_arbitro=COD_ARBI;
exception
    when value_error then
            DBMS_OUTPUT.PUT_LINE('Fomato de Datos incorrectos');
END;
/


--Procedimiento para poder introducir los datos de un partido sin usar el codigo del equipo y el codigo de arbitro
CREATE OR REPLACE PROCEDURE INTRODUCCION_PARTIDO( 
    NOMBRE_EQUIPO_LOCAL VARCHAR2,
    NOMBRE_EQUIPO_VISITANTE VARCHAR2,
    NOMBRE_ARBITRO VARCHAR2,
    ESTADIO VARCHAR2,
    GOLES_LOCALES NUMBER,
    GOLES_VISITANTES NUMBER,
    AMARILLAS NUMBER,
    ROJAS NUMBER,
    FATAS NUMBER,
    SAQUES_ESQUINA NUMBER,
    PENALTIS NUMBER
)IS  
    COD_LOCAL EQUIPOS.COD_EQUIPO%TYPE;
    COD_VISITANTE EQUIPOS.COD_EQUIPO%TYPE;
    COD_ARBI ARBITROS.COD_ARBITRO%TYPE;
BEGIN 
    SELECT COD_EQUIPO INTO COD_LOCAL FROM EQUIPOS WHERE NOMBRE_EQUIPO LIKE NOMBRE_EQUIPO_LOCAL;
    SELECT COD_EQUIPO INTO COD_VISITANTE FROM EQUIPOS WHERE NOMBRE_EQUIPO LIKE NOMBRE_EQUIPO_VISITANTE;
    SELECT COD_ARBITRO INTO COD_ARBI FROM ARBITROS A WHERE A.NOMBRE LIKE NOMBRE_ARBITRO;
    INSERT INTO PARTIDOS VALUES (COD_LOCAL,COD_VISITANTE,COD_ARBI,ESTADIO,GOLES_LOCALES,GOLES_VISITANTES,AMARILLAS,ROJAS,FATAS,SAQUES_ESQUINA,PENALTIS);
    ACTUALIZAR_GOLES(COD_LOCAL,COD_VISITANTE,COD_ARBI,GOLES_LOCALES,GOLES_VISITANTES);
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Fomato de Datos incorrectos');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurri� el error ' || SQLCODE ||'mensaje: ' || SQLERRM);
 
END;
/


--2 Funciones
--Esta primera funcion va a devolver la media de goles de todos los equipos
CREATE OR REPLACE FUNCTION PROMEDIO_GOLES(COD NUMBER)
RETURN NUMBER 
IS
    R1 NUMBER;
    RESULTADO NUMBER;
BEGIN
    SELECT goles_favor/partidos_jugados INTO RESULTADO FROM EQUIPOS WHERE cod_equipo=COD;
    SELECT goles_contra/partidos_jugados INTO R1 FROM EQUIPOS WHERE cod_equipo=COD;
    RETURN RESULTADO-R1;
exception
    when zero_divide then
        return 0;
    when value_error then
        DBMS_OUTPUT.PUT_LINE('Fomato de Datos incorrectos');
END;
/

--Esta funcion va a devolver todas las amonestaciones que ha recivido un equipo
CREATE OR REPLACE FUNCTION AMONESTACIONES(NOMBRE VARCHAR2)
RETURN NUMBER
IS
TYPE amo is record(
    cod_equipo number,
    amonestaciones number
);
amones amo;
BEGIN
    select cod_equipo, sum(faltas)+sum(TARJETAS_AMARILLAS)+sum(TARJETAS_ROJAS) as amonestaciones into amones from equipos, partidos where (cod_equipo = COD_EQUIPO_LOCAL or cod_equipo = COD_EQUIPO_VISITANTE) and nombre_equipo=Nombre group by cod_equipo;
    return amones.amonestaciones;
exception
    when value_error then
        DBMS_OUTPUT.PUT_LINE('Fomato de Datos incorrectos');
END;
/


--Bloque anonimo Main
--Intoduces los datos de lo partidos y te muestra los datos actualizados de todos los equipos y arbitros.
DECLARE
    Cursor clasificacion is
        select * from equipos;
registro clasificacion%Rowtype;

    Cursor arbitraje is
        select * from arbitros;
registro2 arbitraje%Rowtype;
    
promedio number;
amonestado number;
BEGIN
    INTRODUCCION_PARTIDO('&NOMBRE_EQUIPO_LOCAL','&NOMBRE_EQUIPO_VISITANTE','&NOMBRE_ARBITRO','&ESTADIO','&GOLES_LOCALES','&GOLES_VISITANTES','&AMARILLAS','&ROJAS','&FATAS','&SAQUES_ESQUINA','&PENALTIS');
    open clasificacion;
    loop
        fetch clasificacion into registro;
        exit when clasificacion%notfound;
        DBMS_OUTPUT.PUT_LINE('Nombre equipo: ' || registro.nombre_equipo);
        DBMS_OUTPUT.PUT_LINE('Partidos Jugados: ' || registro.PARTIDOS_JUGADOS);
        DBMS_OUTPUT.PUT_LINE('Victorias: ' || registro.VICTORIAS);
        DBMS_OUTPUT.PUT_LINE('Empates: ' || registro.EMPATES);
        DBMS_OUTPUT.PUT_LINE('Derrotas: ' || registro.DERROTAS);
        DBMS_OUTPUT.PUT_LINE('Puntos: ' || registro.PUNTOS);
        Select to_char(PROMEDIO_GOLES(registro.cod_equipo),'9D99' )into promedio from dual;
        DBMS_OUTPUT.PUT_LINE('Promedio de goles por partido recibidos/marcados ' || promedio);
        Select AMONESTACIONES(registro.nombre_equipo) into amonestado from dual;
        dbms_output.PUT_LINE('El numero de amonestaciones en los partidos de este equipo son : ' || amonestado);
        dbms_output.PUT_LINE('**********************************************');
    end loop;
    close clasificacion;
    DBMS_OUTPUT.PUT_LINE('Arbitros de LaLiga');
    dbms_output.PUT_LINE('**********************************************');
    open arbitraje;
    loop
        fetch arbitraje into registro2;
        exit when arbitraje%notfound;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || registro2.nombre || ' ' || registro2.APELLIDO1 || ' ' || registro2.APELLIDO2);
        DBMS_OUTPUT.PUT_LINE('DNI: ' || registro2.DNI);
        DBMS_OUTPUT.PUT_LINE('PATIDOS DIRIGIDOS: ' || registro2.PATIDOS_DIRIGIDOS);
        dbms_output.PUT_LINE('**********************************************');
    end loop;    
    close arbitraje;
END;
/
