-- inserting data and queries
use ecommerce;
show tables;

-- idClient, Fname, Minit, Lname, taxID, Address
insert into clients (Fname, Minit, Lname, taxID, Address) values 
			  ('Mariana','A','Silva',12345678901,'Rua Flores, 120, Centro, Bonita City'),
			  ('Carlos','B','Souza',23456789012,'Av. Paulista, 850, Bela Vista, Horizontes'),
			  ('Fernanda','C','Oliveira',34567890123,'Rua XV de Novembro, 45, Centro, Fortalezas'),
			  ('João','D','Pereira',45678901234,'Rua da Praia, 300, Cidade Baixa, Porto Alegria'),
			  ('Patrícia','E','Costa',56789012345,'Av. Atlântica, 1500, Copacabana, Rio Cores'),
			  ('Ricardo','F','Almeida',67890123456,'Rua Pernambuco, 220, Savassi, Belos Horizontes');

select * from clients;

-- Pname, classification_kids, category, rating, size
insert into product (Pname, classification_kids, category, rating, size) values
				('Smartphone X200', false, 'Electronics', 5, NULL),
				('Camiseta Básica', false, 'Fashion', 4, 'M'),
				('Shampoo Nutritivo', false, 'Health & Beauty', 4, '500ml'),
				('Conjunto de Panelas', false, 'Home & Garden', 5, NULL),
				('Carrinho de Brinquedo', true, 'Toys', 4, 'Pequeno'),
				('Chocolate ao Leite', true, 'Food', 5, '100g'),
				('Tênis Esportivo', false, 'Fashion', 3, '42');

select * from product;

-- idClientOrder, orderStatus, orderDescription, shippingValue, paymentCash
insert into orders (idClientOrder, orderStatus, orderDescription, shippingValue, paymentCash) values 
				(1, 'Processing', 'Bought through app', 15, 1),
				(2, 'Processing', NULL, 0, 0),
				(3, 'Cancelled', 'Bought through website', 12, 1),
				(4, default, NULL, 10, 0);

select * from orders;

-- idPOproduct, idPOorder int, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values 
				(1,5,2,null),
				(2,5,1,null),
                (3,6,1,null);

-- idProdInventory, inventLocation
insert into productInventory (idProdInventory, inventLocation) values
				(231,'Cidade Bonita'),
                (98,'Horizontes'),
                (1,'Fortalezas'),
                (99,'São Paulo'),
                (500,'Rio de Janeiro'),
                (392,'Brasília');

 insert into supplier(LegalName, CorpTaxID, contact) values 
				('Grupo Loja Famosa',123986889999380,03332190000),
                ('Super Loja & Co',195986852999381,03134491040),
                ('Melhor Store LTDA',058772852999183,02136779830),
                ('Grupo Mega Loja SA',058772852999183,02136779830);

select * from supplier;

insert into seller(LegalName, TradeName, SellerTaxID, STaxID, location, contact) values
				('Grupo Loja Famosa','Loja Famosa',123986889999380,null,'Rua Florida,150,Distrito Industrial,Bonita City','3332190000'),
                ('Super Loja & Co','Super Loja',195986852999381,null,'Avenida Longe, S.N., Distante, Cidade Ali','3332190000'),
				('Melhor Loja',null,null,12345678912,'Rua Enfeitada, 89, Centro, Cidade Joia','2136779830'),
                ('Grupo Mega Loja SA','Mega Loja',058772852999183,null,'Rua das Borboletas, 25, Jardins, Floresta','2136779830');

insert into productSeller(idPSeller, idProduct, prodQuantity) values
				(1,21,2),
				(2,22,4),
                (3,33,1);
                
select * from productSeller;

insert into inventoryLocation(idLproduct, idLinventory, location) values
				(1,2,'RJ'),
                (2,6,'GO');
                
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values  
				(1,1,398),
                (1,2,207),
                (2,3,132),
                (3,4,421),
                (3,5,15);

select count(*) from clients;
select * from clients c, orders o where c.idClient = idClientOrder;

select concat(Fname,'',Lname) as Client_Name, idOrder as Client_Order, orderStatus as Order_Status 
	from clients c, orders o where c.idClient = idClientOrder;

insert into orders (idClientOrder, orderStatus, orderDescription, shippingValue, paymentCash) values 
				(2, default, 'Bought through app', null, 1);

select count(*) from clients c, orders o 
			where c.idClient = idClientOrder;

select * from productOrder;
		
select * from orders;
-- Question: How many orders did each client place?
select c.idClient, concat(Fname,'',Lname) as Client_Name, count(*) as Number_of_Orders from clients c 
					inner join orders o on c.idClient = o.idClientOrder
					inner join productOrder p on p.idPOorder = o.idOrder
		group by idClient;

-- Question: What products did customers buy?
select * from clients c
				inner join orders o on c.idClient = o.idClientOrder
				inner join productOrder p on p.idPOorder = o.idOrder
		group by idClient;
