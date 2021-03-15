CREATE DATABASE BD_PEDIDOS;

USE BD_PEDIDOS

CREATE TABLE Clientes
( Cod_Cliente NUMERIC(05) PRIMARY KEY,
  Nome_Cliente VARCHAR(30) NOT NULL,
  Endereco VARCHAR(25) NOT NULL,
  Cidade VARCHAR(20) NOT NULL,
  Cep VARCHAR(10) NOT NULL,
  UF VARCHAR(2) NOT NULL);

  /*DROP TABLE Clientes
  DROP TABLE Produto
  DROP TABLE Vendedor
  DROP TABLE Pedido
  DROP TABLE Item_Pedido*/
	
  SELECT * FROM Clientes

  CREATE TABLE Produto
  ( Cod_produto NUMERIC(3) PRIMARY KEY,
    Descrição NUMERIC(20) NOT NULL,
	Unidade VARCHAR(2)NOT NULL ,
	Valor_unitario NUMERIC(6,2)
  );

  SELECT * FROM Produto

  CREATE TABLE Vendedor
  ( Cod_vendedor NUMERIC(3) PRIMARY KEY,
	Nome_vendedor VARCHAR(30) NOT NULL
	Faixa_comissao NUMERIC(4,2) NOT NULL,
	Salario_fixo NUMERIC(7,2)
	);
	SELECT * FROM Vendedor

	CREATE TABLE Pedido
	( Num_pedido NUMERIC(3) PRIMARY KEY,
	  Prazo_entrega DATETIME, 
	  Cod_Cliente  NUMERIC(05) NOT NULL	 REFERENCES Clientes,
	  Cod_vendedor NUMERIC(3) NOT NULL REFERENCES Vendedor
	);
	
	SELECT * FROM Pedido 

	CREATE TABLE Item_Pedido
	( Num_pedido NUMERIC(3)  REFERENCES Pedido,
	  Cod_produto NUMERIC(3)  REFERENCES Produto,
	  Quantidade NUMERIC(5),
	  PRIMARY KEY(Num_pedido, Cod_produto)
	);
	SELECT * FROM Item_Pedido 


	INSERT INTO Clientes VALUES ( 01, 'Andre Rocha', 'Contorno F, 536','Aracaju','49095-840','SE');
	INSERT INTO Clientes VALUES ( 02, 'Luís Castro Alves', 'Trevo Ramos, 1592','Juiz de Fora','36033-540','MG');
    INSERT INTO Clientes VALUES ( 03, 'Renan Barbosa ', 'Estrada  Guedes, 1316','Itapecerica da Serra','06885-150','SP');
	INSERT INTO Clientes VALUES ( 04, 'Marina Barros Cardoso', 'Rua Simão Estrelado, 536','São Paulo','08062-120','SP');
	INSERT INTO Clientes VALUES ( 05, 'Gustavo Costa Almeida', 'Rua Gustavo, 1491','Presidente Prudente','19025-780','SP');

	INSERT INTO Produto VALUES (01,'','',);

	INSERT INTO Vendedor VALUES(V01,'Ryan Sousa', ,);
	INSERT INTO Vendedor VALUES(V02,'Melissa Azevedo', ,);
	INSERT INTO Vendedor VALUES(V03,'Isabela Almeida', ,);
	INSERT INTO Vendedor VALUES(V04,'Vitór Cavalcanti ', ,);
	INSERT INTO Vendedor VALUES(V05,'Anna Rocha', ,);