
SELECT *
FROM PEDIDO

ALTER TABLE PRODUTO
ADD QTDE_ESTOQUE INT

ALTER TABLE VENDEDOR
ADD PORC_COMISSAO FLOAT
/* 
1.	Escreva uma Stored Procedure  que realize o seguinte:

•	Obter o codigo de um vendedor como parâmetro de entrada da procedure
•	Testar se o código do vendedor existe na tabela vendedor, se não existir gerar uma mensagem de erro utilizando raiserror e sair da procedure
•	Testar se o código do vendedor existe tabela de pedidos, se não existir gerar uma mensagem informando que o vendedor não tem pedidos e sair da procedure
•	Calcular o valor total de suas vendas:
o	Se a somatória for menor que 100.000, atualize a tabela vendedor atribuindo um percentual a este empregado de 10%
o	Se a somatória estiver entre 100.000 e 1.000.000, inclusive, atualize a tabela vendedor atribuindo um percentual de 15%
o	Se a somatória exceder o montante de 1.000.000, atualize a tabela vendedor atribuindo um percentual de 20%
•	Exibir os dados da tabela vendedor
 */
CREATE PROC DADOS_VEND @COD_VEND INT
AS
IF NOT EXISTS (SELECT * FROM VENDEDOR WHERE COD_VENDEDOR = @COD_VEND)
BEGIN
	RAISERROR ('VENDEDOR NÃO CADASTRADO', 10, 1)
	RETURN
END

IF NOT EXISTS (SELECT * FROM PEDIDO WHERE COD_VENDEDOR = @COD_VEND)
BEGIN
	RAISERROR ('VENDEDOR NÃO TEM PEDIDOS CADASTRADOS', 10, 1)
	RETURN
END

DECLARE @TOTAL FLOAT

SET @TOTAL = (SELECT SUM(ITEM_PEDIDO.QUANTIDADE * PRODUTO.VALOR_UNITARIO)
	       FROM ITEM_PEDIDO,PRODUTO, PEDIDO
	       WHERE COD_VENDEDOR = @COD_VEND AND
	      	     PRODUTO.COD_PRODUTO = ITEM_PEDIDO.COD_PRODUTO AND
		     PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO  )

UPDATE VENDEDOR SET PORC_COMISSAO = CASE
				    WHEN @TOTAL < 100000 THEN 10
				    WHEN @TOTAL BETWEEN 100000 AND 1000000 THEN 15
				    ELSE 20
				    END
WHERE COD_VENDEDOR = @COD_VEND

SELECT * FROM VENDEDOR

Para executar a procedure:

EXEC DADOS_VEND 1
EXEC DADOS_VEND 3
/* 

2.	Escreva uma stored procedure para inserir um pedido na tabela de pedidos.

A data da entrega prevista deve ser calculada da seguinte forma:
•	Se código do produto entre 1 e 10 somar 15 dias à data atual
•	Se código do produto entre 11 e 20 somar 30 dias à data atual

Primeiramente, testar se o código do cliente existe na tabela cliente, se não existir gerar uma mensagem de erro utilizando raiserror e sair da procedure.
Testar se o código do vendedor existe na tabela vendedor, se não existir gerar uma mensagem de erro utilizando raiserror e sair da procedure.
 */
SELECT * FROM PEDIDO

CREATE PROC INSERIR_PEDIDO @COD_PED INT, @COD_PROD INT,@COD_CLI INT ,@COD_VEND INT
AS
DECLARE @TOTDIAS INT

IF NOT EXISTS (SELECT * FROM CLIENTE WHERE COD_CLIENTE = @COD_CLI)
BEGIN
	RAISERROR ('CLIENTE NÃO ESTÁ CADASTRADO!', 10, 1)
	RETURN
END

IF NOT EXISTS (SELECT * FROM VENDEDOR WHERE COD_VENDEDOR = @COD_VEND)
BEGIN
	RAISERROR ('VENDEDOR NÃO ESTÁ CADASTRADO!', 10, 1)
	RETURN
