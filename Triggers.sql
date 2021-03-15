
/* 1.	Escreva uma trigger que, ao inserir um novo cliente, verifique se o estado que está sendo inserido para esse cliente é igual a RJ ou ES.
Se for, exibir uma mensagem de erro utilizando raiserror e retroceder a transação.
Se não for, exibir a mensagem ‘Estado permitido’ e efetivar a transação.
 */
CREATE TRIGGER VERIF_UF 
ON CLIENTE
FOR INSERT
AS
	IF EXISTS (SELECT UF FROM INSERTED WHERE UF IN ('RJ','ES'))
        BEGIN
	           RAISERROR ('INSERÇÃO REGISTRO CANCELADA',10,1)
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT('ESTADO PERMITIDO')
		COMMIT TRANSACTION		
	END
GO

2.	Criar a tabela TLogProduto:

CREATE TABLE TLOGPRODUTO
(
 	USUARIO      	VARCHAR(30),
	DTALTERACAO  	DATETIME,
	NOMEPRODUTO  	VARCHAR(20)
)

/* Escreva uma trigger que, ao cadastrar um produto, atualize a tabela TLogProduto com o usuário corrente (CURRENT_USER) que está executando a transação, a data atual do sistema (GETDATE()) e o nome do produto que está sendo inserido.
Após a inserção na tabela TLogProduto, verificar o valor de @@ERROR. Se for diferente de zero, exibir uma mensagem de erro utilizando raiserror e retroceder a transação; se for igual a zero, efetivar a transação. 
 */
CREATE TABLE TLOGPRODUTO
(
 	USUARIO      		VARCHAR(30),
	DTALTERACAO  		DATETIME,
	NOMEPRODUTO  		VARCHAR(20)
)

CREATE TRIGGER VERF_INCLUSAO
ON PRODUTO
FOR INSERT
AS
	RAISERROR('INCLUSÃO CANCELADA',10,1)

DECLARE @NOMEPRODUTO VARCHAR(30)
SET @NOMEPRODUTO = (SELECT DESCRICAO FROM INSERTED)

	INSERT INTO TLOGPRODUTO VALUES (CURRENT_USER,GETDATE(),@NOMEPRODUTO)
	
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('ERRO NA TRANSAÇÃO',18,1)
		ROLLBACK TRANSACTION
	END
	ELSE
		COMMIT TRANSACTION

GO

/* 3.	Escreva um trigger que, ao cadastrar um item pedido, atualize a tabela de produtos a seguinte forma:

     Se  qtd_Estoque (tab. produto)  >=  a qtdePedida( tab inserted)
Então atualizar: 
qtde estoque (tab. produto) = qtde estoque(tab. produto)  - qtde pedida(tab inserted)
     Caso contrário 
•	Utilizar raiserror para emitir mensagem: ”ESTOQUE INSUFICIENTE”, incluindo também na mensagem o código do produto que está em falta.
•	Retroceder a transação 
 */
CREATE TRIGGER INSERE_ITEM
ON ITEM_PEDIDO
FOR INSERT
AS
   DECLARE @QTDEPED INT
   DECLARE @COD_PRODUTO INT
   
      
    SELECT @COD_PRODUTO =COD_PRODUTO,  
                    @QTDEPED = QUANTIDADE FROM INSERTED

   IF @QTDEPED > (SELECT QTDE_ESTOQUE FROM PRODUTO WHERE COD_PRODUTO = @COD_PRODUTO)
   BEGIN
      	RAISERROR (‘ESTOQUE INSUFICIENTE DO   
      	PRODUTO % D - INCLUSÃO CANCELADA’,10,1, @COD_PRODUTO)
      	ROLLBACK TRAN
   END
   ELSE
              BEGIN
      UPDATE PRODUTO
      SET QTDE_ESTOQUE = QTDE_ESTOQUE - @QTDEPED
      WHERE COD_PRODUTO = @COD_PRODUTO
      IF @@ERROR = 0 
          COMMIT TRAN
      ELSE
            BEGIN
            	RAISERROR (‘ERRO NA ALTERAÇÃO DA TABELA PRODUTO’, 14,1)
            	ROLLBACK TRAN
            END

