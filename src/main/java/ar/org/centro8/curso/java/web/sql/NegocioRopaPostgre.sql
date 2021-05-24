/*
	Server:	motty.db.elephantsql.com (motty-01)
	
	Port: 5432
	
	Region:	google-compute-engine::southamerica-east1
	
	Created at:	2021-04-19 18:14 UTC+00:00
	
	User & Default database:	ebqvseru
	
	Password: 	O1d_3PdcBcQI5QcTkGW9ePfJOTR9dNvy
	
	URL:	postgres://ebqvseru:O1d_3PdcBcQI5QcTkGW9ePfJOTR9dNvy@motty.db.elephantsql.com:5432/ebqvseru
*/

-- Borrar Tablas
drop table if exists detalles;
drop table if exists articulos;
drop table if exists facturas;
drop table if exists clientes;

-- Enumerados
drop type if exists tipoDocumento;
create type tipoDocumento as enum ('DNI','LIBRETA_CIVICA','LIBRETA_ENROLAMIENTO','PASS');
drop type if exists letra;
create type letra as enum ('A','B','C');
drop type if exists medioDePago;
create type medioDePago as enum('EFECTIVO','DEBITO','TARJETA');
drop type if exists tipo;
create type tipo as enum('CALZADO','ROPA');
drop type if exists temporada;
create type temporada as enum('VERANO','OTOÑO','INVIERNO');

create table clientes(
	id serial primary key,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	edad int,
	direccion varchar(50),
	email varchar(30),
	telefono varchar(25),
	tipoDocumento tipoDocumento,
	numeroDocumento char(8)
);

alter table clientes 
	add constraint CK_clientes_edad
    check (edad>=18 and edad<=120); 

alter table clientes
	add constraint U_clientes_TipoNumero
	unique(tipoDocumento,numeroDocumento);

create table facturas(
	id serial primary key,
	letra letra,
	numero int,
    fecha date,
	medioDePago medioDePago,
 	idCliente int not null
);

-- creamos la restriccion FK facturas idCliente
alter table facturas
	add constraint FK_facturas_idCliente
    foreign key(idCliente)
    references clientes(id);

alter table facturas
	add constraint CK_facturas_numero
    check (numero>0);

alter table facturas 
	add constraint U_facturas_LetraNumero
    unique(letra,numero);
   
create table articulos(
	id serial primary key,
	descripcion varchar(25) not null,
	tipo tipo,
	color varchar(20),
	talle_num varchar(20),
	stock int,
    stockMin int,
    stockMax int,
    costo float8,
    precio float8,
	temporada temporada
);

alter table articulos
	add constraint CK_articulos_stock
    check (stock>=0);

alter table articulos
	add constraint CK_articulos_stockMin
    check (stockMin>0);
    
alter table articulos
	add constraint CK_articulos_stockMax
    check (stockMax>=stockMin);
    
alter table articulos
	add constraint CK_articulos_costo
    check (costo>=0);

alter table articulos
	add constraint CK_articulos_precio
    check (precio>=costo);
   
create table detalles(
	id serial primary key,
	idArticulo int not null,
	idFactura int not null,
	precio float8,
	cantidad int
);

alter table detalles
	add constraint U_detallesIdArtIdFact
    unique(idArticulo,idFactura);

alter table detalles
	add constraint U_detalles_precio
    check(precio>=0);   
   
alter table detalles
	add constraint U_detalles_cantidad
    check(cantidad>=0);
   
alter table detalles
	add constraint FK_detalles_Articulos
    foreign key(idArticulo)
   	references articulos(id);
   
alter table detalles
	add constraint FK_detalles_Facturas
    foreign key(idFactura)
   	references facturas(id);   
