CREATE DATABASE BD_Func;

USE BD_FUNC
CREATE TABLE Projetos
(NrProj INT PRIMARY KEY IDENTITY,
DsProj VARCHAR(50))

CREATE TABLE Trabalha_em
(	NrMatric INT REFERENCES Funcionarios,
	NrProj INT REFERENCES Projetos,
	PRIMARY KEY (NrMatric,NrProj))

	                                            
INSERT INTO Projetos VALUES ('Projeto A')
INSERT INTO Projetos VALUES ('Projeto B')

INSERT INTO Trabalha_em VALUES (1,1)
INSERT INTO Trabalha_em VALUES (1,2)
INSERT INTO Trabalha_em VALUES (2,2)
INSERT INTO Trabalha_em VALUES (4,1)
INSERT INTO Trabalha_em VALUES (6,2)
INSERT INTO Trabalha_em VALUES (7,1)
INSERT INTO Trabalha_em VALUES (7,2)

--MOSTRAR O NOME E O SALARIO DOS FUNSIONARIAS QUE TRABALHAM NO 
--MESMO DEPARTAMENTO QUE 'JAO  NOGUEIRA' TRABALHA.
 
 SELECT NMFUNC , VRSALARIO
 FROM Funcionarios
 WHERE CdDEPTO = ( SELECT CDDEPTO
					FROM Funcionarios
						WHERE NMfunc = 'JOAO' AND SOBRENOME = 'NOGUEIRA')
AND NmFunc <> 'JOAO'


--MOSTRAR O NOME DOS FUNCIONARIOS QUE POSSUE SALARIO MAIOR DO
-- QUE A MEDIA SALARIAL DA EMPRESA.

SELECT NMFUNC FROM Funcionarios 
WHERE vrsalario > (SELECT AVG(VRSALARIO ) FROM Funcionarios)


--MOSTRAR O NOEMD OS CARGOS QUE POSSUEM A MESMA QUANTIDADE DE FUNCIONARIOS DE
-- O CARGOS 'GERENTE' POSSUI

SELECT NmCARGO
FROM Cargos C, FUNCIONARIOS F
WHERE C.CdCargo = F.CdCargo
AND NmCargo <> 'GERENTE'
GROUP BY NmCargo
HAVING COUNT(*) = (SELECT COUNT(*)
					FROM Funcionarios F, Cargos C
					WHERE F.CDCARGO = C.CDCARGO
					AND NmCargo = 'GERENTE')

--MOSTRAR O NOME DOS FUNCIONARIOS QUE PARTICIPARAM DOS MESMOS
--PROJETOS QUE O FUNCIONARIO 1 PARTICIPOU
SELECT NMFUNC
FROM FUNCIONARIOS F, Trabalha_em T
WHERE F.NrmATRIC = T.NrMatric 
AND NrProj in (SELECT NrProj 
				FROM Trabalha_em
					WHERE NrMatric = 1)
AND F.NrMatric <> 1

--MOSTRAR O NOME DE TODOS OS FUNCIONARIOS QUE FORM ADMITIDOS ANTES DO 
-- ANO 2000 OU QUE PERTENCEM AO DEPTO 'COMECIAL' (USAR UNIAO)

(SELECT NMFUNC 
FROM FUNCIONARIOS 
WHERE YEAR (DTADM) < '2000')
UNION
(SELECT NMFUNC 
FROM FUNCIONARIOS F,Deptos D
WHERE F.CDDEPTO = D.CdDepto
AND NmDepto =  ' ADMINISTRATIVO')



--MOSTRAR O MRMATRIC E A DTADM DOS FUNCIONARIOS QUE GANHAM MAIS
-- DE R$ 6000,00 E QUE NAO POSSUEM CARGO c10 (USAR INTERSECÇÃO)

(SELECT NRMATRIC, DTADM
FROM FUNCIONARIOS
WHERE VRSALARIO > 6000)
INTERSECT
(SELECT NRMATRIC , DTADM
FROM FUNCIONARIOS
WHERE CdCargo <> 'c10')

--MODTRAR O NOME DOS FUNCIONARIOS QUE NAO PARTICIPAM DE PROJETOS
--(USAR DIFERENÇA DE CONJUNTOS)

