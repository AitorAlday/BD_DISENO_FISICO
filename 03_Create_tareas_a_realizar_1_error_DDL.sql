-- MIGUEL OLMO HERNANDO

REM **** Borrado de las tablas


DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;
DROP TABLE articulos CASCADE CONSTRAINTS;
DROP TABLE fabricantes CASCADE CONSTRAINTS;
DROP TABLE tiendas CASCADE CONSTRAINTS;
DROP TABLE pedidos CASCADE CONSTRAINTS;
DROP TABLE ventas CASCADE CONSTRAINTS;




REM **** Creación de las tablas

CREATE TABLE ventas(
  nif VARCHAR2(10), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  articulo VARCHAR2(20),  -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  cod_fabricante VARCHAR2(3), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  peso NUMBER(3) NOT NULL, -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  categoria VARCHAR2(10) NOT NULL,  -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  fecha_venta DATE DEFAULT SYSDATE, 
  unidades_vendidas NUMBER(4), 
CONSTRAINT ven_pk PRIMARY KEY(nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
CONSTRAINT ven_fab_fk FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(codigo),
CONSTRAINT ven_uve_ck CHECK (unidades_vendidas>0), -- FALTA LA CONSTRAINT 
CONSTRAINT ven_uve_ck CHECK (categoria IN('primero','segundo','tercero')), -- FALTA LA CONSTRAINT 
CONSTRAINT ven_art_fk FOREIGN KEY(articulo, cod_fabricante, peso, categoria) REFERENCES articulos(articulo, cod_fabricante, peso, categoria),
CONSTRAINT ven_tie_fk FOREIGN KEY(nif) REFERENCES tiendas(nif)
);

create table departments(
   department_id NUMBER(2),
   department_name VARCHAR2(30) NOT NULL, -- NO ES NECESARIO PONER CONSTRAINT NOT NULL LA CONSTRAINT SOBRA
   manager_id NUMBER(3),
   location_id NUMBER(4),
CONSTRAINT dept_id_pk PRIMARY KEY(department_id) -- DEPARTMENT_ID ESTABA MAL ESCRITO
);


create table employees( -- AQUI FALTABA UN PARENTESIS
   employee_id NUMBER(6),
   first_name VARCHAR2(25) NOT NULL ,
   last_name VARCHAR2(25),
   email VARCHAR2(25) UNIQUE, -- CONSTRAINT emp_email_uk SOBRA
   phone_number NUMBER(12),
   hire_date DATE  DEFAULT SYSDATE ,
   job_id VARCHAR2(10),
   salary NUMBER(8,2),
   comission_pct NUMBER(5,2),
   manager_id NUMBER(3),
   department_id NUMBER(2),
CONSTRAINT emp_id_pk PRIMARY KEY(employee_id),
CONSTRAINT emp_dept_fk FOREIGN KEY(department_id) REFERENCES departments(departmentes_id); -- AQUI ESTABA MAL ESCRITO FOREIGN KEY Y HAY QUE CERRAR CON ; LA CREATE            
      		      

CREATE TABLE fabricantes( -- CERRAR CON ; LA CREATE ANTERIOR
  cod_fabricante VARCHAR(3), -- NO ES NECESARIO PONER NOT NULL PORQUE YA LO ES AL SER LA PK
  nombre  VARCHAR2(15),
  pais VARCHAR2(15), 
CONSTRAINT fab_cod_fab_pk PRIMARY KEY(cod_fabricante),
CONSTRAINT fab_nombre_mayu CHECK (nombre = upper(nombre)), -- FALTA LA CONSTRAINT Y EL CHECK QUE TIENE QUE ESTAR DETRAS DEL NOMBRE DE LA CONSTRAINT
CONSTRAINT fab_pais_mayu CHECK (pais = upper(pais)) -- FALTA LA CONSTRAINT Y EL CHECK QUE TIENE QUE ESTAR DETRAS DEL NOMBRE DE LA CONSTRAINT
);


CREATE TABLE articulos (
  articulo VARCHAR2(20), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  cod_fabricante VARCHAR2(3), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  peso NUMBER(3), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  categoria VARCHAR2(10,5), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  precio_venta NUMBER(4),
  precio_costo NUMBER(4),
  existencias NUMBER(5),
CONSTRAINT art_pk PRIMARY KEY(articulo, cod_fabricante, peso, categoria),
CONSTRAINT art_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante), -- 
CONSTRAINT art_prev_ck CHECK (precio_venta>0), -- FALTA LA CONSTRAINT CON SU NOMBRE Y EL CHECK HAY QUE PONERLO DESPUES
CONSTRAINT art_prec_ck CHECK (precio_costo>0), -- FALTA LA CONSTRAINT CON SU NOMBRE Y EL CHECK HAY QUE PONERLO DESPUES
CONSTRAINT art_peso_ck CHECK (peso>0), -- FALTA LA CONSTRAINT CON SU NOMBRE Y EL CHECK HAY QUE PONERLO DESPUES
CONSTRAINT art_cat_ck CHECK categoria  IN('primero','segundo','tercero') -- FALTA LA CONSTRAINT CON SU NOMBRE Y EL CHECK HAY QUE PONERLO DESPUES 
));


CREATE TABLE pedidos (
  nif VARCHAR2(10), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  articulo VARCHAR2(20), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  cod_fabricante VARCHAR2(3), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  peso NUMBER(3), -- NO PUEDE SER NOT NULL PORQUE YA ES PARTE DE LA PK
  categoria VARCHAR2 (10),
  fecha_pedido DATE SYSDATE, -- DEFAULT???
  unidades_pedidas NUMBER(4),
CONSTRAINT ped_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
CONSTRAINT ped_fk FOREIGN KEY (cod_fabricante) REFERENCE fabricantes, -- NO SERIA NECESARIO VOLVER A PONER (cod_fabricante) AUNQUE TAMPOCO ESTARIA MAL
CONSTRAINT ped_unidades_ck CHECK (unidades_pedidas>0),
CONSTRAINT ped_cat_ck CHECK (categoria  IN(primero,segundo,tercero)), -- FALTA EL NOMBRE DE LA CHECK Y PONER ESTE DESPUES DEL NOMBRE 
CONSTRAINT ped_fk FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES articulos, -- NO SERIA NECESARIO VOLVER A PONER (articulo,peso,categoria AUNQUE TAMPOCO ESTARIA MAL
CONSTRAINT ped_fk FOREIGN KEY (nif) REFERENCES tiendas -- NO SERIA NECESARIO VOLVER A PONER (nif) AUNQUE TAMPOCO ESTARIA MAL
); 



CREATE TABLE tiendas (
  nif VARCHAR2(10), -- PRYMARY KEY ESTABA FALTAL,
  nombre VARCHAR2(20),
  direccion  VARCHAR2(20),
  poblacion  VARCHAR2(20),
  provincia  VARCHAR2(20),
  codpostal  VARCHAR2(5),
CONSTRAINT tie_pk PRIMARY KEY (nif), -- DECLARO AQUI LA CONSTRAINT PARA LA PK
CONSTRAINT tie_pro_ck CHECK (provincia = UPPER(provincia)) -- UPPERCASE EN ORACLE NO FUNCIONA, ES UPPER Y OJO ES UNA CHECK POR LO QUE FALTA EL NOMBRE DE ESTA Y LA PALABRA RESERVADA CHEK
);
