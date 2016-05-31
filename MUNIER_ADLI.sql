-- Partie 2 : Optimisation

-- Question 3 :

-- R1 : Nom, type et taille de tous les personnages.

--a)
EXPLAIN SELECT DISTINCT nomPers, nomType, tailleMoy
        FROM            PERSONNAGES;
/*
QUERY PLAN
---------------------------------------------------------------------
HashAggregate  (cost=16.65..18.65 rows=200 width=72)
Group Key: nompers, nomtype, taillemoy
->  Seq Scan on personnages  (cost=0.00..13.80 rows=380 width=72)
(3 rows)
*/

--b)
EXPLAIN SELECT  nomPers, t.nomType, tailleMoy
        FROM    RPERS p, RTYPE t
        WHERE   p.nomType=t.nomType;
/*
QUERY PLAN
------------------------------------------------------------------------
Hash Join  (cost=35.88..66.06 rows=850 width=72)
Hash Cond: (p.nomtype = t.nomtype)
->  Seq Scan on rpers p  (cost=0.00..18.50 rows=850 width=64)
->  Hash  (cost=21.50..21.50 rows=1150 width=40)
->  Seq Scan on rtype t  (cost=0.00..21.50 rows=1150 width=40)
(5 rows)
*/


-- R2 : Titre et numLivre des chapitres dans lesquels joue Gimli.

--a)
EXPLAIN
SELECT DISTINCT titre, numLivre
FROM            PERSONNAGES
WHERE           nomPers = 'Gimli';
/*
QUERY PLAN
-------------------------------------------------------------------------------------------
Unique  (cost=9.51..9.53 rows=2 width=64)
->  Sort  (cost=9.51..9.52 rows=2 width=64)
Sort Key: titre, numlivre
->  Bitmap Heap Scan on personnages  (cost=4.16..9.50 rows=2 width=64)
Recheck Cond: (nompers = 'Gimli'::text)
->  Bitmap Index Scan on personnages_pkey  (cost=0.00..4.16 rows=2 width=0)
Index Cond: (nompers = 'Gimli'::text)
(7 rows)
*/

--b)
EXPLAIN
Select  titre, ca.numLivre
From    Rchap ch, Rcar ca
Where   (ca.numchap,ca.numLivre) = (ch.numchap, ch.numLivre)
AND     nomPers = 'Gimli';
/*
QUERY PLAN
----------------------------------------------------------------------------------
Nested Loop  (cost=4.32..31.84 rows=1 width=64)
->  Bitmap Heap Scan on rcar ca  (cost=4.17..11.28 rows=3 width=34)
Recheck Cond: (nompers = 'Gimli'::text)
->  Bitmap Index Scan on rcar_pkey  (cost=0.00..4.17 rows=3 width=0)
Index Cond: (nompers = 'Gimli'::text)
->  Index Scan using rchap_pkey on rchap ch  (cost=0.15..6.84 rows=1 width=66)
Index Cond: ((numchap = ca.numchap) AND (numlivre = ca.numlivre))
(7 rows)
*/


-- R3 : Nom, type, et taille des personnages qui jouent dans le chapitre 17 du livre 1.

--a)
EXPLAIN
SELECT DISTINCT nomPers, nomType, tailleMoy
FROM            PERSONNAGES
WHERE           numChap = 17 and numLivre = '1';
/*
QUERY PLAN
-------------------------------------------------------------------
HashAggregate  (cost=15.71..15.72 rows=1 width=72)
Group Key: nompers, nomtype, taillemoy
->  Seq Scan on personnages  (cost=0.00..15.70 rows=1 width=72)
Filter: ((numchap = 17) AND (numlivre = '1'::text))
(4 rows)
*/

--b)
EXPLAIN
Select DISTINCT   c.nomPers, p.nomType, tailleMoy
From              RPers p, Rcar c, Rtype t
Where             numChap = 17 and numLivre = '1' AND
                  c.nomPers =  p.nomPers AND
                  p.nomType = t.nomType;