(SELECT NrMatric,NmFunc from FUNCIONARIOS)
EXCEPT
(SELECT F.NRMATRIC , NMFUNC
FROM FUNCIONARIOS F, Trabalha_em T
WHERE F.NrMatric = T.NrMatric)

SELECT NrMatric,NmFunc 
FROM FUNCIONARIOS
WHERE NRMATRIC NOT IN (SELECT F.NRMATRIC , NMFUNC
						FROM FUNCIONARIOS F, Trabalha_em T
							WHERE F.NrMatric = T.NrMatric)







(SELECT NMFUNC FROM FUNCIONARIOS)

(SELECT NMFUNC FROM Trabalha_em)




CREATE TABLE Deptos
	(CdDepto CHAR(03)	PRIMARY KEY, 
	 NmDepto VARCHAR(50)	NOT NULL, 
	 Ramal NUMERIC(6));

	INSERT INTO Deptos VALUES ('D01', 'ADMINISTRATIVO', 100);
	INSERT INTO Deptos VALUES ('D02', 'COMERCIAL', 120);
	INSERT INTO Deptos VALUES ('D03', 'INFORMATICA', 130);

	SELECT * FROM Deptos


CREATE TABLE Cargos
	(CdCargo CHAR(05)	PRIMARY KEY, 
	 NmCargo VARCHAR(50)	NOT NULL, 
	 VrSalario NUMERIC(6,2)	CHECK(VrSalario>0));

	INSERT INTO Cargos VALUES ('C10', 'GERENTE', 8500);
	INSERT INTO Cargos VALUES ('C11', 'DIRETOR DE VENDAS', 7000);
	INSERT INTO Cargos VALUES ('C12', 'ANALISTA DE SISTEMAS', 5250);

	SELECT * FROM Cargos