A TRIGGER DISPARA APÓS A EXECUÇÃO DO COMANDO INSERT NA TABELA ITEM_PEDIDO:
INSERT INTO ITEM_PEDIDO VALUES (12,10,10) 

/* 4.	Escreva um trigger que, ao ser incluído um pedido na tabela Pedido verifique se a data de entrega está programada para domingo ( IF datepart(dw,dataentrega) = 1). 
Neste caso alterar a data de entrega para a segunda_feira próxima.
 */
CREATE TRIGGER INSERE_PEDIDO
ON PEDIDO
FOR INSERT
AS
   DECLARE @DATA DATETIME
   DECLARE @NUM_PEDIDO INT
   
SELECT  @DATA =DATA_ENTREGA, @NUM_PEDIDO = NUM_PEDIDO   FROM INSERTED
          
   IF DATEPART(DW,@DATA)=1 
     BEGIN
      	UPDATE PEDIDO
      	SET DATA_ENTREGA = DATA_ENTREGA + 1
      	WHERE NUM_PEDIDO = @NUM_PEDIDO
       	IF @@ERROR = 0
       	BEGIN
PRINT ('ATUALIZAÇÃO EFETUADA COM SUCESSO NA TABELA PEDIDO')                                        
       		COMMIT TRAN
        	END
       	ELSE
          	BEGIN
RAISERROR ( ‘ERRO NA ATUALIZAÇÃO DA TABELA PEDIDO’,15, 1)
           		ROLLBACK TRAN
           	END

A TRIGGER DISPARA APÓS A EXECUÇÃO DO COMANDO INSERT NA TABELA PEDIDO:
 INSERT INTO PEDIDO VALUES (25,GETDATE(),'04/21/07',2,3) 
INSERT INTO PEDIDO VALUES (26,GETDATE(),'04/22/07',1,2) 


/* 5.	Escreva um Trigger que, ao ser inserido um cliente, verifique se o campo CPF está nulo, se estiver emita mensagem de erro utilizando raiserror, incluindo também na mensagem o código do cliente, e retroceda a transação. Caso contrário efetive a transação.
 */
alter TRIGGER VERIFICA_CPF
ON CLIENTE
FOR INSERT
AS
   DECLARE @COD_CLIENTE INT
   
   SELECT @COD_CLIENTE = COD_CLIENTE FROM INSERTED
      
   IF (SELECT CPF_CGC FROM CLIENTE WHERE 
                    COD_CLIENTE = @COD_CLIENTE) IS NULL 
   BEGIN
        RAISERROR ('CAMPO CPF NÃO PODE SER NULO - CLIENTE ')
      	ROLLBACK TRAN
   END

A TRIGGER DISPARA APÓS A EXECUÇÃO DO COMANDO INSERT NA TABELA CLIENTE:
INSERT INTO CLIENTE VALUES (24,'ZÉ RUELA','RUA DOSVEADEIROS,24','CAMPINAS',19124241,'SP',NULL,45214287)

/* 
6.	Escreva um trigger que, ao ser inserido um vendedor, verifique se o salário é maior que $400.00. Se não for emitir mensagem de erro utilizando raiserror, incluindo também na mensagem o código do vendedor e, retroceder a transação. Caso contrário efetive a transação.
 */
CREATE TRIGGER VERIFICA_SALARIO
ON VENDEDOR
FOR INSERT
AS
   DECLARE @COD_VENDEDOR INT
   SET @COD_VENDEDOR = (SELECT COD_VENDEDOR FROM INSERTED)
    
   IF (SELECT SALARIO_FIXO FROM VENDEDOR 
          WHERE COD_VENDEDOR =  @COD_VENDEDOR) <= 400  
     BEGIN
RAISERROR ('INCLUSÃO NÃO PERMITIDA PARA O VENDEDOR:%D',10,1,@COD_VENDEDOR)   
     		ROLLBACK TRAN
     END
    ELSE
          	COMMIT TRAN

A TRIGGER DISPARA APÓS A EXECUÇÃO DO COMANDO INSERT NA TABELA VENDEDOR:
 INSERT INTO VENDEDOR VALUES (30,'OSMAR MOTA','A',550) 