/*
QUERY PLAN
-------------------------------------------------------------------------------------------------
HashAggregate  (cost=26.59..26.60 rows=1 width=72)
Group Key: c.nompers, p.nomtype, t.taillemoy
->  Nested Loop  (cost=0.45..26.58 rows=1 width=72)
->  Nested Loop  (cost=0.30..26.34 rows=1 width=64)
->  Index Only Scan using rcar_pkey on rcar c  (cost=0.15..18.16 rows=1 width=32)
Index Cond: ((numchap = 17) AND (numlivre = '1'::text))
->  Index Scan using rpers_pkey on rpers p  (cost=0.15..8.17 rows=1 width=64)
Index Cond: (nompers = c.nompers)
->  Index Scan using rtype_pkey on rtype t  (cost=0.15..0.23 rows=1 width=40)
Index Cond: (nomtype = p.nomtype)
(10 rows)
*/


-- R4 : Nom, type, et coefCar des personnages qui sont effrayés.

--a)
EXPLAIN
Select  nomPers, nomType, coefCar
From    Personnages
Where   traitCar = 'effrayé';
/*
QUERY PLAN
-------------------------------------------------------------
Seq Scan on personnages  (cost=0.00..14.75 rows=2 width=72)
Filter: (traitcar = 'effrayé'::text)
(2 rows)
*/

--b)
EXPLAIN
Select  c.nomPers, nomType, coefCar
From    RPers p, Rcar c
Where   traitCar = 'effrayé' AND c.nomPers =  p.nomPers;
/*
QUERY PLAN
---------------------------------------------------------------------------------
Nested Loop  (cost=0.15..38.04 rows=3 width=72)
->  Seq Scan on rcar c  (cost=0.00..17.50 rows=3 width=40)
Filter: (traitcar = 'effrayé'::text)
->  Index Scan using rpers_pkey on rpers p  (cost=0.15..6.84 rows=1 width=64)
Index Cond: (nompers = c.nompers)
(5 rows)
*/


--R5 : Dates de naissance des personnages du livre 2.

--a)
EXPLAIN
Select  anNais
From    Personnages
Where   numLivre = '2' ;
/*
QUERY PLAN
------------------------------------------------------------
Seq Scan on personnages  (cost=0.00..14.75 rows=2 width=2)
Filter: (numlivre = '2'::text)
(2 rows)
*/

--b)
EXPLAIN
Select  anNais
From    RPers p, Rcar c
Where   numLivre = '2'
And     p.nomPers = c.nomPers ;
/*
QUERY PLAN
---------------------------------------------------------------------------------
Nested Loop  (cost=0.15..38.04 rows=3 width=2)
->  Seq Scan on rcar c  (cost=0.00..17.50 rows=3 width=32)
Filter: (numlivre = '2'::text)
->  Index Scan using rpers_pkey on rpers p  (cost=0.15..6.84 rows=1 width=34)
Index Cond: (nompers = c.nompers)
(5 rows)
*/


-- Question 5)

-- Insérez un nouveau personnage dans le livre 2 de la Trilogie (tiré de l’œuvre ou de votre invention)

