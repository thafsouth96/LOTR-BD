	-- TP Noté M3106C Seigneur des Anneaux


BEGIN;

-- Schéma de la base de données

CREATE TABLE RPERS (
   nomPers TEXT NOT NULL PRIMARY KEY,
   nomType TEXT,
   AnNais SMALLINT
   );

CREATE TABLE RTYPE (
   nomType TEXT NOT NULL PRIMARY KEY,
   tailleMoy FLOAT,
   imberbe BOOLEAN
   /*FOREIGN KEY (nomType) REFERENCES RPERS(nomType)*/
   );

 CREATE TABLE RCHAP (
   numChap SMALLINT NOT NULL,
   numLivre TEXT NOT NULL,
   titre TEXT,
   PRIMARY KEY (numChap, numLivre)
   );

 CREATE TABLE RCAR (
   nomPers TEXT NOT NULL REFERENCES RPERS(nomPers) ON DELETE CASCADE,
   numChap SMALLINT NOT NULL,
   numLivre TEXT NOT NULL,
   traitCar TEXT NOT NULL,
   coefCar FLOAT constraint coef_constraint check(coefCar between 0 and 1),
   FOREIGN KEY (numChap, numLivre) REFERENCES RCHAP(numChap, numLivre) ON DELETE CASCADE,
   PRIMARY KEY (nomPers, numChap, numLivre, traitCar)
   );

-- Insertions
INSERT INTO RPERS VALUES ('Frodon', 'hobbit', 2968);
INSERT INTO RPERS VALUES ('Gimli', 'nain', 2879);
INSERT INTO RPERS VALUES ('Gandalf', 'Istar', 314);
INSERT INTO RPERS VALUES ('Elrond', 'Elfe', 317);
INSERT INTO RPERS VALUES ('Galadriel', 'Elfe', 323);
INSERT INTO RPERS VALUES ('Legolas', 'Elfe', 323);
INSERT INTO RPERS VALUES ('Aragorn II', 'humain', 2931);
INSERT INTO RPERS VALUES ('Eorl', 'humain', 2485);
INSERT INTO RPERS VALUES ('Boromir', 'humain', 2978);
INSERT INTO RPERS VALUES ('Sméagol', 'hobbit', 2440);
INSERT INTO RPERS VALUES ('Fléau de Durin', 'balrog', 112);


INSERT INTO RTYPE VALUES ('hobbit', 90, 'no');
INSERT INTO RTYPE VALUES ('nain', 200, 'no');
INSERT INTO RTYPE VALUES ('Istar', 150, 'no');
INSERT INTO RTYPE VALUES ('Elfe', 100, 'yes');
INSERT INTO RTYPE VALUES ('humain', 222, 'no');
INSERT INTO RTYPE VALUES ('balrog', 9000, 'yes');


INSERT INTO RCHAP VALUES (12, 1, 'Fuite vers le gué');
INSERT INTO RCHAP VALUES (1, 1, 'Une réception depuis longtemps attendue');
INSERT INTO RCHAP VALUES ( 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO RCHAP VALUES (22, 1, 'La dissolution de la Communauté');
INSERT INTO RCHAP VALUES (12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO RCHAP VALUES (14, 2, 'La Porte Noire est fermée');
INSERT INTO RCHAP VALUES (20, 2, 'L’antre d’Arachne');
INSERT INTO RCHAP VALUES (4, 3, 'Le siège de Gondor');
INSERT INTO RCHAP VALUES (10, 3, 'La Porte Noire s’ouvre');
INSERT INTO RCHAP VALUES (13, 3, 'La Montagne du Destin');


INSERT INTO RCAR VALUES ('Frodon',12,1,'courageux',0.95);
INSERT INTO RCAR VALUES ('Frodon',1,1,'joyeux', 0.8);
INSERT INTO RCAR VALUES ('Frodon',1,1,'impatient',0.7);
INSERT INTO RCAR VALUES ('Frodon',17,1,'triste',0.5);
INSERT INTO RCAR VALUES ('Frodon',17,1,'peureux',0.6);
INSERT INTO RCAR VALUES ('Frodon',22,1,'triste',0.85);
INSERT INTO RCAR VALUES ('Frodon',12,2,'sagace',0.75);
INSERT INTO RCAR VALUES ('Frodon',14,2,'découragé',0.55);
INSERT INTO RCAR VALUES ('Frodon',20,2,'effrayé',0.65);
INSERT INTO RCAR VALUES ('Frodon',4,3,'impatient',0.45);
INSERT INTO RCAR VALUES ('Frodon',10,3,'souffrant',0.95);
INSERT INTO RCAR VALUES ('Frodon',13,3,'agonisant',0.85);
INSERT INTO RCAR VALUES ('Gimli',22,1,'impétueux',0.99);
INSERT INTO RCAR VALUES ('Gimli',17,1,'courageux',0.97);
INSERT INTO RCAR VALUES ('Gimli',4,3,'téméraire',0.96);
INSERT INTO RCAR VALUES ('Gandalf',12,1,'perspicace',0.80);
INSERT INTO RCAR VALUES ('Gandalf', 17, 1,'téméraire',0.80);
INSERT INTO RCAR VALUES ('Gandalf',4,3,'courageux',0.80);
INSERT INTO RCAR VALUES ('Elrond',22,1,'sage',0.80);
INSERT INTO RCAR VALUES ('Elrond',12, 2,'paisible',0.80);
INSERT INTO RCAR VALUES ('Galadriel',12,2,'paisible',0.75);
INSERT INTO RCAR VALUES ('Legolas',12,2,'paisible',0.78);
INSERT INTO RCAR VALUES ('Legolas',4,3,'enthousiaste',0.78);
INSERT INTO RCAR VALUES ('Aragorn II',22,1,'courageux',0.93);
INSERT INTO RCAR VALUES ('Aragorn II', 4,3,'angoissé', 0.93);
INSERT INTO RCAR VALUES ('Eorl',12,2,'fier', 0.93);
INSERT INTO RCAR VALUES ('Boromir',22,1,'fou', 0.93);
INSERT INTO RCAR VALUES ('Sméagol',13,3,'maladroit',0.5);
INSERT INTO RCAR VALUES ('Fléau de Durin',17,1,'peureux', 0.5);


COMMIT;
