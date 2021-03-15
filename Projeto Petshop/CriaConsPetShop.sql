CREATE TABLE DONO(
	CODIGO_DONO    CHAR(5) PRIMARY KEY,
	NOME_DONO      VARCHAR(50) NOT NULL,
	ENDERECO_DONO  VARCHAR(100),
	TELEFONE       VARCHAR(20) NOT NULL
);

CREATE TABLE ANIMAL(
	CODIGO_ANIMAL   CHAR(5) PRIMARY KEY,
	NOME_ANIMAL     VARCHAR(50) NOT NULL,
	DATA_NASCIMENTO DATETIME,
	PESO            NUMERIC(7,2),
	CODIGO_DONO     CHAR(5) REFERENCES DONO,
	CODIGO_RACA     CHAR(5) REFERENCES RACA
);

CREATE TABLE RACA(
	CODIGO_RACA    CHAR(5) PRIMARY KEY,
	DESCRICAO_RACA VARCHAR(50) NOT NULL,
	PAIS_RACA      VARCHAR(50)
);

CREATE TABLE SERVICO(
	CODIGO_SERVICO    CHAR(6) PRIMARY KEY,
	DESCRICAO_SERVICO VARCHAR(20) CHECK (DESCRICAO_SERVICO IN ('CL�NICA VETERIN�RIA','BANHO/TOSA','EST�TICA ANIMAL', 'VACINA��O', 'RA��ES', 'TAXI DOG')),
	VALUNIT_SERVICO   MONEY
);

CREATE TABLE MEDICAMENTO(
	CODIGO_MEDICAMENTO    CHAR(13) PRIMARY KEY,
	DESCRICAO_MEDICAMENTO VARCHAR(30) NOT NULL
);

CREATE TABLE VETERINARIO(
	CODIGO_VETERINARIO CHAR(5) PRIMARY KEY,
	NOME_VETERINARIO   VARCHAR(50) NOT NULL
);

CREATE TABLE ANIMAL_SERVICO(
	CODIGO_ANIMAL  CHAR(5) REFERENCES ANIMAL,
	CODIGO_SERVICO CHAR(6) REFERENCES SERVICO,
	DATA_SERVICO   DATETIME NOT NULL,

	PRIMARY KEY(CODIGO_ANIMAL,CODIGO_SERVICO)
);

CREATE TABLE ANIMAL_MEDICAMENTO(
	CODIGO_ANIMAL      CHAR(5)  REFERENCES ANIMAL,
	CODIGO_MEDICAMENTO CHAR(13) REFERENCES MEDICAMENTO,
	CODIGO_VETERINARIO CHAR(5)  REFERENCES VETERINARIO, 
	DATA_MEDICAMENTO   DATETIME NOT NULL,

	PRIMARY KEY(CODIGO_ANIMAL, CODIGO_MEDICAMENTO)
);