--a)
EXPLAIN
INSERT INTO PERSONNAGES VALUES ('perso1', 'hobbit', 2675, 90, 'no', 'lâche', 0.82, 12, 2, 'L’apprivoisement de Sméagol');
/*
QUERY PLAN
---------------------------------------------------------
Insert on personnages  (cost=0.00..0.01 rows=1 width=0)
->  Result  (cost=0.00..0.01 rows=1 width=0)
(2 rows)
*/
INSERT INTO PERSONNAGES VALUES ('perso1', 'hobbit', 2675, 90, 'no', 'lâche', 0.82, 12, 2, 'L’apprivoisement de Sméagol');
--INSERT 0 1
/*
nompers     | nomtype | annais | taillemoy | imberbe |   traitcar   | coefcar | numchap | numlivre |                  titre
----------------+---------+--------+-----------+---------+--------------+---------+---------+----------+-----------------------------------------
Frodon         | hobbit  |   2968 |        90 | f       | courageux    |    0.95 |      12 | 1        | Fuite vers le gué
Frodon         | hobbit  |   2968 |        90 | f       | joyeux       |     0.8 |       1 | 1        | Une réception depuis longtemps attendue
Frodon         | hobbit  |   2968 |        90 | f       | impatient    |     0.7 |       1 | 1        | Une réception depuis longtemps attendue
Frodon         | hobbit  |   2968 |        90 | f       | triste       |     0.5 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2968 |        90 | f       | peureux      |     0.6 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2968 |        90 | f       | triste       |    0.85 |      22 | 1        | La dissolution de la Communauté
Frodon         | hobbit  |   2968 |        90 | f       | sagace       |    0.75 |      12 | 2        | L’apprivoisement de Sméagol
Frodon         | hobbit  |   2968 |        90 | f       | découragé    |    0.55 |      14 | 2        | La Porte Noire est fermée
Frodon         | hobbit  |   2968 |        90 | f       | effrayé      |    0.65 |      20 | 2        | L’antre d’Arachne
Frodon         | hobbit  |   2968 |        90 | f       | impatient    |    0.45 |       4 | 3        | Le siège de Gondor
Frodon         | hobbit  |   2968 |        90 | f       | souffrant    |    0.95 |      10 | 3        | La Porte Noire s’ouvre
Frodon         | hobbit  |   2968 |        90 | f       | agonisant    |    0.85 |      13 | 3        | La Montagne du Destin
Gimli          | nain    |   2879 |       200 | f       | impétueux    |    0.99 |      22 | 1        | La dissolution de la Communauté
Gimli          | nain    |   2879 |       200 | f       | courageux    |    0.97 |      17 | 1        | Le Pont de Khazad-Dum
Gimli          | nain    |   2879 |       200 | f       | téméraire    |    0.96 |       4 | 3        | Le siège de Gondor
Gandalf        | Istar   |    314 |       150 | f       | perspicace   |     0.8 |      12 | 1        | Fuite vers le gué
Gandalf        | Istar   |    314 |       150 | f       | téméraire    |     0.8 |      17 | 1        | Le Pont de Khazad-Dum
Gandalf        | Istar   |    314 |       150 | f       | courageux    |     0.8 |       4 | 3        | Le siège de Gondor
Elrond         | Elfe    |    317 |       100 | t       | sage         |     0.8 |      22 | 1        | La dissolution de la Communauté
Elrond         | Elfe    |    317 |       100 | t       | paisible     |     0.8 |      12 | 2        | L’apprivoisement de Sméagol
Galadriel      | Elfe    |    323 |        95 | t       | paisible     |    0.75 |      12 | 2        | L’apprivoisement de Sméagol
Legolas        | Elfe    |    323 |       110 | t       | paisible     |    0.78 |      12 | 2        | L’apprivoisement de Sméagol
Legolas        | Elfe    |    323 |       110 | t       | enthousiaste |    0.78 |       4 | 3        | Le siège de Gondor
Aragorn II     | humain  |   2931 |       222 | f       | courageux    |    0.93 |      22 | 1        | La dissolution de la Communauté
Aragorn II     | humain  |   2931 |       222 | f       | angoissé     |    0.93 |       4 | 3        | Le siège de Gondor
Eorl           | humain  |   2485 |       212 | f       | fier         |    0.93 |      12 | 2        | L’apprivoisement de Sméagol
Boromir        | humain  |   2978 |       200 | f       | fou          |    0.93 |      22 | 1        | La dissolution de la Communauté
Sméagol        | hobbit  |   2440 |        45 | f       | maladroit    |     0.5 |      13 | 3        | La Montagne du Destin
Fléau de Durin | balrog  |    112 |      9000 | t       | peureux      |     0.5 |      17 | 1        | Le Pont de Khazad-Dum
perso1         | hobbit  |   2675 |        90 | f       | lâche        |    0.82 |      12 | 2        | L’apprivoisement de Sméagol
(30 rows)
*/

--b)
EXPLAIN
INSERT INTO RPERS VALUES ('perso1', 'hobbit', 2675);
/*
QUERY PLAN
---------------------------------------------------
Insert on rpers  (cost=0.00..0.01 rows=1 width=0)
->  Result  (cost=0.00..0.01 rows=1 width=0)
(2 rows)
*/
INSERT INTO RPERS VALUES ('perso1', 'hobbit', 2675);
--INSERT 0 1
/*
nompers     | nomtype | annais
----------------+---------+--------
Frodon         | hobbit  |   2968
Gimli          | nain    |   2879
Gandalf        | Istar   |    314
Elrond         | Elfe    |    317
Galadriel      | Elfe    |    323
Legolas        | Elfe    |    323
Aragorn II     | humain  |   2931
Eorl           | humain  |   2485
Boromir        | humain  |   2978
Sméagol        | hobbit  |   2440
Fléau de Durin | balrog  |    112
perso1         | hobbit  |   2675
(12 rows)
*/

