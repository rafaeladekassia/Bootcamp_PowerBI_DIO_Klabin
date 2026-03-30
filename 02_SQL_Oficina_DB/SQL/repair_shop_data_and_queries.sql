-- Inserting data and writing search queries to analyze repairshop DB

use repairshop;
show tables;

insert into Clients (CName, phone_no, email, tax_ID, address) values
	   ('Joao Silva', '31987654321', 'joao.silva@email.com', '12345678901', 'Rua A, 100, Centro, Belo Horizonte'),
	   ('Maria Souza', '31991234567', 'maria.souza@email.com', '23456789012', 'Av. Brasil, 200, Savassi, Belo Horizonte'),
	   ('Carlos Oliveira', '31999887766', 'carlos.oliveira@email.com', '34567890123', 'Rua das Acacias, 50, Funcionarios, Belo Horizonte'),
	   ('Ana Pereira', '31995554433', 'ana.pereira@email.com', '45678901234', 'Rua do Ouro, 300, Serra, Belo Horizonte'),
	   ('Lucas Costa', '31992223344', 'lucas.costa@email.com', '56789012345', 'Av. Amazonas, 1500, Centro, Belo Horizonte'),
	   ('Fernanda Almeida', '31993334455', 'fernanda.almeida@email.com', '67890123456', 'Rua Bahia, 75, Lourdes, Belo Horizonte');

select * from Clients;

insert into Vehicle (idClientVehicle, plate, model, brand, vyear, vehicle_type) values
		(1,'LUX3C19', 'Onix', 'Chevrolet', 2020, 'Car'),
		(1,'DEF2B34', 'Rv-x', 'BMX', 2019, 'Bike'),
		(2,'GHI3C45', 'Corolla', 'Toyota', 2022, 'Car'),
		(3,'JKL4D56', 'XRE190', 'Honda', 2021, 'Motorcycle'),
		(4,'MNO5E67', 'Gol', 'Volkswagen', 2018, 'Car'),
		(5,'PQR6F78', 'Compass', 'Jeep', 2023, 'Car'),
		(6,'STU7G89', 'CG160', 'Honda', 2017, 'Motorcycle');

select * from Vehicle;

-- SO Status: 'Open', 'In Progress', 'Completed', 'Cancelled'
insert into Service_Order (idSOVehicle, open_Date, close_Date, SOstatus, SOdescription) values
		(1, '2026-03-01', '2026-03-01', 'Completed', 'Oil changes'),
		(2, '2026-03-02', NULL, 'In Progress', 'Bike Service'),
		(3, '2026-03-03', '2026-03-04', 'Completed', 'Annual Check Up'),
		(4, '2026-03-05', NULL, 'Open', 'Brake inspections and repairs'),
		(5, '2026-03-06', '2026-03-06', 'Completed', 'Battery'),
		(6, '2026-03-07', NULL, 'In Progress', 'Battery'),
		(7, '2026-03-08', NULL, 'Cancelled', 'The customer cancelled the service.');
        
select * from Service_Order;

-- Services: 'Oil changes', 'Brake inspections and repairs', 'Tire services', 'Battery', 'Annual Check Up', 'Bike Service', 'Urgent repair'
insert into Services (service_Name, service_Price) values 
		('Oil changes', 120.00),
		('Tire services', 80.00),
		('Urgent repair', 200.00),
		('Annual Check Up', 250.00),
		('Battery', 300.00),
		('Bike Service', 150.00),
		('Brake inspections and repairs', 200.00);

select * from Services;

insert into services_executed (idSE_Order, idSE_Services, oQuantity, oUnit_Price) values
		(1, 1, 1, 120.00), -- Oil changes
		(2, 4, 1, 150.00), -- Bike Service
		(3, 2, 1, 250.00),  -- Annual Check Up
		(3, 3, 1, 200.00),  -- Brake inspections and repairs
		(4, 7, 1, 300.00), -- Battery
		(5, 5, 1, 300.00), -- Battery
		(6, 6, 1, 150.00), -- Diagnóstico
		(7, 6, 1, 150.00); -- Cancelled

select * from services_executed;

insert into Parts (part_Name, part_Price, part_Stock) values
		('Oil 5W30', 40.00, 50),
		('Oil filter', 25.00, 40),
		('Brake', 120.00, 30),
		('Battery 60Ah', 300.00, 20),
		('15 inch tire', 450.00, 25),
		('Spark plugs', 60.00, 60),
		('Air filter', 35.00, 45);

select * from Parts;

insert into order_Parts (idOP_Order, idOP_Parts, op_Quantity, opUnit_Price) values
		(1, 1, 1, 40.00),
		(1, 2, 1, 25.00),
		(3, 5, 4, 450.00),
		(4, 3, 1, 120.00),
		(5, 4, 1, 300.00),
		(6, 6, 4, 60.00),
		(6, 7, 1, 35.00);

select * from order_Parts;

insert into employees (EName, Erole, salary) values
		('Roberto Alves', 'Mechanic - Car', 3500.00),
		('Marcos Lima', 'Mechanic - Bike', 3000.00),
		('Juliana Rocha', 'Manager', 5000.00),
		('Fernanda Costa', 'Attendant', 2200.00),
		('Paulo Mendes', 'Cashier', 2200.00),
		('Lucas Martins', 'Mechanic - Motorcycle', 3000.00),
		('Ana Souza', 'Cleaning staff', 1800.00);

select * from employees;

insert into order_employee (idOE_Order, idOE_Employee) values
		(1, 1), -- Roberto (Mechanic - Car)
		(1, 4), -- Fernanda (Attendant)
		(2, 2), -- Marcos (Mechanic - Bike)
		(2, 4), -- Fernanda 
		(3, 6), -- Lucas (Mechanic - Motorcycle)
		(3, 5), -- Paulo (Caschier)
		(4, 1), -- Roberto
		(5, 1), -- Roberto
		(5, 5), -- Paulo (Cashier)
		(6, 6), -- Lucas (Mechanic - Motorcycle)
		(6, 4), -- Fernanda
		(7, 3); -- Juliana (Manager dealing with cancelled order)
        
select * from order_employee;

-- PART 2: SEARCH QUERIES TO ANSWER BUSINESS QUESTIONS
-- Question 1: Which were the most complex orders (with more services)?
select s.service_Name, count(*) as total_services
from services_executed os
join Services s on os.idSE_Order = s.idServices
group by idSE_Order
having count(*) > 1;

-- Question 2: Which employees worked on more projects?


-- Question 3: Which was the most expensive Service Order?

-- Question 4: Which was the total amount of the services?
