-- Creating a Database for an Ecommerce scenario 
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- create client table
create table clients (
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        taxID char(11) not null,
        BirthDate varchar(45) not null,
        Address varchar(255),
        constraint unique_taxID_client unique (taxID)
);
alter table clients auto_increment=1;

desc clients;

-- create product table
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(30) not null,
        classification_kids bool default false,
        category enum('Electronics', 'Fashion', 'Health & Beauty', 'Home & Garden', 'Toys', 'Food') not null,
        taxID char(11) not null,
        rating float default 0,
        size varchar(10),
        constraint unique_taxID_client unique (taxID)
);
alter table product auto_increment=1;

-- create order table
create table orders (
		idOrder int auto_increment primary key,
        idClientOrder int,
        orderStatus enum('Cancelled', 'Confirmed', 'Processing') default 'Processing',
        orderDescription varchar(255),
        shippingValue float default 10,
        paymentCash bool default false,
        constraint fk_order_client foreign key (idClientOrder)  references clients(idClient)
);
alter table orders auto_increment=1;

desc orders;

-- create table inventory
create table productInventory (
		idProdInventory int auto_increment primary key,
        inventLocation varchar(255),
        amount int default 0,
        piStatus enum('Available', 'Sold out') default 'Available'
);
alter table productInventory auto_increment=1;

-- create table supplier
create table supplier(
		idSupplier int auto_increment primary key,
        LegalName varchar(255) not null,
        CorpTaxID char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CorpTaxID)
);
alter table supplier auto_increment=1;

desc supplier;

-- create table seller
create table seller(
		idSeller int auto_increment primary key,
        LegalName varchar(255) not null,
        TradeName varchar(255),
        SellerTaxID char(15),
        STaxID char(11),
        location varchar(255),
        contact char(11) not null,
        constraint unique_SellerTaxID_seller unique (SellerTaxID),
        constraint unique_STaxID_seller unique (STaxID)
);
alter table seller auto_increment=1;

-- create table products - seller
create table productSeller(
		idPSeller int,
        idProductS int,
        prodQuantity int default 1,
        primary key (idPSeller, idProductS),
        constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
        constraint fk_product_product foreign key (idProductS) references product(idProduct)
);
desc productSeller;

-- create table product order
create table productOrder(
		idPOproduct int,
        idPOorder int,
		poQuantity int,
        poStatus int default 1,
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);
desc productOrder;

-- create table storage Location
create table inventoryLocation(
		idLproduct int,
        idLinventory int,
        location varchar(255) not null,
        primary key (idLproduct, idLinventory),
        constraint fk_inventory_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_inventory_location_inventory foreign key (idLinventory) references productInventory(idProdInventory)
);

-- create table productSupplier
create table productSupplier (
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';