EXPLAIN
INSERT INTO RCAR VALUES ('perso1',12, 2, 'lâche', 0.82);
/*
QUERY PLAN
--------------------------------------------------
Insert on rcar  (cost=0.00..0.01 rows=1 width=0)
->  Result  (cost=0.00..0.01 rows=1 width=0)
(2 rows)
*/
INSERT INTO RCAR VALUES ('perso1',12, 2, 'lâche', 0.82);
--INSERT 0 1
/*
nompers     | numchap | numlivre |   traitcar   | coefcar
----------------+---------+----------+--------------+---------
Frodon         |      12 | 1        | courageux    |    0.95
Frodon         |       1 | 1        | joyeux       |     0.8
Frodon         |       1 | 1        | impatient    |     0.7
Frodon         |      17 | 1        | triste       |     0.5
Frodon         |      17 | 1        | peureux      |     0.6
Frodon         |      22 | 1        | triste       |    0.85
Frodon         |      12 | 2        | sagace       |    0.75
Frodon         |      14 | 2        | découragé    |    0.55
Frodon         |      20 | 2        | effrayé      |    0.65
Frodon         |       4 | 3        | impatient    |    0.45
Frodon         |      10 | 3        | souffrant    |    0.95
Frodon         |      13 | 3        | agonisant    |    0.85
Gimli          |      22 | 1        | impétueux    |    0.99
Gimli          |      17 | 1        | courageux    |    0.97
Gimli          |       4 | 3        | téméraire    |    0.96
Gandalf        |      12 | 1        | perspicace   |     0.8
Gandalf        |      17 | 1        | téméraire    |     0.8
Gandalf        |       4 | 3        | courageux    |     0.8
Elrond         |      22 | 1        | sage         |     0.8
Elrond         |      12 | 2        | paisible     |     0.8
Galadriel      |      12 | 2        | paisible     |    0.75
Legolas        |      12 | 2        | paisible     |    0.78
Legolas        |       4 | 3        | enthousiaste |    0.78
Aragorn II     |      22 | 1        | courageux    |    0.93
Aragorn II     |       4 | 3        | angoissé     |    0.93
Eorl           |      12 | 2        | fier         |    0.93
Boromir        |      22 | 1        | fou          |    0.93
Sméagol        |      13 | 3        | maladroit    |     0.5
Fléau de Durin |      17 | 1        | peureux      |     0.5
perso1         |      12 | 2        | lâche        |    0.82
(30 rows)
*/


-- Question 6 :

-- Modifiez la date de naissance de Frodon...

--a)
EXPLAIN UPDATE PERSONNAGES SET annais=2522 WHERE nomPers='Frodon';
/*
QUERY PLAN
-------------------------------------------------------------------------------------
Update on personnages  (cost=4.16..9.50 rows=2 width=185)
->  Bitmap Heap Scan on personnages  (cost=4.16..9.50 rows=2 width=185)
Recheck Cond: (nompers = 'Frodon'::text)
->  Bitmap Index Scan on personnages_pkey  (cost=0.00..4.16 rows=2 width=0)
Index Cond: (nompers = 'Frodon'::text)
(5 rows)
*/
UPDATE PERSONNAGES SET annais=2522 WHERE nomPers='Frodon';
--UPDATE 12
/*
nompers     | nomtype | annais | taillemoy | imberbe |   traitcar   | coefcar | numchap | numlivre |                  titre
----------------+---------+--------+-----------+---------+--------------+---------+---------+----------+-----------------------------------------
Frodon         | hobbit  |   2522 |        90 | f       | courageux    |    0.95 |      12 | 1        | Fuite vers le gué
Frodon         | hobbit  |   2522 |        90 | f       | joyeux       |     0.8 |       1 | 1        | Une réception depuis longtemps attendue
Frodon         | hobbit  |   2522 |        90 | f       | impatient    |     0.7 |       1 | 1        | Une réception depuis longtemps attendue
Frodon         | hobbit  |   2522 |        90 | f       | triste       |     0.5 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2522 |        90 | f       | peureux      |     0.6 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2522 |        90 | f       | triste       |    0.85 |      22 | 1        | La dissolution de la Communauté
Frodon         | hobbit  |   2522 |        90 | f       | sagace       |    0.75 |      12 | 2        | L’apprivoisement de Sméagol
Frodon         | hobbit  |   2522 |        90 | f       | découragé    |    0.55 |      14 | 2        | La Porte Noire est fermée
Frodon         | hobbit  |   2522 |        90 | f       | effrayé      |    0.65 |      20 | 2        | L’antre d’Arachne
Frodon         | hobbit  |   2522 |        90 | f       | impatient    |    0.45 |       4 | 3        | Le siège de Gondor
Frodon         | hobbit  |   2522 |        90 | f       | souffrant    |    0.95 |      10 | 3        | La Porte Noire s’ouvre
Frodon         | hobbit  |   2522 |        90 | f       | agonisant    |    0.85 |      13 | 3        | La Montagne du Destin
(12 rows)
*/