END


IF @COD_PROD BETWEEN 1 AND 10
   SELECT @TOTDIAS=15
ELSE
   SELECT @TOTDIAS=30

INSERT INTO PEDIDO (NUM_PEDIDO, DATA_COMPRA, DATA_ENTREGA, COD_CLIENTE, COD_VENDEDOR) VALUES (@COD_PED, GETDATE(), GETDATE()+@TOTDIAS,@COD_CLI,@COD_VEND)

Para executar a procedure:
	
EXEC INSERIR_PEDIDO 21,5,5,5 	
EXEC INSERIR_PEDIDO 22,15,3,4


/* 3.	Escreva uma stored procedure para inserir itens de pedido:
•	Verificar se pedido existe na tabela de pedidos. Se não existir emitir mensagem apropriada utilizando raiserror, sair da procedure
•	Verificar se produto existe na tabela de produtos. Se não existir emitir mensagem apropriada utilizando raiserror, sair da procedure
•	Verificar se quantidade é maior que zero, caso contrário emitir mensagem apropriada utilizando raiserror e sair da procedure
• */	Verificar se a quantidade em estoque do produto é maior ou igual à quantidade pedida. Se o estoque for insuficiente existir emitir mensagem apropriada utilizando raiserror, sair da procedure

CREATE PROC INSERIR_ITEM @NUM_PED INT , @COD_PROD INT , @QTDE INT
AS

IF NOT EXISTS (SELECT * FROM PEDIDO WHERE NUM_PEDIDO = @NUM_PED)
BEGIN
   RAISERROR ('PEDIDO NÃO CADASTRADO', 10, 1)
   RETURN
END

IF NOT EXISTS (SELECT * FROM PRODUTO WHERE COD_PRODUTO = @COD_PROD) 
BEGIN
   RAISERROR ('PRODUTO NÃO CADASTRADO', 10, 1)
   RETURN
END

IF @QTDE < 0
BEGIN
   RAISERROR ('QUANTIDADE MENOR QUE 0 (ZERO)', 10, 1)
   RETURN 	
END

IF (SELECT QTDE_ESTOQUE FROM PRODUTO WHERE COD_PRODUTO = @COD_PROD) <  @QTDE
BEGIN
   RAISERROR ('QUANTIDADE EM ESTOQUE INSUFICIENTE', 10, 1)
   RETURN 
END

INSERT INTO ITEM_PEDIDO VALUES (@NUM_PED, @COD_PROD, @QTDE)

Para executar a procedure:

EXEC INSERIR_ITEM 10,10,10
EXEC INSERIR_ITEM 50,20,10
EXEC INSERIR_ITEM 10,50,5


@@Error
/* 
1.Crie uma stored procedure para entrar dados na tabela região.
•	O nome da nova região deve ser parâmetro de entrada.
•	Após a inserção, teste @@error -> se diferente de 0 retroceda a transação, caso contrário efetive a transação.

Solução: */
CREATE PROC Cria_Regiao @Nome_Regiao VarChar(15)
AS

BEGIN TRANSACTION

INSERT Regiao VALUES(@nome_Regiao)
	IF @@Error = 0
	BEGIN
		PRINT 'Nenhum Erro'
		COMMIT TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'Erro na inserção'
		ROLLBACK TRANSACTION
	END

Para executar a procedure:
EXEC Cria_Regiao 'SUDOESTE'
EXEC Cria_Regiao 'NORTE'
EXEC Cria_Regiao 'NORTE'
EXEC Cria_Regiao 'LESTE'
EXEC Cria_Regiao 'OESTE'
EXEC Cria_Regiao 'NOROESTE'
EXEC Cria_Regiao 'SUL'

