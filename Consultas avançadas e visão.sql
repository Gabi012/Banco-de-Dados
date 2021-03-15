--1.	Listar o código e o nome dos vendedores que efetuaram vendas para o cliente com código 10.
SELECT PEDIDO.COD_VENDEDOR, NOME_VENDEDOR 
FROM VENDEDOR, PEDIDO, ITEM_PEDIDO, PRODUTO
WHERE VENDEDOR.COD_VENDEDOR = PEDIDO.COD_VENDEDOR
AND PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
AND PEDIDO.COD_CLIENTE = 10;

--2.	Listar o número do pedido, prazo de entrega, a quantidade e a descrição do produto com código 100.
SELECT NUM_PEDIDO, PRAZO_ENTREGA, QUANTIDADE, DESCRICAO
FROM PEDIDO, ITEM_PEDIDO, PRODUTO
WHERE PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
AND COD_PRODUTO = 10;

--3.	Quais os vendedores (código e nome) fizeram pedidos para o cliente 'José da Silva'.
SELECT PEDIDO.COD_VENDEDOR, NOME_VENDEDOR 
FROM VENDEDOR, PEDIDO, ITEM_PEDIDO, PRODUTO, CLIENTE
WHERE VENDEDOR.COD_VENDEDOR = PEDIDO.COD_VENDEDOR
AND PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO 
AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD_PRODUTO
AND PEDIDO.COD_CLIENTE = CLIENTE.COD_CLIENTE
AND NOME_CLIENTE = ‘JOSE DA SILVA’;

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

--5 – Visões 

--1.	Escreva uma visão que exiba o número do pedido, codcliente e prazo de entrega.
CREATE VIEW Ex1
AS
	SELECT NUM_PEDIDO, COD_CLIENTE, PRAZO_ENTREGA FROM PEDIDO;

--2.	Escreva uma visão que liste todos os produtos com unidade = ‘KG’.
CREATE VIEW Ex2
AS
	SELECT * FROM PRODUTO WHERE UNIDADE = ‘KG’;

--3.	Escreva uma visão que liste todos os produtos com valor_unitário menor que a média.
CREATE VIEW Ex3
AS
	SELECT COD_PRODUTO FROM PRODUTO WHERE VALOR_UNITARIO < AVG(VALOR_UNITARIO);

--4.	Escreva uma visão que liste o numero total de pedidos feitos por vendedor. Esta visão deve conter o cpodigo do vendedor, nome do vendedor e número total de pedidos.
CREATE VIEW Ex4
AS
SELECT VENDEDOR.COD_VENDEDOR, NOME_VENDEDOR, COUNT(NUM_PEDIDO) 
FROM VENDEDOR, PEDIDO
WHERE VENDEDOR.COD_VENDEDOR = PEDIDO.COD_VENDEDOR
GROUP BY VENDEDOR.COD_VENDEDOR, NOME_VENDEDOR;


