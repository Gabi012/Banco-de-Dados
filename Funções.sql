/* 1-	Escreva uma função F_verhoras que receba como parâmetro uma data no formato dd/mm/yyyy e devolva-a no formato dd-mm-yyyy:HH24:mi:ss.
 */
CREATE FUNCTION fn_datahora (@data  datetime)
Returns varchar(50)
as
Begin
   declare  @datahora_formatado varchar(50);
   Select @datahora_formatado = convert (varchar, @data, 105) + convert (varchar, @data, 108)
     
   return @datahora_formatado; 
end


DECLARE @resultado VARCHAR(50)
SET @resultado =  dbo.fn_datahora ('26/10/2012')
PRINT @resultado


/* 2-	Escreva uma função que receba como parâmetro o código do cliente e conte quantos pedidos ele tem.
a-	Se ele tiver mais de 3 pedidos devolver mensagem: 'Cliente preferencial'
b-	Se ele tiver entre 1 e3 devolver mensagem 'Cliente Normal'
c-	Se ele não tiver pedidos 'Cliente Inativo';
 */
Create function fn_cliente ( @codcli  int)
Returns varchar(30)
as
Begin
    declare  @cont  int;
             @mensagem varchar(30);

   Select @cont = count(*)  From TB_pedido
    Where tb_pedido.codcli  = @codcli;

   if @cont > 3
      set @mensagem = 'Cliente Preferencial' + STr(@codcli);
   else  if @cont between 1 and 3
         set @mensagem = 'Cliente Normal' + STr(@codcli);
         else 
           set @mensagem = 'Cliente Inativo' + STr(@codcli);
   return @mensagem;
end

select * from tb_pedido
update tb_pedido set codcli =101 where numpedido = 406 
select dbo.fn_cliente(codcli) from tb_cliente


/* 3-	Crie uma função Chamada Consulta_estoque que retorna a qtde corrente em estoque de determinado produto.
a-	Passe para a função o código do produto
b-	Crie uma forma de executar a função criada.
 */
Create function Consulta_estoque ( @codprod  int)
Returns int
as
Begin
   declare  @qtde  int;
        
   Select @qtde = qtde_estoque From produto
   Where cod_produto  = @codprod;

   return @qtde;
end

select cod_produto, dbo.Consulta_estoque(3) from produto
where cod_produto = 3;


/* 4-	Escreva uma função que calcule o percentual de comissão a ser recebido por um determinado vendedor.

•	Informar o código de um vendedor como parâmetro de entrada da função.
•	Testar se o código do vendedor existe na tabela vendedor
•	Testar se o código do vendedor existe tabela de pedidos.
•	Calcular o valor total de suas vendas:
o	Se a somatória for menor que 100.000, a comissão será de 10%.
o	Se a somatória estiver entre 100.000 e 1.000.000, inclusive, a comissão será de  de 15%.
o	Se a somatória exceder o montante de 1.000.000, ele não tem direito à comissão.
•	Testar a função mostrando o código do vendedor, seu nome e o percentual que ele irá receber.


5-	Escreva uma função que receba como parâmetro um numero de telefone não formatado (só números) e exiba este número no formato (xx) xxxx-xxxx
 */
CREATE FUNCTION fn_telefone (@telefone  varchar(10))
Returns varchar(20)
as
Begin
   declare  @tel_formatado varchar(20);
   Select @tel_formatado = '(' + substring(@telefone, 1, 2) + ') ' + substring(@telefone, 3, 4) + '-' + substring(@telefone, 7, 4)
     
   return @tel_formatado;
end


DECLARE @resultado VARCHAR(20)
SET @resultado =  dbo.fn_telefone ('1140223582')
select @resultado
