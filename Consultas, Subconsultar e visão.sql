Realizando Consultas

--1.	Listar número do pedido e prazo de entrega de todos os pedidos.
SELECT NUM_PEDIDO, PRAZO ENTREGA FROM PEDIDO;

--2.	Listar a descrição e o valor unitário dos produtos.
SELECT DESCRICAO, VALOR_UNITARIO FROM PRODUTO;

--3.	Listar nome e endereço de todos os clientes.
SELECT NOME_CLIENTE, ENDERECO FROM CLIENTE;

--4.	Listar nome de todos os vendedores.
SELECT NOME_VENDEDOR FROM VENDEDOR;

--5.	Listar todas as informações da tabela de clientes.
SELECT * FROM CLIENTE.

--6.	Listar todas as informações da tabela produtos.
SELECT * FROM PRODUTO;

--7.	Listar o nome de todos os vendedores. Alterar o cabeçalho da coluna para nome.
SELECT NOME_VENDEDOR AS NOME FROM VENDEDOR;

--8.	Listar o preço dos produtos simulando um aumento em 10%.
SELECT (VALOR UNITARIO * 1.1) FROM PRODUTO;

--9.	Listar o salário fixo dos vendedores simulando o aumento em 5%.
SELECT (SALARIO_FIXO * 1.05) FROM VENDEDOR;

--10.	Listar o nome dos clientes que moram em Sorocaba.
SELECT NOME_CLIENTE FROM CLIENTE WHERE CIDADE = ‘SOROCABA’;

--11.	Listar todos os dados dos vendedores com salário fixo <$400,00.
SELECT * FROM VENDEDOR WHERE SALARIO_FIXO < 400;
--12.	Listar o código do produto e a descrição para os produtos cuja unidade seja igual  a "Kg".
SELECT COD_PRODUTO, DESCRICAO FROM PRODUTO WHERE UNIDADE = ‘KG’;

--13.	Listar o pedido e o prazo de entrega para os pedidos feitos entre 01/05/1998 a 01/06/1998.
SELECT NUM_PEDIDO, PRAZO_ENTREGA FROM PEDIDO WHERE PRAZO ENTREGA BETWEEN ‘01/05/1998’ AND ‘01/06/1998’;

--14.	Listar o pedido e o prazo de entrega para os pedidos com data de entrega no ano de 2004.
SELECT NUM_PEDIDO, PRAZO_ENTREGA FROM PEDIDO WHERE YEAR(PRAZO ENTREGA) = ‘2004’;

--15.	Listar os dados dos produtos cujo valor unitário seja maior que $100,00 e menor que $200,00.
SELECT * FROM PRODUTO WHERE VALOR_UNITARIO > 100 AND VALOR_UNITARIO < 200;

--16.	Listar o número do pedido e o código do produto cuja quantidade esteja entre 1000 e 1500.
SELECT NUM_PEDIDO, COD_PRODUTO FROM ITEM_PEDIDO WHERE QUANTIDADE BETWEEN 1000 AND 1500;

--17.	Listar o nome dos vendedores cujo nome comece por "José".
SELECT NOME_VENDEDOR FROM VENDEDOR WHERE NOME_VENDEDOR LIKE “JOSÉ%’;

--18.	Listar o nome de todos os clientes cujo ultimo nome seja "Silva".
SELECT NOME_CLIENTE FROM CLIENTE WHERE NOME_CLIENTE LIKE ‘%SILVA’;

--19.	Listar a descrição e o código dos produtos que tem a seqüência "AC" em qualquer parte da descrição.
SELECT DESCRICAO, COD_PRODUTO FROM PRODUTO WHERE DESCRICAO LIKE ‘%AC%’;

--20.	Listar os nomes dos clientes que não tenham endereço cadastrado.
SELECT NOME_CLIENTE FROM CLIENTE WHERE ENDERECO IS NULL;

--21.	Listar as cidades onde moram os clientes (exibir cada cidade apenas uma vez).
SELECT DISTINCT CIDADE FROM CLIENTE;

--22.	Listar os dados dos clientes por ordem alfabética de nome.
SELECT * FROM CLIENTE ORDER BY NOME CLIENTE;

--23.	Listar os dados dos clientes por ordem alfabética decrescente de cidade.
SELECT * FROM CLIENTE ORDER BY CIDADE DESC;

--24.	Listar os dados dos clientes por ordem de cidade e por ordem do nome dos clientes.
SELECT * FROM CLIENTE ORDER BY CIDADE, NOME_CLIENTE;

--25.	Listar os códigos e a descrição dos produtos, cuja unidade igual o "Kg" por ordem alfabética de descrição.
SELECT COD_PRODUTO, DESCRICAO FROM PRODUTO WHERE UNIDADE = ‘KG’ ORDER BY DESCRICAO;

--3 - Consultas usando funções

--1.	Listar a maior quantidade que conste na tabela de item do pedido.
SELECT MAX(QUANTIDADE) FROM ITEM-PEDIDO;

--2.	Listar o menor valor unitário da tabela de produtos.
SELECT MIN(VALOR_UNITARIO) FROM PRODUTO;

--3.	Listar a somatória dos salários fixos pago aos vendedores.
SELECT SUM(SALARIO_FIXO) FROM VENDEDOR;

--4.	Listar o numero de produtos cuja unidade seja igual a "Lt".
SELECT COUNT(COD_PRODUTO) FROM PRODUTO WHERE UNIDADE = ‘LT’;

--5.	Listar o numero de clientes agrupados por cidade.
SELECT CIDADE, COUNT(COD_CLIENTE) FROM CLIENTE GROUP BY CIDADE;

--6.	Listar quantos pedidos cada vendedor realizou.
SELECT COD_VENDEDOR, COUNT(NUM_PEDIDO) FROM PEDIDO GROUP BY COD_VENDEDOR;

--7.	Listar o maior e o menor valor unitário para cada tipo de unidade de produto.
SELECT COD_PRODUTO, UNIDADE, MAX(VALOR_UNITARIO), MIN(VALOR UNITARIO) FROM PRODUTO GROUP BY COD_PRODUTO, UNIDADE;

--8.	Listar o numero de clientes, agrupados por cidade para todas as cidades que aparecem mais de 4 vezes na tabela de clientes.
SELECT CIDADE, COUNT(CD_CLIENTE) FROM CLIENTE GROUP BY CIDADE HAVING COUNT(CIDADE) > 4;


--4  – Consultas avançadas

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

--.	Listar o número do pedido, o código do produto, a descrição do produto, o código do vendedor, o nome do vendedor , o nome do cliente, para todos os clientes que moram em Sorocaba.
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



--6  – Subconsultas

--1.	Listar todos os clientes que moram na mesma cidade que 'João da Silva'.
SELECT NmCliente
FROM Cliente
WHERE Cidade = 	(SELECT Cidade FROM Cliente 
WHERE NmCliente = ‘JOAO DA SILVA);

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

