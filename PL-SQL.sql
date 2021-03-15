Exercício 1
Montar um programa PL/SQL que escreva seu nome na tela.

Solução:
DECLARE @nome VARCHAR(50)
SELECT @nome = 'DANIELLA'

PRINT ('O meu nome é: ' + @nome)

Exercício 2
Montar um programa PL/SQL que declare uma variável nome e uma sobrenome, preencha-as e mostre na tela o nome concatenado (nome + sobrenome).

Solução:
DECLARE @nome VARCHAR(50), @sobrenome VARCHAR(50)
SET @nome = 'DANIELLA'
SET @sobrenome = 'ARRUDA FRANCESCHINELLI BORGES'

PRINT ('O meu nome é: ' + @nome + ' e o meu sobrenome é: ' + @sobrenome)

Exercício 3
Montar um programa PL/SQL que descreva o algoritmo abaixo e escreva a saída do mesmo.

	inteiro: a, b;
	real: d, c;
	a <- 10;
	b <- 25;
	c <- 15;
	d <- 5.5;
	a <- b * c;
	c <- d * b + c;
	b <- b * b + 18000;
	a <- a – a;
	d <- 52.55;
	Escreva (“O valor de A = “, a);
	Escreva (“O valor de B = ‘, b);

Solução:
DECLARE @a INTEGER, @b INTEGER, @c REAL, @d REAL

SELECT @a = 10, @b = 25, @c = 15, @d = 5.5

SET @a = @b * @c
SET @c = @d * @b + @c
SET @b = @b * @b + 18000
SET @a = @a - @a
SET @d = 52.55 

PRINT ('O valor de A é : ' + STR(@a))
PRINT ('O valor de B é : ' + STR(@b))





Para resolver os exercícios abaixo deve ser utilizado o MER abaixo.
 
Exercício 4
Montar um programa PL/SQL que:
•	Mostre o nome, data de admissão e salário do funcionário 1034
•	Mostre a seguinte mensagem para o usuário.  
O funcionário xxxxxxxx foi admitido em xxxxxxxxx com salário de xxxxxx.

Solução:
DECLARE @nome VARCHAR(20), @dt_adm DATETIME, @sal MONEY

SET @nome = (SELECT NmFunc FROM funcionarios WHERE CdFunc = '1034')
SET @dt_adm = (SELECT DTAdm FROM funcionarios WHERE CdFunc = '1034')
SET @sal = (SELECT VrSalario FROM funcionarios WHERE CdFunc = '1034')

PRINT('O Funcionário ' + @nome + ' foi admitido em ' + CONVERT (char(10), @dt_adm, 103) + ' com salário de R$ ' + str(@sal))


Exercício 5
Montar um programa PL/SQL que:
•	Leia o nome do departamento D003 e emita a seguinte mensagem: O Nome do departamento D003 é: xxxxxxxxxx 

Solução:
DECLARE @nomeDP VARCHAR(20)
SET @nomeDP = (SELECT NmDepto FROM deptos WHERE CdDepto = 'D003')

PRINT('O nome do departamento D003 é: ' + @nomeDP )


Exercício 6
Montar um programa PL/SQL que:
•	Leia salário, nome e cargo do funcionário 1021
•	Dar um aumento de 10% para este funcionário. Armazenar em uma variável o valor calculado do novo salário.
•	Exibir a seguinte mensagem:
O novo salário do Funcionário xxxxxxx, cargo xxxxx é: xxxxxxx 

Solução:
DECLARE @sal MONEY, @nome VARCHAR(20), @cargo VARCHAR(20), @novosal MONEY

SET @sal = (SELECT VrSalario FROM funcionarios WHERE CdFunc = '1021')
SET @nome = (SELECT NmFunc FROM funcionarios WHERE CdFunc = '1021')
SET @cargo = (SELECT NmCargo FROM funcionarios f, cargos c WHERE f.CdCargo = c.CdCargo AND CdFunc = '1021')

SET @novosal = @sal * 1.1

PRINT('O novo salário do funcionário ' + @nome + ' ,cargo ' + @cargo + ' é: R$ ' + str(@novosal))

Exercício 7
Montar um programa PL/SQL que:
•	Calcule a média de salário dos funcionários do departamento D001. 
•	Exibir a seguinte mensagem:
A média de salário do departamento D001 é de: xxxxx 
Dica: para calcular a média utilizar a função AVG

Solução:
DECLARE @media MONEY

SET @media = (SELECT AVG(VrSalario) FROM funcionarios WHERE CdDepto = 'D001')

PRINT('A média de salário do departamento D001 é: R$ ' + str(@media))

Exercício 8
Fazer um programa PL/SQL que:
•	Mostre a descrição do cargo, o salário mínimo e o máximo do cargo C004.
•	Mostre a seguinte mensagem para o usuário:
  	O cargo xxxx tem um salário mínimo de xxx e um salário máximo de xxx

Solução:
DECLARE @salmin MONEY, @salmax MONEY

SET @salmin = (SELECT MIN(VrSalario) FROM funcionarios f, cargos c WHERE f.CdCargo = c.CdCargo AND NmCargo = 'C004')
SET @salmax = (SELECT MAX(VrSalario) FROM funcionarios f, cargos c WHERE f.CdCargo = c.CdCargo AND NmCargo = 'C004')

PRINT('O cargo C004 tem um salário mínimo de R$ ' + str(@salmin) + ' e um salário máximo de R$ ' + str(@salmax))

Exercício 9
Fazer um programa PL/SQL que:
•	Mostre a soma dos salários dos funcionários 1048 e 1015.
•	Mostre o nome dos dois funcionários
•	Mostre a seguinte mensagem para o usuário.  
  	A soma dos salários dos funcionários xxxxxx e xxxxxx é xxxxxxx 

Solução:
DECLARE @nome1 VARCHAR(20), @sal1 MONEY, @nome2 VARCHAR(20), @sal2 MONEY, @somasal MONEY

SET @nome1 = (SELECT NmFunc FROM funcionarios WHERE CdFunc = '1048')
SET @sal1 = (SELECT VrSalario FROM funcionarios WHERE CDFunc = '1048')

SET @nome2 = (SELECT NmFunc FROM funcionarios WHERE CdFunc = '1015')
SET @sal2 = (SELECT VrSalario FROM funcionarios WHERE CDFunc = '1015')

SET @somasal = @sal1 + @sal2

PRINT('A soma dos salários dos funcionários ' + @nome1 + ' e ' + @nome2 + ' é: R$ ' + str(@somasal))
