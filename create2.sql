	-- TP Noté M3106C Seigneur des Anneaux


BEGIN;

-- Schéma de la base de données

CREATE TABLE RPERS (
   nomPers TEXT NOT NULL PRIMARY KEY,
   nomType TEXT,
   AnNais SMALLINT
   );
   
CREATE TABLE RTYPE (
   nomType TEXT PRIMARY KEY REFERENCES RPERS(nomType),
   tailleMoy FLOAT,
   imberbe BOOLEAN
   );
   
 CREATE TABLE RCHAP (
   numChap SMALLINT NOT NULL,
   numLivre TEXT NOT NULL,
   titre TEXT,
   PRIMARY KEY (numChap, numLivre)
   );
   
 CREATE TABLE RCAR (
   nomPers TEXT NOT NULL REFERENCES RPERS(nomPers),
   numChap SMALLINT NOT NULL,
   numLivre TEXT NOT NULL,
   traitCar TEXT NOT NULL,
   coefCar FLOAT constraint coef_constraint check(coefCar between 0 and 1),
   FOREIGN KEY (numChap, numLivre) REFERENCES RCHAP(numChap, numLivre),
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

INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'courageux', 0.95, 12, 1, 'Fuite vers le gué');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'joyeux', 0.8, 1, 1, 'Une réception depuis longtemps attendue');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'impatient', 0.7, 1, 1, 'Une réception depuis longtemps attendue');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'triste', 0.5, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'peureux', 0.6, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'triste', 0.85, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'sagace', 0.75, 12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'découragé', 0.55, 14, 2, 'La Porte Noire est fermée');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'effrayé', 0.65, 20, 2, 'L’antre d’Arachne');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'impatient', 0.45, 4, 3, 'Le siège de Gondor');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'souffrant', 0.95, 10, 3, 'La Porte Noire s’ouvre');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'agonisant', 0.85, 13, 3, 'La Montagne du Destin');

INSERT INTO PERSONNAGES VALUES ('Gimli', 'nain', 2879, 200, 'no', 'impétueux', 0.99, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Gimli', 'nain', 2879, 200, 'no', 'courageux', 0.97, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Gimli', 'nain', 2879, 200, 'no', 'téméraire', 0.96, 4, 3, 'Le siège de Gondor');

INSERT INTO PERSONNAGES VALUES ('Gandalf', 'Istar', 314, 150, 'no', 'perspicace', 0.80, 12, 1, 'Fuite vers le gué');
INSERT INTO PERSONNAGES VALUES ('Gandalf', 'Istar', 314, 150, 'no', 'téméraire', 0.80, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Gandalf', 'Istar', 314, 150, 'no', 'courageux', 0.80, 4, 3, 'Le siège de Gondor');

INSERT INTO PERSONNAGES VALUES ('Elrond', 'Elfe', 317, 100, 'yes', 'sage', 0.80, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Elrond', 'Elfe', 317, 100, 'yes', 'paisible', 0.80, 12, 2, 'L’apprivoisement de Sméagol');

INSERT INTO PERSONNAGES VALUES ('Galadriel', 'Elfe', 323, 95, 'yes', 'paisible', 0.75, 12, 2, 'L’apprivoisement de Sméagol');

INSERT INTO PERSONNAGES VALUES ('Legolas', 'Elfe', 323, 110, 'yes', 'paisible', 0.78, 12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO PERSONNAGES VALUES ('Legolas', 'Elfe', 323, 110, 'yes', 'enthousiaste', 0.78, 4, 3, 'Le siège de Gondor');

INSERT INTO PERSONNAGES VALUES ('Aragorn II', 'humain', 2931, 222, 'no', 'courageux', 0.93, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Aragorn II', 'humain', 2931, 222, 'no', 'angoissé', 0.93, 4, 3, 'Le siège de Gondor');
INSERT INTO PERSONNAGES VALUES ('Eorl', 'humain', 2485, 212, 'no', 'fier', 0.93, 12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO PERSONNAGES VALUES ('Boromir', 'humain', 2978, 200, 'no', 'fou', 0.93, 22, 1, 'La dissolution de la Communauté');

INSERT INTO PERSONNAGES VALUES ('Sméagol', 'hobbit', 2440, 45, 'no', 'maladroit', 0.5, 13, 3, 'La Montagne du Destin');
INSERT INTO PERSONNAGES VALUES ('Fléau de Durin', 'balrog', 112, 9000, 'yes', 'peureux', 0.5, 17, 1, 'Le Pont de Khazad-Dum');






INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'courageux', 0.95, 12, 1, 'Fuite vers le gué');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'joyeux', 0.8, 1, 1, 'Une réception depuis longtemps attendue');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'impatient', 0.7, 1, 1, 'Une réception depuis longtemps attendue');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'triste', 0.5, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'peureux', 0.6, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'triste', 0.85, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'sagace', 0.75, 12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'découragé', 0.55, 14, 2, 'La Porte Noire est fermée');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'effrayé', 0.65, 20, 2, 'L’antre d’Arachne');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'impatient', 0.45, 4, 3, 'Le siège de Gondor');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'souffrant', 0.95, 10, 3, 'La Porte Noire s’ouvre');
INSERT INTO PERSONNAGES VALUES ('Frodon', 'hobbit', 2968, 90, 'no', 'agonisant', 0.85, 13, 3, 'La Montagne du Destin');

