INSERT INTO RACA VALUES ('RC001','LABRADOR','CANAD�');
INSERT INTO RACA VALUES ('RC002','PASTOR ALEM�O','ALEMANHA');
INSERT INTO RACA VALUES ('RC003','BULDOGUE','INGLATERRA');
INSERT INTO RACA VALUES ('RC004','GOLDEN RETRIVER','INGLATERRA');
INSERT INTO RACA VALUES ('RC005','YORKSHIRE TERRIER','INGLATERRA');
INSERT INTO RACA VALUES ('RC006','HUSKY SIBERIANO','SIB�RIA');
INSERT INTO RACA VALUES ('RC007','BEAGLE','INGLATERRA');
INSERT INTO RACA VALUES ('RC008','POODLE','FRAN�A');
INSERT INTO RACA VALUES ('RC009','BOXER','ALEMANHA');
INSERT INTO RACA VALUES ('RC010','PUG','CHINA');
INSERT INTO RACA VALUES ('RC011','MALT�S','CHINA');

INSERT INTO VETERINARIO VALUES ('VE001','DANILO');
INSERT INTO VETERINARIO VALUES ('VE002','IRIS');
INSERT INTO VETERINARIO VALUES ('VE003','EMMA');
INSERT INTO VETERINARIO VALUES ('VE004','LAIS');
INSERT INTO VETERINARIO VALUES ('VE005','MARTA');
INSERT INTO VETERINARIO VALUES ('VE006','MARCOS');
INSERT INTO VETERINARIO VALUES ('VE007','LARA');
INSERT INTO VETERINARIO VALUES ('VE008','CARLOS');
INSERT INTO VETERINARIO VALUES ('VE009','LUIS');
INSERT INTO VETERINARIO VALUES ('VE010','GUILHERME');

INSERT INTO SERVICO VALUES ('SE001','CL�NICA VETERIN�RIA',45.00);
INSERT INTO SERVICO VALUES ('SE002','BANHO/TOSA',25.00);
INSERT INTO SERVICO VALUES ('SE003','EST�TICA ANIMAL',27.50);
INSERT INTO SERVICO VALUES ('SE004','VACINA��O',12.10);
INSERT INTO SERVICO VALUES ('SE005','RA��ES',3.00);
INSERT INTO SERVICO VALUES ('SE006','TAXI DOG',5.00);

INSERT INTO DONO VALUES ('DO001','LAURA RIBEIRO','AL. FLORES, 77','(16)65457-5173');
INSERT INTO DONO VALUES ('DO002','LUIZ','R. PEREIRA, 17','(15)95524-1236');
INSERT INTO DONO VALUES ('DO003','JULIA CAMPOS','R. TIETE, 5','(11)1235-9853');
INSERT INTO DONO VALUES ('DO004','ALEX REIS','R.  BEZERRA, 17','(84)1236-6548');
INSERT INTO DONO VALUES ('DO005','MIGUEL DE COSTA','R. ESMERALDA GODOI, 15','(16)3218-9874');
INSERT INTO DONO VALUES ('DO006','EMILY DIAS','R. GARCIA, 18','(23)5358-0158');
INSERT INTO DONO VALUES ('DO007','GABRIEL DE GOMES','R. VICENTE LOPES, 311','(67)5854-9290');
INSERT INTO DONO VALUES ('DO008','CLARA ARAUJO','R. JO�O, 13','(62)6968-9206');
INSERT INTO DONO VALUES ('DO009','LAIS SOUZA','R. GUSTAVO, 17','(79)8228-3598');
INSERT INTO DONO VALUES ('DO010','LEILA PINTO','R. CAIVA, 19','(11)7971-8040');
INSERT INTO DONO VALUES ('DO011','ENZO DE OLIVEIRA','R. AQUILINO LIMONGI, 213','(11)2715-2883');