/* 
2. Crie uma stored procedure para entrar dados na tabela departamento.
•	O nome do novo departamento deve ser parâmetro de entrada.
•	Atribua a este departamento uma região nula.
•	Teste @@error -> se diferente de 0 retroceda a transação, caso contrário efetive a transação.

Solução: */
CREATE PROC Cria_Depto @Nome_Departamento varchar(20)
AS

BEGIN TRANSACTION
INSERT Departamento(nome_Departamento) VALUES (@nome_Departamento)
  IF @@Error = 0
  BEGIN
	PRINT 'Nenhum erro!'
	COMMIT TRANSACTION
  END
  ELSE
  BEGIN
	PRINT 'Não foi possível realizar a inserção!'
	ROLLBACK TRANSACTION
  END

Para executar a procedure:
EXEC Cria_Depto 'PRESIDENCIA'
EXEC Cria_Depto 'ENGENHARIA'
EXEC Cria_Depto 'MARKETING'
EXEC Cria_Depto 'COMPRAS'
EXEC Cria_Depto 'VENDAS'
EXEC Cria_Depto 'GERENCIA'


/* 3. Criar uma stored procedure que altere o código de região de um departamento já existente:
•	Informar o código do departamento e o nome da região como parâmetro de entrada.
•	A partir do nome da região obter o código da região, acessando a tabela região.
o	Se o nome da região não existir na tabela região, emitir mensagem e sair da procedure;
o	No caso de 2 ou mais linhas serem retornadas (@@rowcount > 1) emitir  a seguinte mensagem: ‘O  nome da região esta duplicado’ e sair da procedure;
o	Se ocorrer qualquer outro erro (@@error diferente de 0)  informar ‘Algum erro ocorreu’ e sair da procedure.
•	Alterar o código da região na tabela departamento (especificamente para o código do departamento informado como parâmetro), para o código obtido no acesso à tabela região.
•	Teste @@error -> se diferente de 0 retroceda a transação, caso contrário efetive a transação.

Solução: */
CREATE PROCEDURE Altera_Depto @COD_DEPTO INT, @NOME_REG VARCHAR (15)
AS
    IF NOT EXISTS (SELECT * FROM DEPARTAMENTO WHERE COD_DEPARTAMENTO=@COD_DEPTO)
    BEGIN
      PRINT ('DEPARTAMENTO INVÁLIDO')
      RETURN
    END
    ELSE   
    IF NOT EXISTS (SELECT * FROM REGIAO WHERE NOME_REGIAO=@NOME_REG)
    BEGIN
      PRINT ('REGIAO INEXISTENTE')
      RETURN
    END
    ELSE
     SELECT * FROM REGIAO 
     WHERE NOME_REGIAO=@NOME_REG
     IF @@ROWCOUNT>1 
     BEGIN
        PRINT ('REGIÃO DUPLICADA')
        RETURN
     END
     ELSE
     
     DECLARE @COD_REGIAO INT
     
     SELECT @COD_REGIAO=COD_REGIAO FROM REGIAO
     WHERE NOME_REGIAO=@NOME_REG
     
     IF @@ERROR <>0 
     BEGIN
        PRINT('ERRO NA OPERAÇÃO')
        RETURN
     END
     ELSE
     BEGIN TRANSACTION
       UPDATE DEPARTAMENTO SET COD_REGIAO=@COD_REGIAO
       WHERE COD_DEPARTAMENTO=@COD_DEPTO
       IF @@ERROR = 0
       BEGIN
          PRINT ('ATUALIZAÇÃO EFETUADA COM SUCESSO')
          COMMIT TRANSACTION
       END
       ELSE
       BEGIN
          PRINT ('ERRO NA ATUALIZAÇÃO')
          ROLLBACK TRANSACTION
       END

Para executar a procedure:
EXEC Altera_Depto 27,'NORTE'
EXEC Altera_Depto 28,'NORTE'
EXEC Altera_Depto 50,'SUL'
EXEC Altera_Depto 5,'CENTROESTE'
EXEC Altera_Depto 32,'OESTE'

