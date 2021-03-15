CREATE DATABASE BD_PEDIDOS;

USE BD_PEDIDOS

CREATE TABLE Clientes
( Cod_Cliente NUMERIC(05) PRIMARY KEY,
  Nome_Cliente VARCHAR(30) NOT NULL,
  Endereco VARCHAR(25) NOT NULL,
  Cidade VARCHAR(20) NOT NULL,
  Cep VARCHAR(10) NOT NULL,
  UF VARCHAR(2) NOT NULL);


  CREATE TABLE Produto
  ( Cod_produto NUMERIC(3) PRIMARY KEY,
    Descrição NUMERIC(20) NOT NULL,
	Unidade VARCHAR(2)NOT NULL ,
	Valor_unitario NUMERIC(6,2)
  );


  CREATE TABLE Vendedor
  ( Cod_vendedor NUMERIC(3) PRIMARY KEY,
	Nome_vendedor VARCHAR(30) NOT NULL,
	Faixa_comissao NUMERIC(4,2) NOT NULL,
	Salario_fixo NUMERIC(7,2)
	);
	

	CREATE TABLE Pedido
	( Num_pedido NUMERIC(3) PRIMARY KEY,
	  Prazo_entrega DATETIME, 
	  Cod_Cliente  NUMERIC(05) NOT NULL	 REFERENCES Clientes,
	  Cod_vendedor NUMERIC(3) NOT NULL REFERENCES Vendedor
	);
	

	CREATE TABLE Item_Pedido
	( Num_pedido NUMERIC(3)  REFERENCES Pedido,
	  Cod_produto NUMERIC(3)  REFERENCES Produto,
	  Quantidade NUMERIC(5),
	  PRIMARY KEY(Num_pedido, Cod_produto)
	);
	
	ALTER TABLE Produto ALTER COLUMN Descrição VARCHAR(20) NOT NULL;

	SELECT * FROM Item_Pedido 
	SELECT * FROM Pedido 
	SELECT * FROM Vendedor
	SELECT * FROM Produto
	SELECT * FROM Clientes
	
	
	
	
	INSERT INTO Clientes VALUES ( 01, 'Andre Rocha', 'Contorno F, 536','Aracaju','49095-840','SE');
	INSERT INTO Clientes VALUES ( 02, 'Luís Castro Alves', 'Trevo Ramos, 1592','Juiz de Fora','36033-540','MG');
    INSERT INTO Clientes VALUES ( 03, 'Renan Barbosa ', 'Estrada  Guedes, 1316','Itapecerica da Serra','06885-150','SP');
	INSERT INTO Clientes VALUES ( 04, 'Marina Barros Cardoso', 'Rua Simão Estrelado, 536','São Paulo','08062-120','SP');
	INSERT INTO Clientes VALUES ( 05, 'Gustavo Costa Almeida', 'Rua Gustavo, 1491','Presidente Prudente','19025-780','SP');
	
	
	INSERT INTO Vendedor VALUES(01,'Ryan Sousa', 20.00,800.00);
	INSERT INTO Vendedor VALUES(02,'Melissa Azevedo', 30.00,850.00);
	INSERT INTO Vendedor VALUES(03,'Isabela Almeida', 30.00,850.00);
	INSERT INTO Vendedor VALUES(04,'Vitór Cavalcanti ', 20.00,800.00);
	INSERT INTO Vendedor VALUES(05,'Anna Rocha', 20.00,800.00);
	INSERT INTO Vendedor VALUES(06, 'João da Silva', 30.00,850.00)
	
		-- Os valores 10,15,20,10,30 = PÇ
	INSERT INTO Produto VALUES (01, 'Lápis', '10', 0.50);
	INSERT INTO Produto VALUES (02, 'Caneta', '15', 0.80);
	INSERT INTO Produto VALUES (03, 'Tesoura', '20', 2.00);
	INSERT INTO Produto VALUES (04, 'Apantador', '10', 0.50);
	INSERT INTO Produto VALUES (05, 'Borracha', '30', 0.50);
	INSERT INTO Produto VALUES (06,'Tinta de Cartuchos','LT',10.00);
	INSERT INTO Produto VALUES (07,'Café','KG',9.00);
	
	INSERT INTO Pedido VALUES (01, '05-10-2016', 01, 01);
	INSERT INTO Pedido VALUES (02, '06-11-2016', 02, 02);
	INSERT INTO Pedido VALUES (03, '07-10-2016', 03, 03);
	INSERT INTO Pedido VALUES (04, '10-10-2016', 04, 04);
	INSERT INTO Pedido VALUES (05, '15-10-2016', 05, 05);
	
	
	INSERT INTO Item_Pedido VALUES (01,01,10);
	INSERT INTO Item_Pedido VALUES (02,02,20);
	INSERT INTO Item_Pedido VALUES (03,03,20);
	INSERT INTO Item_Pedido VALUES (04,04,25);
	INSERT INTO Item_Pedido VALUES (05,05,20);
	
	
	  /*ROP TABLE Clientes
	  DROP TABLE Produto
	  DROP TABLE Vendedor
	  DROP TABLE Pedido
	  DROP TABLE Item_Pedido*/
	
	ALTER TABLE Clientes ALTER COLUMN Endereco VARCHAR(30) NOT NULL;

	UPDATE Produto SET Unidade = 'PÇ'; 
	ALTER TABLE Item_Pedido ADD Pco_Unit NUMERIC(4,2);

	UPDATE Clientes SET Cep = '18035-400'  WHERE Cidade = 'Sorocaba';
	
	UPDATE Pedido SET Prazo_entrega = GETDATE()  + 10  WHERE Cod_Cliente = 20;

	UPDATE Produto SET Valor_unitario  = Valor_unitario * 1.1 WHERE Unidade = 'KG';

	DELETE FROM Produto WHERE Unidade = 'CX' AND Valor_unitario >= 50; 



	SELECT  Num_pedido, Prazo_entrega FROM Pedido
	SELECT Descrição, Valor_unitario FROM Produto
	SELECT Nome_Cliente, Endereco from Clientes
	SELECT Nome_vendedor FROM Vendedor
	SELECT * FROM Clientes
	SELECT * FROM Produto
	SELECT * FROM Vendedor
	SELECT Nome_vendedor AS Nome FROM Vendedor
	SELECT Valor_unitario * 0.1 + Valor_unitario FROM Produto
	SELECT Salario_fixo * 0.05 + Salario_fixo FROM Vendedor
	SELECT Nome_Cliente FROM Clientes WHERE Cidade = 'Sorocaba'
	SELECT Salario_fixo FROM Vendedor WHERE Salario_fixo <400.00
	SELECT Cod_produto, Descrição FROM Produto WHERE Unidade = 'KG'
	SELECT Prazo_entrega FROM Pedido WHERE Prazo_entrega > '01-05-1998' AND Prazo_entrega < '01-06-1998'
	SELECT Num_pedido, Prazo_entrega FROM Pedido WHERE Prazo_entrega >= 01-01-2004 AND Prazo_entrega < 31-12-2004 
	SELECT Valor_unitario FROM Produto WHERE Valor_unitario >=100.00 AND Valor_unitario <= 200.00
	SELECT Valor_unitario FROM Item_Pedido, Produto WHERE Quantidade >=100 and Quantidade <= 1500
	SELECT Nome_vendedor FROM Vendedor WHERE Nome_vendedor LIKE 'João%'
	--select Nome_Cliente FROM Clientes WHERE 
	SELECT Nome_Cliente FROM Clientes WHERE Endereco = NULL
	SELECT Cidade FROM Clientes  ORDER BY Cidade
	SELECT * FROM Clientes ORDER BY Nome_Cliente
	SELECT * FROM Clientes ORDER BY Cidade DESC
	SELECT * FROM Clientes ORDER BY Cidade, Nome_Cliente 
	SELECT Cod_produto,Descrição FROM Produto WHERE Unidade = 'KG' ORDER BY Descrição

	--Consultas
	SELECT MAX(Quantidade) FROM Item_Pedido
	SELECT MIN(Valor_unitario) FROM Produto
	SELECT SUM(Salario_fixo) FROM Vendedor
	SELECT COUNT(Unidade ) FROM Produto WHERE Unidade = 'LT'
	SELECT Cidade,COUNT(Cod_Cliente) FROM Clientes GROUP BY Cidade
	SELECT Cod_vendedor, COUNT(Cod_vendedor)  FROM Pedido group by Cod_vendedor 
	SELECT MAX(Valor_unitario),MIN(Valor_unitario) FROM Produto 
	

	--lista 3
	
	

		SELECT Nome_vendedor, Nome_Cliente from Vendedor V, Clientes C, Pedido P
		WHERE V.Cod_vendedor = P.Cod_vendedor AND P.Cod_Cliente = 5;

		SELECT  Nome_vendedor, Nome_Cliente from Vendedor INNER JOIN Pedido on
		 Vendedor.Cod_vendedor = Pedido.Cod_vendedor INNER JOIN Clientes on Pedido.Cod_Cliente = Clientes.Cod_Cliente --WHERE Num_pedido = 1;

		--2.	Listar  o número do pedido, prazo de entrega, a quantidade e a descrição do produto com código 100.

		SELECT Quantidade, Descrição, Prazo_entrega FROM Item_Pedido I, Pedido P, Produto Pr WHERE 
		I.Cod_produto = Pr.Cod_produto and P.Num_pedido = I.Num_pedido

		 SELECT Num_pedido, Quantidade, Descrição FROM Item_Pedido inner join Produto ON Item_Pedido.Cod_produto = 1;
	 
		--3.	Quais os vendedores (código e nome) fizeram pedidos para o cliente 'José da Silva'.
	 
		 SELECT Nome_vendedor from Pedido P, Vendedor V, Clientes C
		 where V.Cod_vendedor = P.Cod_vendedor AND C.Nome_Cliente = 'Andre Rocha' 

			 --1.	Listar o código e o nome dos vendedores que 
			 --efetuaram vendas para o cliente com código 10
			 SELECT PEDIDO.COD_VENDEDOR, NOME_VENDEDOR 
		FROM VENDEDOR, PEDIDO, ITEM_PEDIDO, PRODUTO
		WHERE VENDEDOR.COD_VENDEDOR = PEDIDO.COD_VENDEDOR
		AND PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
		AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
		AND PEDIDO.COD_CLIENTE = 10;

		--2.	Listar o número do pedido, prazo de entrega, a quantidade e a descrição do produto com código 100.
		SELECT Num_pedido, PRAZO_ENTREGA, QUANTIDADE, Descrição
		FROM Pedido, Item_Pedido, Produto
		WHERE PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
		AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
		AND Cod_produto = 10;

		--3.	Quais os vendedores (código e nome) fizeram pedidos para o cliente 'José da Silva'.
		SELECT PEDIDO.COD_VENDEDOR, NOME_VENDEDOR 
		FROM VENDEDOR, PEDIDO, ITEM_PEDIDO, PRODUTO, Clientes
		WHERE VENDEDOR.COD_VENDEDOR = PEDIDO.COD_VENDEDOR
		AND PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
		AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
		AND PEDIDO.COD_CLIENTE = CLIENTEs.COD_CLIENTE
		AND NOME_CLIENTE = 'JOSE DA SILVA';

		--4.	Listar o número do pedido, o código do produto, a descrição do produto, o código do vendedor, o nome do vendedor , o nome do cliente, para todos os clientes que moram em Sorocaba.
		SELECT NUM_PEDIDO, COD_PRODUTO, DESCRICAO, PEDIDO.COD_VENDEDOR, NOME_VENDEDOR, NOME_CLIENTE
		FROM VENDEDOR, PEDIDO, ITEM_PEDIDO, PRODUTO, CLIENTE
		WHERE VENDEDOR.COD_VENDEDOR = PEDIDO.COD_VENDEDOR
		AND PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
		AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
		AND PEDIDO.COD_CLIENTE = CLIENTE.COD_CLIENTE
		AND CIDADE = ‘SOROCABA’;

		--5.	Listar o código do produto, a descrição, a quantidade pedida e o prazo de entrega para o pedido número 123.
		SELECT COD_PRODUTO, DESCRICAO, QUANTIDADE, PRAZO_ENTREGA
		FROM PEDIDO, ITEM_PEDIDO, PRODUTO
		WHERE PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
		AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
		AND PEDIDO.NUM_PEDIDO = 123;

		--6.	Quais os cliente ( nome e endereço) da cidade de Itu ou Sorocaba tiveram seus pedidos tirados com o vendedor  de código igual a 10.
		SELECT NOME_CLIENTE, ENDERECO
		FROM CLIENTE, PEDIDO
		WHERE CLIENTE.COD_CLIENTE = PEDIDO.COD_CLIENTE
		AND (CIDADE = ‘ITU’ OR CIDADE = ’SOROCABA’)
		AND PEDIDO.COD_VENDEDOR = 10;



	 --ex visaoes

	 CREATE VIEW EX1 AS SELECT Num_pedido, Cod_Cliente, Prazo_entrega from Pedido;

	 CREATE VIEW EX2 AS SELECT * FROM Produto WHERE Unidade = 'KG';

	 CREATE VIEW Ex3
		AS
		SELECT Cod_produto FROM PRODUTO WHERE VALOR_UNITARIO < AVG(VALOR_UNITARIO);

	CREATE VIEW EX4 AS SELECT Nome_vendedor, count(Num_pedido)
	FROM Vendedor, Pedido where Vendedor.Cod_vendedor = Pedido.Cod_vendedor
	
	-- subconsultas
	--1
	SELECT Nome_Cliente from Clientes WHERE Cidade = (SELECT Cidade FROM Clientes WHERE Nome_Cliente = 'ANDRE')

	SELECT Descrição from Produto WHERE Valor_unitario < 
	(SELECT AVG(Valor_unitario) FROM Produto)

	--3.Quais os clientes que só compraram com o vendedor com codigo 10 e com mais nenhum outro vendedor (fidelidade).
	SELECT Clientes.Nome_Cliente, Vendedor.Nome_vendedor from Clientes, Vendedor WHERE Vendedor.Cod_vendedor = '5'
	  AND Vendedor.Cod_vendedor not in (select Pedido.Cod_vendedor from Pedido)	
	
	SELECT DISTINCT  Clientes.Nome_cliente, Vendedor.Nome_vendedor
	FROM Clientes INNER JOIN Pedido ON 
	Pedido.Cod_cliente =Clientes.Cod_cliente  INNER JOIN Vendedor
	 ON	 Pedido.Cod_vendedor = Vendedor.Cod_vendedor
	WHERE Pedido.Cod_vendedor = '2' 
	AND Pedido.Cod_cliente NOT IN (SELECT Pedido.Cod_cliente
	FROM Pedido
	WHERE Pedido.Cod_vendedor != '2');


	--convert(p/ q tipo de dado, oque vai converter) ex convert(varchar(10), @dt)


		-- Subconsultas gabarito

	--1.	Listar todos os clientes que moram na mesma cidade que 'João da Silva'.
	SELECT Nome_Cliente
	FROM Clientes
	WHERE Cidade = 	(SELECT Cidade FROM Clientes
	WHERE Nome_Cliente = ('JOAO DA SILVA')

	--2.	Quais produtos tem valor unitário maior que a média.
	SELECT Cod_Produto
	FROM Produto
	WHERE Valor_unitario > (SELECT AVG(Valor_unitario) FROM Produto);

	--3.	Quais os clientes que só compraram com o vendedor com codigo 10 e com mais nenhum outro vendedor (fidelidade).
	SELECT DISTINCT  Cliente.Nome_cliente, Vendedor.Nome_vendedor
	FROM Cliente INNER JOIN Pedido ON 
	Pedido.Cod_cliente =Cliente.Cod_cliente  INNER JOIN Vendedor ON Pedido.Cod_vendedor = Vendedor.Cod_vendedor
	WHERE Pedido.Cod_vendedor = '2' 
	AND Pedido.Cod_cliente NOT IN (SELECT Pedido.Cod_cliente
	FROM Pedido
	WHERE Pedido.Cod_vendedor != '2');

	--4.	Quais vendedores não fizeram mais de 5 pedidos.
	SELECT Vendedor.Nome_vendedor
	FROM Pedido INNER JOIN Vendedor ON 
	Pedido.Cod_vendedor = Vendedor.Cod_vendedor
	WHERE Pedido.Cod_vendedor NOT IN 
	(SELECT  Pedido.Cod_vendedor
			FROM Pedido
			GROUP BY Pedido.Cod_vendedor
			HAVING COUNT(Pedido.Num_pedido) > '1');

	--5.	Quais os vendedores não fizeram nenhum pedido no mês de maio/2007
	SELECT Vendedor.Nome_vendedor 
	FROM Vendedor 
	WHERE Vendedor.Cod_vendedor NOT IN 
	(SELECT Pedido.Cod_vendedor
			FROM Pedido INNER JOIN Vendedor ON
	Pedido.Cod_vendedor = Vendedor.Cod_vendedor
	WHERE MONTH(Pedido.PrazoEntrega_pedido) = '3' and  YEAR(Pedido.PrazoEntrega_pedido) = '2013') ;

	--6.	Listar o nome do vendedor que mais fez pedidos.
	SELECT Vendedor.Nome_vendedor
	FROM Pedido INNER JOIN Vendedor ON 
	Pedido.Cod_vendedor = Vendedor.Cod_vendedor
	GROUP BY Vendedor.Nome_vendedor
	HAVING COUNT(Pedido.Num_pedido) >= ALL 
	(SELECT Count(Pedido.Num_pedido)
			FROM Pedido		  
			GROUP BY Pedido.Cod_vendedor);

	--7.	Listar o nome dos clientes e o número total de pedidos associados a cada cliente em ordem decrescente de vendas, isto é do cliente que mais tem pedidos para o que menos tem.
	select nome_cliente, COUNT (*) as qtde 
	from cliente c, pedido p
	where c.Cod_cliente = p.cod_cliente
	group by Nome_cliente
	having COUNT (*) in (select COUNT (*) 
									   from pedido 
									   group by cod_cliente)
	order by qtde desc

	--8.	Excluir todos os itens dos pedidos feitos pelo cliente de código =2;
	delete from item_pedido
	where num_pedido IN (select num pedido
	from pedido
	where cod_cliente = 2)

	--9.	Alterar o valor unitário de todos os produtos sem vendas no ano de 2007 para menos 20%.
	update produto
	set valor_unitario = valor_unitario*0.8
	where cod_produto NOT IN (select item_pedido.cod_produto
				from pedido, item_pedido, produto
				where pedido.num_pedido=item_pedido.num_pedido
	and item_pedido.cod_produto=produto.cod_produto
	and YEAR (prazo_entrega) = ‘2007’