--b)
EXPLAIN UPDATE RPERS SET annais=2522 WHERE nomPers='Frodon';
/*
QUERY PLAN
-------------------------------------------------------------------------------
Update on rpers  (cost=0.15..8.17 rows=1 width=70)
->  Index Scan using rpers_pkey on rpers  (cost=0.15..8.17 rows=1 width=70)
Index Cond: (nompers = 'Frodon'::text)
(3 rows)
*/
UPDATE RPERS SET annais=2522 WHERE nomPers='Frodon';
--UPDATE 1
/*
nompers     | nomtype | annais
----------------+---------+--------
Frodon         | hobbit  |   2522
(1 row)
*/


-- Question 7 :

-- Supprimez les personnages jouant dans le livre 2 de la Saga...

--a)
EXPLAIN DELETE FROM PERSONNAGES WHERE numLivre='2';
/*
QUERY PLAN
------------------------------------------------------------------
Delete on personnages  (cost=0.00..14.75 rows=2 width=6)
->  Seq Scan on personnages  (cost=0.00..14.75 rows=2 width=6)
Filter: (numlivre = '2'::text)
(3 rows)
*/
DELETE FROM PERSONNAGES WHERE numLivre='2';
--DELETE 8
/*
nompers     | nomtype | annais | taillemoy | imberbe |   traitcar   | coefcar | numchap | numlivre |                  titre
----------------+---------+--------+-----------+---------+--------------+---------+---------+----------+-----------------------------------------
Gimli          | nain    |   2879 |       200 | f       | impétueux    |    0.99 |      22 | 1        | La dissolution de la Communauté
Gimli          | nain    |   2879 |       200 | f       | courageux    |    0.97 |      17 | 1        | Le Pont de Khazad-Dum
Gimli          | nain    |   2879 |       200 | f       | téméraire    |    0.96 |       4 | 3        | Le siège de Gondor
Gandalf        | Istar   |    314 |       150 | f       | perspicace   |     0.8 |      12 | 1        | Fuite vers le gué
Gandalf        | Istar   |    314 |       150 | f       | téméraire    |     0.8 |      17 | 1        | Le Pont de Khazad-Dum
Gandalf        | Istar   |    314 |       150 | f       | courageux    |     0.8 |       4 | 3        | Le siège de Gondor
Elrond         | Elfe    |    317 |       100 | t       | sage         |     0.8 |      22 | 1        | La dissolution de la Communauté
Legolas        | Elfe    |    323 |       110 | t       | enthousiaste |    0.78 |       4 | 3        | Le siège de Gondor
Aragorn II     | humain  |   2931 |       222 | f       | courageux    |    0.93 |      22 | 1        | La dissolution de la Communauté
Aragorn II     | humain  |   2931 |       222 | f       | angoissé     |    0.93 |       4 | 3        | Le siège de Gondor
Boromir        | humain  |   2978 |       200 | f       | fou          |    0.93 |      22 | 1        | La dissolution de la Communauté
Sméagol        | hobbit  |   2440 |        45 | f       | maladroit    |     0.5 |      13 | 3        | La Montagne du Destin
Fléau de Durin | balrog  |    112 |      9000 | t       | peureux      |     0.5 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2522 |        90 | f       | courageux    |    0.95 |      12 | 1        | Fuite vers le gué
Frodon         | hobbit  |   2522 |        90 | f       | joyeux       |     0.8 |       1 | 1        | Une réception depuis longtemps attendue
Frodon         | hobbit  |   2522 |        90 | f       | impatient    |     0.7 |       1 | 1        | Une réception depuis longtemps attendue
Frodon         | hobbit  |   2522 |        90 | f       | triste       |     0.5 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2522 |        90 | f       | peureux      |     0.6 |      17 | 1        | Le Pont de Khazad-Dum
Frodon         | hobbit  |   2522 |        90 | f       | triste       |    0.85 |      22 | 1        | La dissolution de la Communauté
Frodon         | hobbit  |   2522 |        90 | f       | impatient    |    0.45 |       4 | 3        | Le siège de Gondor
Frodon         | hobbit  |   2522 |        90 | f       | souffrant    |    0.95 |      10 | 3        | La Porte Noire s’ouvre
Frodon         | hobbit  |   2522 |        90 | f       | agonisant    |    0.85 |      13 | 3        | La Montagne du Destin
(22 rows)
*/

