CREATE DATABASE BD_STORED_PROCEDURES;

USE BD_STORED_PROCEDURES;

CREATE TABLE Clientes
( Cod_Cliente NUMERIC(05) PRIMARY KEY,
  Nome_Cliente VARCHAR(30),
  Endereco VARCHAR(25),
  Cidade VARCHAR(20),
  Cep VARCHAR(10),
  UF VARCHAR(2),
  CPF_CGC VARCHAR(15),
  IE VARCHAR(15)
  );


  CREATE TABLE Produto
  ( Cod_produto NUMERIC(3) PRIMARY KEY,
    Unidade VARCHAR(2),
	Vr_unitario NUMERIC(6,2)
  );


  CREATE TABLE Vendedor
  ( Cod_vendedor NUMERIC(3) PRIMARY KEY,
	Nome_vendedor VARCHAR(30),
	Faixa_comissao VARCHAR(2),
	Salario_fixo NUMERIC(7,2)
	);
	

	CREATE TABLE Pedido
	( Num_Pedido NUMERIC(3) PRIMARY KEY,
	  Dt_Compra DATETIME, 
	  Dt_Entrega DATETIME, 
	  Cod_Cliente  NUMERIC(05)  REFERENCES Clientes,
	  Cod_vendedor NUMERIC(3)  REFERENCES Vendedor
	);
	

	CREATE TABLE Item_Pedido
	( Num_Pedido NUMERIC(3)  REFERENCES Pedido,
	  Cod_Produto NUMERIC(3)  REFERENCES Produto,
	  Qtde VARCHAR(5),
	  PRIMARY KEY(Num_pedido, Cod_produto)
	);
	
	
	SELECT * FROM Item_Pedido 
	SELECT * FROM Pedido 
	SELECT * FROM Vendedor
	SELECT * FROM Produto
	SELECT * FROM Clientes
	
	
	
	
	INSERT INTO Clientes VALUES ( 01, 'Andre Rocha', 'Contorno F, 536','Aracaju','49095-840','SE','85301250531','');
	INSERT INTO Clientes VALUES ( 02, 'Luís Castro Alves', 'Trevo Ramos, 1592','Juiz de Fora','36033-540','MG', '32654897123','');
    INSERT INTO Clientes VALUES ( 03, 'Renan Barbosa ', 'Estrada  Guedes, 1316','Itapecerica da Serra','06885-150','SP','96385214785','');
	INSERT INTO Clientes VALUES ( 04, 'Marina Barros Cardoso', 'Rua Simão Estrelado, 536','São Paulo','08062-120','SP','98765428469','');
	INSERT INTO Clientes VALUES ( 05, 'Gustavo Costa Almeida', 'Rua Gustavo, 1491','Presidente Prudente','19025-780','SP','32145698741','');
	
	
	INSERT INTO Vendedor VALUES(01,'Ryan Sousa', 20.00,800.00);
	INSERT INTO Vendedor VALUES(02,'Melissa Azevedo', 30.00,850.00);
	INSERT INTO Vendedor VALUES(03,'Isabela Almeida', 30.00,850.00);
	INSERT INTO Vendedor VALUES(04,'Vitór Cavalcanti ', 20.00,800.00);
	INSERT INTO Vendedor VALUES(05,'Anna Rocha', 20.00,800.00);
	INSERT INTO Vendedor VALUES(06, 'João da Silva', 30.00,850.00)
	
	
	INSERT INTO Produto VALUES (01,'KG', 10.50);
	INSERT INTO Produto VALUES (02,'KG', 5.80);
	INSERT INTO Produto VALUES (03,'LT', 3.00);
	INSERT INTO Produto VALUES (04,'LT', 0.50);
	INSERT INTO Produto VALUES (05,'UN', 0.50);
	INSERT INTO Produto VALUES (06,'LT',1.50);
	INSERT INTO Produto VALUES (07,'KG',7.00);
	
	INSERT INTO Pedido VALUES (01, '05-10-2016', '10-10-2016', 01, 01);
	INSERT INTO Pedido VALUES (02, '06-11-2016', '05-12-2016', 02, 02);
	INSERT INTO Pedido VALUES (03, '07-10-2016', '05-11-2016', 03, 03);
	INSERT INTO Pedido VALUES (04, '10-10-2016', '05-11-2016', 04, 04);
	INSERT INTO Pedido VALUES (05, '15-10-2016', '05-11-2016', 05, 05);
	
	
	INSERT INTO Item_Pedido VALUES (01,01,10);
	INSERT INTO Item_Pedido VALUES (02,02,20);
	INSERT INTO Item_Pedido VALUES (03,03,20);
	INSERT INTO Item_Pedido VALUES (04,04,25);
	INSERT INTO Item_Pedido VALUES (05,05,20);

	--1
	CREATE PROC EX1 @NumPedido NUMERIC(3), @CodProduto NUMERIC(3), @Qtd varchar(5) 
	AS 
	--VERIFICAR CAMPO PCO_UNIT
	
	SELECT Vr_Unitario, Produto.Cod_produto, Item_Pedido.Cod_Produto, Pedido.Num_Pedido, Qtde
	FROM Produto, Item_Pedido, Pedido
	WHERE Produto.Cod_produto = Item_Pedido.Cod_Produto 
	AND Pedido.Num_Pedido = Item_Pedido.Num_Pedido

	EXEC EX1 '01', '01','10'
	 
	--2
	CREATE PROC ATUALIZA_SAL @CODIGO INT AS
	SELECT * FROM Vendedor
	WHERE Faixa_comissao = 'B'

	UPDATE Vendedor SET
	Salario_fixo = 
	CASE @CODIGO 
	WHEN 2 THEN Salario_fixo * 1.2
	WHEN 3 THEN Salario_fixo * 1.3
	WHEN 4 THEN Salario_fixo * 1.4
	ELSE Salario_fixo
	END
	WHERE Faixa_comissao = 'B'
	SELECT * FROM Vendedor WHERE Faixa_comissao = 'B'

	EXEC ATUALIZA_SAL 2
	
	--3
	CREATE PROC LISTE_CLASS @CODL NUMERIC 
	AS 
	SELECT Cod_produto,  Vr_Unitario  WHERE Vr_unitario = CASE
	WHEN Vr_unitario <2 THEN 'BAIXO' 
	WHEN Vr_unitario BETWEEN 2  AND 10 THEN 'MODERADO' 
	WHEN Vr_unitario > 10 THEN 'CARO'
	END LISTE_CLASS 
	FROM Produto
	WHERE Cod_produto = @COD



	  --exercicio aula

  CREATE PROC AUMENTO_FUNC @NOME_D VARCHAR(20), @PERC INT AS 
  SELECT NmFunc, VrSalario,(VrSalario + (VrSalario * @PERC/100))
  FROM FUNCIONARIO, DEPTO
  WHERE FUNCIONARIO.CdDepto = DEPTO.CdDepto
  and NmDepto = @NOME_D;

  EXEC AUMENTO_FUNC 'TI', '10'
