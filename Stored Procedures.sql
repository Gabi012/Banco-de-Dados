/* 1.	Criar uma stored procedure para inserir um item de pedido. Esta deve receber como parametro o num. do pedido, codproduto, e a quantidade. O valor unitário deve ser obtido através da tabela produto.
Verifique se o campo PCO_UNIT existe na tabela item_pedido.
 */
CREATE PROC INSERE_ITEM @NUMPED INT, @CODPROD INT, @QTDE INT
AS
	DECLARE @PRECO MONEY
	SELECT @PRECO = VALOR_UNITARIO
	FROM produto
	WHERE cod_produto = @CODPROD
	
	INSERT INTO item_pedido VALUES (@NUMPED, @CODPROD, @QTDE, @PRECO)

/* A.	Criar uma stored procedure que atualize os salários dos vendedores com faixa de comissão = ´B´:
A procedure deverá receber como parâmetro de entrada um código que definirá a porcentagem de aumento. Se 
•	Código = 2 aumentar salário_fixo em 20%;
•	Código = 3 aumentar salário_fixo em 30%;
•	Código = 4 aumentar salário_fixo em 40%;
•	Código tiver um valor diferente destes o salário deverá permanecer o mesmo.
Iniciar e terminar a stored procedure efetuando um comando select na tabela vendedor.

Solução: */
CREATE PROC ATUALIZA_SAL @CODIGO INT 
AS

SELECT *
FROM VENDEDOR
WHERE faixa_comissao = 'B'

UPDATE VENDEDOR
SET salario_fixo = CASE @CODIGO
		   WHEN 2 THEN salario_fixo * 1.2
		   WHEN 3 THEN salario_fixo * 1.3
		   WHEN 4 THEN salario_fixo * 1.4
		   ELSE salario_fixo   
		   END
WHERE faixa_comissao = 'B'

SELECT *
FROM VENDEDOR
WHERE faixa_comissao = 'B'


Para executar a procedure:
EXEC ATUALIZA_SAL 2

-- B.	Criar uma stored procedure que liste uma classificação do produto de acordo com o especificado abaixo:
-- •	Se valor_unitario < 2, classificação = ‘Baixo’
-- •	Se valor_unitario entre 2 e 10, classificação = ‘Moderado’
-- •	Se valor_unitário > 10, classificação = ‘Caro’
-- O código do produto deve ser passado como parâmetro da procedure.
-- Listar o código do produto, a descrição, o valor unitário e a classificação.

-- Solução:
CREATE PROC CLASSICACAO_PROD @CODIGO INT
AS

SELECT COD_PRODUTO,
       DESCRICAO,
       VALOR_UNITARIO,
       CASE 
       WHEN VALOR_UNITARIO < 2 THEN 'BAIXO'
       WHEN VALOR_UNITARIO BETWEEN 2 AND 10 THEN 'MODERADO'
       WHEN VALOR_UNITARIO > 10 THEN 'CARO'
       END CLASSIFICACAO
FROM PRODUTO
WHERE COD_PRODUTO = @CODIGO	


Para executar a procedure:
EXEC CLASSICACAO_PROD 10

/* C.	Criar uma stored procedure para atualizar o valor unitário de um produto específico na tabela de produtos
A procedure deverá receber como parâmetros de entrada o código do produto que deverá ter seu preço atualizado e a taxa de aumento, que deverá ser um valor inteiro, por exemplo, 10, significando 10%, 20 significando 20% e assim por diante.
Listar os dados do produto especificado, no início e no fim da procedure.

Solução: */
CREATE PROC ATUALIZA_VAL_PROD @CODIGO INT, @TAXA INT
AS

SELECT *
FROM PRODUTO
WHERE COD_PRODUTO = @CODIGO

UPDATE PRODUTO
SET VALOR_UNITARIO = VALOR_UNITARIO * ((@TAXA/100.0)+1)
WHERE COD_PRODUTO = @CODIGO

SELECT *
FROM PRODUTO
WHERE COD_PRODUTO = @CODIGO


Para executar a procedure:
EXEC ATUALIZA_VAL_PROD 20,10

/* D.	Escrever uma stored pocedure que realize o seguinte:
•	Obter o código de um vendedor como parâmetro de entrada da procedure;
•	Testar se o código do vendedor existe na tabela vendedor, se não existir imprimir uma mensagem e sair da procedure;
•	Testar se o código do vendedor existe tabela de pedidos, se não existir imprimir uma mensagem de erro e sair da procedure;
•	Calcular o valor total de suas vendas e exibi-lo.

Solução: */
CREATE PROC DADOS_VENDEDOR @CODIGO INT
AS

IF NOT EXISTS(SELECT * 
              FROM VENDEDOR
              WHERE COD_VENDEDOR = @CODIGO)
BEGIN
  PRINT 'Vendedor não cadastrado'
  RETURN  
END
IF NOT EXISTS(SELECT * 
              FROM PEDIDO
              WHERE COD_VENDEDOR = @CODIGO)
BEGIN
  PRINT 'Vendedor não realizou o pedido'
  RETURN  
END

SELECT VENDEDOR.NOME_VENDEDOR, SUM(PRODUTO.VALOR_UNITARIO  * ITEM_PEDIDO.QUANTIDADE)TOTAL_DA_VENDA
FROM PEDIDO INNER JOIN ITEM_PEDIDO
     ON(PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO)
     INNER JOIN VENDEDOR
     ON(PEDIDO.COD_VENDEDOR = VENDEDOR.COD_VENDEDOR)
     INNER JOIN PRODUTO
     ON(PRODUTO.COD_PRODUTO =ITEM_PEDIDO.COD_PRODUTO)
WHERE VENDEDOR.COD_VENDEDOR =@CODIGO
GROUP BY  VENDEDOR.COD_VENDEDOR, VENDEDOR.NOME_VENDEDOR
 

Para executar a procedure:   (UM COMANDO DE CADA VEZ)
EXEC DADOS_VENDEDOR 3 
EXEC DADOS_VENDEDOR 5
EXEC DADOS_VENDEDOR 100