--b)
EXPLAIN DELETE FROM RPERS WHERE nomPers in (select nomPers from RCAR where numLivre = '2') ;
/*
                                     QUERY PLAN
-------------------------------------------------------------------------------------
 Delete on rpers  (cost=17.66..24.36 rows=425 width=12)
   ->  Nested Loop  (cost=17.66..24.36 rows=425 width=12)
         ->  HashAggregate  (cost=17.51..17.52 rows=1 width=38)
               Group Key: rcar.nompers
               ->  Seq Scan on rcar  (cost=0.00..17.50 rows=3 width=38)
                     Filter: (numlivre = '2'::text)
         ->  Index Scan using rpers_pkey on rpers  (cost=0.15..6.84 rows=1 width=38)
               Index Cond: (nompers = rcar.nompers)
(8 rows)
*/
DELETE FROM RPERS WHERE nomPers in (select nomPers from RCAR where numLivre = '2') ;
--DELETE 6
-- Partie 3 : Transactions
-- user1

--Question 1
BEGIN
  --Insertion d'un livre
  INSERT INTO RCHAP VALUES (1,0,"Bilbo le hobbit");

  --Insertion de nouveaux personnages

  INSERT INTO RCAR VALUES ('perso2',1, 0, 'lâche', 0.82);
  INSERT INTO RPERS VALUES ('perso1', 'hobbit', 2675);


  INSERT INTO RCAR VALUES ('perso3',1, 0, 'courageux', 0.69);
  INSERT INTO RPERS VALUES ('perso3', 'humain', 2665);

  INSERT INTO RCAR VALUES ('perso4',1, 0, 'peureux', 0.77);
  INSERT INTO RPERS VALUES ('perso4', 'Elfe', 2684);

COMMIT;


--Question 2 : Illustrer un problème de lecture impropre

--user1
BEGIN
--user2
BEGIN
--user1
UPDATE RPERS SET annais=5555 WHERE nomPers='Frodon';
--user2
SELECT annais FROM RPERS where nomPers ='Frodon' ;
--user1
ROLLBACK;

--Question 3 : Illustrer un problème de mise à jour

--user1
BEGIN
--user2
BEGIN
--user1
UPDATE RPERS SET annais=5555 WHERE nomPers='Frodon';
--user2
UPDATE RPERS SET annais=6666 WHERE nomPers='Frodon' ;
--user2
COMMIT;
--user1
SELECT annais FROM RPERS where nomPers ='Frodon' ;
COMMIT;

--Question4 : Illustrer un problème de lecture non reproductible

--user2
BEGIN
SELECT annais FROM RPERS where nomPers ='Frodon' ;
--user1
BEGIN
SELECT annais FROM RPERS where nomPers ='Frodon' ;
--user2
UPDATE RPERS SET annais=5555 WHERE nomPers='Frodon';
COMMIT;
--user1
SELECT annais FROM RPERS where nomPers ='Frodon';

COMMIT;

--Question5 : Illustrer un problème d'interblocage