INSERT INTO MEDICAMENTO VALUES ('ME001','ANTI-INFLAMAT�RIO');
INSERT INTO MEDICAMENTO VALUES ('ME002','VITAMINAS');
INSERT INTO MEDICAMENTO VALUES ('ME003','ANTI-PULGAS');
INSERT INTO MEDICAMENTO VALUES ('ME004','ANTI-MICROBIANO');
INSERT INTO MEDICAMENTO VALUES ('ME005','VERM�FUGA');
INSERT INTO MEDICAMENTO VALUES ('ME006','ANTIBI�TICO');
INSERT INTO MEDICAMENTO VALUES ('ME007','SUPLEMENTO');
INSERT INTO MEDICAMENTO VALUES ('ME008','VACINA');
INSERT INTO MEDICAMENTO VALUES ('ME009','ANTI-AL�RGICO');
INSERT INTO MEDICAMENTO VALUES ('ME010','ANALG�SICO');

INSERT INTO ANIMAL VALUES ('AN001','BOB','2009-06-01',20.02,'DO001','RC001');
INSERT INTO ANIMAL VALUES ('AN002','CALVIN','2010-04-05',21.04,'DO002','RC002');
INSERT INTO ANIMAL VALUES ('AN003','FOX','2011-15-01',11.50,'DO003','RC003');
INSERT INTO ANIMAL VALUES ('AN004','THOR','2012-12-12',25.00,'DO004','RC004');
INSERT INTO ANIMAL VALUES ('AN005','TOBY','2014-10-02',4.20,'DO005','RC005');
INSERT INTO ANIMAL VALUES ('AN006','PANDORA','2013-29-04',21.20,'DO006','RC006');
INSERT INTO ANIMAL VALUES ('AN007','NEMO','2004-27-01',10.30,'DO007','RC007');
INSERT INTO ANIMAL VALUES ('AN008','LUKE','2009-08-04',5.03,'DO008','RC008');
INSERT INTO ANIMAL VALUES ('AN009','MAX','2014-17-02',29.02,'DO009','RC009');
INSERT INTO ANIMAL VALUES ('AN010','ATENA','2015-31-10',5.02,'DO010','RC010');
INSERT INTO ANIMAL VALUES ('AN011','LISA','2014-31-10',7.02,'DO011','RC011');

INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN001','ME001','VE001',GETDATE(),2);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN002','ME002','VE002',GETDATE(),2);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN003','ME003','VE003',GETDATE(),3);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN004','ME004','VE004',GETDATE(),1);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN005','ME005','VE005',GETDATE(),4);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN006','ME006','VE006',GETDATE(),1);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN007','ME007','VE007',GETDATE(),1);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN008','ME008','VE008',GETDATE(),2);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN009','ME009','VE009',GETDATE(),2);
INSERT INTO ANIMAL_MEDICAMENTO VALUES ('AN010','ME010','VE010',GETDATE(),1);

INSERT INTO ANIMAL_SERVICO VALUES ('AN001','SE001',GETDATE(),2);
INSERT INTO ANIMAL_SERVICO VALUES ('AN002','SE002',GETDATE(),1);
INSERT INTO ANIMAL_SERVICO VALUES ('AN003','SE003',GETDATE(),1);
INSERT INTO ANIMAL_SERVICO VALUES ('AN004','SE004',GETDATE(),2);
INSERT INTO ANIMAL_SERVICO VALUES ('AN005','SE005',GETDATE(),1);
INSERT INTO ANIMAL_SERVICO VALUES ('AN006','SE006',GETDATE(),2);
INSERT INTO ANIMAL_SERVICO VALUES ('AN007','SE001',GETDATE(),1);
INSERT INTO ANIMAL_SERVICO VALUES ('AN008','SE002',GETDATE(),1);
INSERT INTO ANIMAL_SERVICO VALUES ('AN009','SE003',GETDATE(),2);
INSERT INTO ANIMAL_SERVICO VALUES ('AN010','SE004',GETDATE(),4);