CREATE TABLE Funcionarios(
	NrMatric INT	PRIMARY KEY IDENTITY, 
	NmFunc VARCHAR(50)	NOT NULL, 
	Sobrenome VARCHAR(100)	NOT NULL,
	Sexo CHAR(01)	CHECK(Sexo IN ('F', 'M')), 
	DtAdm DATETIME, 
	CdDepto CHAR(03)	NOT NULL REFERENCES Deptos, 
	CdCargo CHAR(05)	REFERENCES Cargos, 
	UNIQUE (NmFunc, Sobrenome)
);

	ALTER TABLE Funcionarios ADD Telefone VARCHAR(20)	NULL; 
	ALTER TABLE Funcionarios ALTER COLUMN Telefone VARCHAR(25)	NULL;
	ALTER TABLE Funcionarios DROP COLUMN Telefone;

	INSERT INTO Funcionarios VALUES ('JOAO', 'NOGUEIRA', 'M', '05-12-2001', 'D03', 'C12');
	INSERT INTO Funcionarios VALUES ('JOAO', 'SAMPAIO', 'M', '02-10-2003', 'D01', 'C10');
	INSERT INTO Funcionarios VALUES ('MARIA', 'SOARES', 'F', '13-02-2000', 'D02', 'C11');
	INSERT INTO Funcionarios VALUES ('ROBERTO', 'PEREIRA', 'M', '22-05-2009', 'D01', 'C10');
	INSERT INTO Funcionarios VALUES ('RUTE', 'SOUZA', 'F', '30-04-1999', 'D01', 'C10');
	INSERT INTO Funcionarios VALUES ('REGINA', 'SIMOES', 'F', '01-12-2007', 'D03', 'C12');
	INSERT INTO Funcionarios VALUES ('ALVARO', 'SAMPAIO', 'M', '13-11-1998', 'D03', 'C12');

	SELECT * FROM Funcionarios

	UPDATE Cargos SET
		VrSalario = VrSalario * 1.10
		WHERE CdCargo = 'C10';

	UPDATE Funcionarios SET
		CdCargo = 'C10', CdDepto = 'D01'
		WHERE NrMatric = 1;

		-- Mostrar os dados de todos os funcionários cadastrados
		SELECT * FROM Funcionarios 

		--Mostrar o nome, o sobrenome e a data de admissão de mtodos os funcionarios
		SELECT NMFUNC, SOBRENOME DTADM FROM Funcionarios

		--Mostrar oS sobrenome dos funcionarios, sem  Repetição
		SELECT DISTINCT SOBRENOME FROM Funcionarios

		--Mostrar o num. Matricula, o Nome e o Sexo de Todos os Funcionários, ordenando o resultado por nome do funcionario
		SELECT NrMatric, NmFunc, Sexo FROM Funcionarios ORDER BY NmFunc

		--Mostrar o nome e a data de admissao dos funcionarios, por oredem descrescente de data de admissão
		SELECT NMFUNC, Dtadm FROM Funcionarios ORDER BY DtAdm DESC

		--Mostrar o nome, o sobrenome e o sexode todos os funcionarios, oredenando o resultado por nome e sobrenome
		SELECT NMFUNC, SOBRENOME, SEXO FROM Funcionarios ORDER BY NmFunc, Sobrenome

		--Mostrar todos os funcionarios que pertencem ao depto de cod.D02
		SELECT  * FROM Funcionarios
		WHERE CdDepto = 'D02'

		--Mostrar o nome dos cargos cujo valor do salario é maior ou igual a r$ 6000,00
		SELECT NMCARGO FROM Cargos
		WHERE VrSalario >= 6000

		--Mostrar o nome dos cargos, o valor de salario cadastrado e o valor do salario com 5% de acrescimo
		SELECT NMCARGO, VRSALARIO, VRSALARIO *1.05 AS VR_SAL_COM_ACESCIMO FROM Cargos

		--Mostrar o Num. Matricula dos funcionarios que possuem cargo diferente de c10
		SELECT NRMATRIC FROM Funcionarios
		WHERE CdCargo <> 'C10' 

		--Mostrar todos os funcionarios que possuem sobrenome 'Nogueira' ou 'Sampaio'
		SELECT * FROM Funcionarios
		WHERE Sobrenome ='Nogueira' OR Sobrenome = 'Sampaio'

		SELECT * FROM Funcionarios
		WHERE Sobrenome IN  ('Nogueira', 'Sampaio')

		--Mostrar o nome e a data de admissão dos funcionarios admitidos entre 2000 e 2001
		SELECT NMFUNC, DTADM FROM Funcionarios
		WHERE DtAdm >= '01-01-2000' AND DtAdm <= '31-12-2001'

		SELECT NMFUNC, DTADM FROM Funcionarios
		WHERE DtAdm BETWEEN '01-01-2000' AND '31-12-2001' 

		--MOSTRAR TODOS OS FUNCIONARIOS CUJO NOME COMEÇA COM A LETRA 'R'
		SELECT * FROM Funcionarios
		WHERE NmFunc LIKE 'R%' 
		
		-- MOOSTRAR O NOME, O SOBRENOME, A DATA DE ADMISSÃO E O COD. DEPTO DE TODOS OS FUNCIONARIOS DO SEXO FEMININO,
		--QUE POSSUEM SOBRENOME SOUZA OU CARGO IGUAL A C10 E QUE FORAM ADMITIDOS NO ANO DE 2009
		SELECT NMFUNC, SOBRENOME, DTADM, CDDEPTO
		FROM Funcionarios
		WHERE Sexo = 'F'
		AND(SOBRENOME='SOUZA' OR CdCargo = 'C10')
		AND DtAdm BETWEEN '01-01-2009' AND '31-12-2009'
		SELECT * FROM Funcionarios

		--MOSTRAR O NOME DOS FUNCIONÁRIOS QUE POSSUEM CARGO ANALISTA DE SISTEMAS
		SELECT NMFUNC
		FROM Funcionarios F, Cargos C
		WHERE F.CdCargo = C.CdCargo
		AND NmCargo = 'ANALISTA DE SISTEMAS'

		--MOSTRAR O NOME, A DATA DE ADMISSÃO E O VALOR DO SALÁRIO DE TODOS OS FUNCONÁRIOS
		SELECT NMFUNC, DTADM, VRSALARIO
		FROM Funcionarios F, Cargos C
		WHERE F.CdCargo = C.CdCargo

		--MOSTRAR O NUM. MATRÍCULA, O COD. DEPTO, O NOME E O SOBRENOME DE TODOS OS FUNCIONÁRIOS QUE
		--PERTENCEM AO DEPTO COMERCIAL
		SELECT NRMATRIC, F.CdDepto, NMFUNC, SOBRENOME
		FROM Funcionarios F, Deptos D
		WHERE F.CdDepto = D.CdDepto
		AND NmDepto = 'COMERCIAL'

		--MOSTRAR O NOME DOS FUNCIONÁRIOS QUE SÃO GERENTES E FORAM ADMITIDOS ANTES DE 2002.
		SELECT NMFUNC
		FROM Funcionarios F, Cargos C
		WHERE F.CdCargo = C.CdCargo
		AND NmCargo = 'GERENTE'
		AND DtAdm < '01-01-2002'

		--MOSTRAR O NUM. MATRÍCULA, O NOME E O SOBRENOME DOS FUNCIONÁRIOS DO SEXO MASCULINO, QUE SÃO
		--ANALISTAS DE SISTEMAS E PERTENCEM AO DEPTO INFORMÁTICA. MOSTRAR O RESULTADO POR ORDEM DECRESCENTE DE NOME.
		SELECT NRMATRIC, NMFUNC, SOBRENOME
		FROM Cargos C, Funcionarios F, Deptos D
		WHERE C.CdCargo = F.CdCargo
		AND F.CdDepto = D.CdDepto
		AND SEXO = 'M'
		AND NmCargo = 'ANALISTA DE SISTEMAS'
		AND NmDepto = 'INFORMATICA'
		ORDER BY NmFunc DESC

		-- ************************
		ALTER TABLE funcionarios
		ADD Vrsalario money

		update Funcionarios
		SET VrSalario = (select VrSalario from Cargos where Funcionarios.CdCargo = Cargos.CdCargo)
		WHERE CdCargo = CdCargo
		-- ************************

		-- mostrar quantos funcionários existem cadastrados
		SELECT COUNT (*)
		FROM Funcionarios

		-- MOSTRAR O VALOR MÍNIMO DOS SALÁRIOS CADASTRADOS PARA OS DIFERENTES CARGOS DA EMPRESA
		SELECT MIN (VRSALARIO)
		FROM Cargos

		--MOSTRAR O VALOR MÍNIMO DOS SALÁRIOS DOS FUNCIONÁRIOS, AGRUPADOS POR CÓD. DO DEPARTAMENTO
		SELECT CDDEPTO, MAX (VRSALARIO)
		FROM Funcionarios
		GROUP BY CdDepto

		-- MOSTRAR QUANTOS FUNCIONÁRIOS EXIXTEM EM CADA DEPARTAMENTO, EXIBIR O NOME DO DEPARTAMENTO E A QUANTIDADE
		SELECT NMDEPTO, COUNT (*)
		FROM Deptos D, Funcionarios F
		WHERE D.CdDepto = F.CdDepto
		GROUP BY NmDepto

		-- MOSTRAR QUANTOS FUNCIONÁRIOS EXIXTEM EM CADA DEPARTAMENTO, EXIBIR O CÓD., O NOME DO DEPARTAMENTO E A 
		-- QUANTIDADE SOMENTE DOS DEPARTAMENTOD QUE POSSUEM MAIS DE 2 FUNCIONÁRIOS
		SELECT D. CDDEPTO, NMDEPTO, COUNT (*)
		FROM Deptos D, Funcionarios F
		WHERE D.CdDepto = F.CdDepto
		GROUP BY D.CdDepto, NmDepto
		HAVING COUNT (*) > 2

		-- MOSTRAR A SOMA TOTAL DO VALOR DOS SALÁRIOS DOS FUNCIONÁRIOS DO SEXO MASCULINO QUE OCUPAM CADA CARGO DA EMPRESA
		SELECT CDCARGO, SUM (VRSALARIO)
		FROM Funcionarios
		WHERE Sexo = 'M'
		GROUP BY CdCargo

		-- MOSTRAR QUANTOS FUNCIONÁRIOS DO SEXO MASCULINO OCUPAM CADA CARGO DA EMPRESA. EXIBIR SOMENTE O NOME DOS CARGOS 
		-- CUJO VALOR TOTAL DOS SALÁRIOS SEJA MAIOR QUE 11000
		SELECT NMCARGO, COUNT (*) 
		FROM Cargos C, Funcionarios F
		WHERE C.CdCargo = F.CdCargo
		AND Sexo = 'M'
		GROUP BY NmCargo
		HAVING SUM (F.VRSALARIO) > 11000