INSERT INTO PERSONNAGES VALUES ('Gimli', 'nain', 2879, 200, 'no', 'impétueux', 0.99, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Gimli', 'nain', 2879, 200, 'no', 'courageux', 0.97, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Gimli', 'nain', 2879, 200, 'no', 'téméraire', 0.96, 4, 3, 'Le siège de Gondor');

INSERT INTO PERSONNAGES VALUES ('Gandalf', 'Istar', 314, 150, 'no', 'perspicace', 0.80, 12, 1, 'Fuite vers le gué');
INSERT INTO PERSONNAGES VALUES ('Gandalf', 'Istar', 314, 150, 'no', 'téméraire', 0.80, 17, 1, 'Le Pont de Khazad-Dum');
INSERT INTO PERSONNAGES VALUES ('Gandalf', 'Istar', 314, 150, 'no', 'courageux', 0.80, 4, 3, 'Le siège de Gondor');

INSERT INTO PERSONNAGES VALUES ('Elrond', 'Elfe', 317, 100, 'yes', 'sage', 0.80, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Elrond', 'Elfe', 317, 100, 'yes', 'paisible', 0.80, 12, 2, 'L’apprivoisement de Sméagol');

INSERT INTO PERSONNAGES VALUES ('Galadriel', 'Elfe', 323, 95, 'yes', 'paisible', 0.75, 12, 2, 'L’apprivoisement de Sméagol');

INSERT INTO PERSONNAGES VALUES ('Legolas', 'Elfe', 323, 110, 'yes', 'paisible', 0.78, 12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO PERSONNAGES VALUES ('Legolas', 'Elfe', 323, 110, 'yes', 'enthousiaste', 0.78, 4, 3, 'Le siège de Gondor');

INSERT INTO PERSONNAGES VALUES ('Aragorn II', 'humain', 2931, 222, 'no', 'courageux', 0.93, 22, 1, 'La dissolution de la Communauté');
INSERT INTO PERSONNAGES VALUES ('Aragorn II', 'humain', 2931, 222, 'no', 'angoissé', 0.93, 4, 3, 'Le siège de Gondor');
INSERT INTO PERSONNAGES VALUES ('Eorl', 'humain', 2485, 212, 'no', 'fier', 0.93, 12, 2, 'L’apprivoisement de Sméagol');
INSERT INTO PERSONNAGES VALUES ('Boromir', 'humain', 2978, 200, 'no', 'fou', 0.93, 22, 1, 'La dissolution de la Communauté');

INSERT INTO PERSONNAGES VALUES ('Sméagol', 'hobbit', 2440, 45, 'no', 'maladroit', 0.5, 13, 3, 'La Montagne du Destin');
INSERT INTO PERSONNAGES VALUES ('Fléau de Durin', 'balrog', 112, 9000, 'yes', 'peureux', 0.5, 17, 1, 'Le Pont de Khazad-Dum');



COMMIT;
