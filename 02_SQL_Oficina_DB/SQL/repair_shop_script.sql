-- Creating a database for a Repair Shop
-- drop database repairshop;
create database repairshop;
use repairshop;

-- create table Clients
create table Clients (
		idClient int auto_increment primary key,
        CName varchar(255),
        phone_no char(11),
        email varchar(45),
        tax_ID char(11) not null,
        address varchar(255),
        constraint unique_Tax_ID_Clients unique(Tax_ID)
);
alter table Clients auto_increment=1;
desc Clients;

-- create table Vehicle
create table Vehicle (
		idVehicle int auto_increment primary key,
        idClientVehicle int,
        plate varchar(7) not null,
        model varchar(45),
        brand varchar(45),
        vyear year,
        vehicle_type ENUM('Motorcycle', 'Car', 'Bike'),
        constraint unique_vehicle_plate unique(plate),
        constraint fk_vehicle_idClient foreign key (idClientVehicle) references Clients(idClient)
);
alter table Vehicle auto_increment=1;
desc Vehicle;

-- create table Service Order
create table Service_Order (
		idServiceOrder int auto_increment primary key,
        idSOVehicle int,
        open_Date date,
        close_Date date,
        SOstatus ENUM('Open', 'In Progress', 'Completed', 'Cancelled') default 'Open',
        SOdescription varchar(255),
        constraint fk_vehicle_idVehicle foreign key (idSOVehicle) references Vehicle(idVehicle)
);
alter table Service_Order auto_increment=1;
desc Service_Order;

-- create table Services
create table Services (
		idServices int auto_increment primary key,
        service_Name ENUM('Oil changes', 'Brake inspections and repairs', 'Tire services', 'Battery', 'Annual Check Up', 'Bike Service', 'Urgent repair'),
        service_Price FLOAT
);
alter table Services auto_increment=1;
desc Services;

-- create table Services Executed or Items of Service Orders
create table services_executed (
		idSE_Order int,
        idSE_Services int,
        oQuantity int,
        oUnit_Price float,
        constraint fk_SE_Order_services foreign key (idSE_Order) references Service_Order(idServiceOrder),
        constraint fk_SE_services_services foreign key (idSE_Services) references Services(idServices)
);
desc services_executed;

-- create table stock of vehicle Parts
create table Parts (
		idPart int auto_increment primary key,
        part_Name varchar(45),
        part_Price float,
        part_Stock int
);
alter table Parts auto_increment=1;
desc Parts;

-- create table Parts solicited in Service Orders
create table order_Parts (
		idOP_Order int,
        idOP_Parts int,
        op_Quantity int,
        opUnit_Price float,
        constraint fk_OP_Order_Service_Order foreign key (idOP_Order) references Service_Order(idServiceOrder),
        constraint fk_OP_Parts_Parts foreign key (idOP_Parts) references Parts(idPart)
);
desc order_Parts;

-- create table Payments
create table payments (
		idPayment int auto_increment primary key,
        idPayOrder int,
        payment_Date date,
        amount float,
        method enum('Cash','Card','Pix'),
        constraint fk_PayOrder_Service_Order foreign key (idPayOrder) references Service_Order(idServiceOrder)
);
alter table payments auto_increment=1;
desc payments;

-- create table Employees
create table employees (
		idEmployee int auto_increment primary key,
        EName varchar(255),
        Erole enum('Mechanic - Car', 'Mechanic - Motorcycle', 'Mechanic - Bike', 'Manager', 'Attendant', 'Cashier', 'Cleaning staff'),
        salary float
);
alter table employees auto_increment=1;
desc employees;

-- create table Employees working on Service Order
create table order_employee (
		idOE_Order int,
        idOE_Employee int,
        constraint fk_OE_Order_Order foreign key (idOE_Order) references Service_order(idServiceOrder),
        constraint fk_OE_Employee_Employee foreign key (idOE_Employee) references employees(idEmployee) 
);
desc order_employee;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;

select * from referential_constraints where constraint_schema = 'repairshop';