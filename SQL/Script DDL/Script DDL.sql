CREATE TABLE ASOCIACION 
    ( 
     id_asociacion     NUMBER (3)  NOT NULL , 
     nombre_asociacion VARCHAR2 (60)  NOT NULL , 
     fecha_creacion    DATE  NOT NULL , 
     tipo_asociacion   VARCHAR2 (1)  NOT NULL 
    ) 
;

ALTER TABLE ASOCIACION 
    ADD CONSTRAINT ASOCIACION_FECHA_CK 
    CHECK (fecha_creacion >= DATE '1980-12-31')
;
ALTER TABLE ASOCIACION 
    ADD CONSTRAINT ASOCIACION_PK PRIMARY KEY ( id_asociacion ) ;

CREATE TABLE CLUB_FUTBOL 
    ( 
     id_club         NUMBER (4)  NOT NULL , 
     nombre_club     VARCHAR2 (50)  NOT NULL , 
     patrimonio      NUMBER (12)  NOT NULL , 
     ubicacion_calle VARCHAR2 (100)  NOT NULL , 
     tipo_club       VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE CLUB_FUTBOL 
    ADD CONSTRAINT CLUB_FUTBOL_PK PRIMARY KEY ( id_club ) ;

ALTER TABLE CLUB_FUTBOL 
    ADD CONSTRAINT CLUB_FUTBOL__UN UNIQUE ( nombre_club ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER (3)  NOT NULL , 
     nombre           VARCHAR2 (50)  NOT NULL , 
     REGION_id_region NUMBER (2)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE CONTRATO_JUGADOR 
    ( 
     fecha_inicio           DATE  NOT NULL , 
     fecha_fin              DATE , 
     JUGADOR_id_inscripcion NUMBER (9)  NOT NULL , 
     CLUB_FUTBOL_id_club    NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE CONTRATO_JUGADOR 
    ADD CONSTRAINT CONTRATO_JUGADOR_PK PRIMARY KEY ( fecha_inicio, JUGADOR_id_inscripcion, CLUB_FUTBOL_id_club ) ;

CREATE TABLE ESCUELA_FUTBOL 
    ( 
     id_escuela      NUMBER (4)  NOT NULL , 
     nombre          VARCHAR2 (50)  NOT NULL , 
     capacidad       NUMBER (5)  NOT NULL , 
     fecha_fundacion DATE  NOT NULL 
    ) 
;

ALTER TABLE ESCUELA_FUTBOL 
    ADD CONSTRAINT ESCUELA_FUTBOL_PK PRIMARY KEY ( id_escuela ) ;

CREATE TABLE IDIOMA 
    ( 
     id_idioma NUMBER (3)  NOT NULL , 
     nombre    VARCHAR2 (30)  NOT NULL 
    ) 
;

ALTER TABLE IDIOMA 
    ADD CONSTRAINT IDIOMA_PK PRIMARY KEY ( id_idioma ) ;

CREATE TABLE JUGADOR 
    ( 
     id_inscripcion            NUMBER (9)  NOT NULL , 
     puesto                    VARCHAR2 (30)  NOT NULL , 
     monto_total_premios       NUMBER (12)  NOT NULL , 
     anio_egreso               NUMBER (4) , 
     NACIONALIDAD_id_nacion    NUMBER (3)  NOT NULL , 
     ESCUELA_FUTBOL_id_escuela NUMBER (4) , 
     ASOCIACION_id_asociacion  NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_PK PRIMARY KEY ( id_inscripcion ) ;

CREATE TABLE JUGADOR_IDIOMA 
    ( 
     nivel_dominio          VARCHAR2 (20)  NOT NULL , 
     JUGADOR_id_inscripcion NUMBER (9)  NOT NULL , 
     IDIOMA_id_idioma       NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_PK PRIMARY KEY ( JUGADOR_id_inscripcion, IDIOMA_id_idioma ) ;

CREATE TABLE NACIONALIDAD 
    ( 
     id_nacion   NUMBER (3)  NOT NULL , 
     descripcion VARCHAR2 (30)  NOT NULL 
    ) 
;

ALTER TABLE NACIONALIDAD 
    ADD CONSTRAINT NACIONALIDAD_PK PRIMARY KEY ( id_nacion ) ;

CREATE TABLE PERSONAL_PLANTA 
    ( 
     id_inscripcion      NUMBER (9)  NOT NULL , 
     horas_trabajadas    NUMBER (4) , 
     valor_hora_extra    NUMBER (8) , 
     CLUB_FUTBOL_id_club NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_PK PRIMARY KEY ( id_inscripcion ) ;

CREATE TABLE REGION 
    ( 
     id_region NUMBER (2)  NOT NULL , 
     nombre    VARCHAR2 (60)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

CREATE TABLE TRABAJADOR 
    ( 
     id_inscripcion   NUMBER (9)  NOT NULL , 
     rut              NUMBER (8)  NOT NULL , 
     dv               VARCHAR2 (1)  NOT NULL , 
     nombres          VARCHAR2 (50)  NOT NULL , 
     apellidos        VARCHAR2 (50)  NOT NULL , 
     sueldo_base      NUMBER (10)  NOT NULL , 
     fecha_nacimiento DATE  NOT NULL , 
     genero           VARCHAR2 (1)  NOT NULL , 
     estado_civil     VARCHAR2 (20)  NOT NULL , 
     telefono_movil   VARCHAR2 (15)  NOT NULL , 
     email            VARCHAR2 (100)  NOT NULL , 
     direccion        VARCHAR2 (100)  NOT NULL , 
     COMUNA_id_comuna NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE TRABAJADOR 
    ADD CONSTRAINT TRABAJADOR_PK PRIMARY KEY ( id_inscripcion ) ;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE CONTRATO_JUGADOR 
    ADD CONSTRAINT CONTRATO_JUGADOR_CLUB_FK FOREIGN KEY 
    ( 
     CLUB_FUTBOL_id_club
    ) 
    REFERENCES CLUB_FUTBOL 
    ( 
     id_club
    ) 
;

ALTER TABLE CONTRATO_JUGADOR 
    ADD CONSTRAINT CONTRATO_JUGADOR_JUGADOR_FK FOREIGN KEY 
    ( 
     JUGADOR_id_inscripcion
    ) 
    REFERENCES JUGADOR 
    ( 
     id_inscripcion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_ASOCIACION_FK FOREIGN KEY 
    ( 
     ASOCIACION_id_asociacion
    ) 
    REFERENCES ASOCIACION 
    ( 
     id_asociacion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_ESCUELA_FUTBOL_FK FOREIGN KEY 
    ( 
     ESCUELA_FUTBOL_id_escuela
    ) 
    REFERENCES ESCUELA_FUTBOL 
    ( 
     id_escuela
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_IDIOMA_FK FOREIGN KEY 
    ( 
     IDIOMA_id_idioma
    ) 
    REFERENCES IDIOMA 
    ( 
     id_idioma
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_JUGADOR_FK FOREIGN KEY 
    ( 
     JUGADOR_id_inscripcion
    ) 
    REFERENCES JUGADOR 
    ( 
     id_inscripcion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_NACIONALIDAD_FK FOREIGN KEY 
    ( 
     NACIONALIDAD_id_nacion
    ) 
    REFERENCES NACIONALIDAD 
    ( 
     id_nacion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_TRABAJADOR_FK FOREIGN KEY 
    ( 
     id_inscripcion
    ) 
    REFERENCES TRABAJADOR 
    ( 
     id_inscripcion
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_CLUB_FUTBOL_FK FOREIGN KEY 
    ( 
     CLUB_FUTBOL_id_club
    ) 
    REFERENCES CLUB_FUTBOL 
    ( 
     id_club
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_TRABAJADOR_FK FOREIGN KEY 
    ( 
     id_inscripcion
    ) 
    REFERENCES TRABAJADOR 
    ( 
     id_inscripcion
    ) 
;

ALTER TABLE TRABAJADOR 
    ADD CONSTRAINT TRABAJADOR_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

CREATE SEQUENCE NACIONALIDAD_id_nacion_SEQ 
START WITH 210 
    INCREMENT BY 2 
    NOCACHE 
    ORDER ;