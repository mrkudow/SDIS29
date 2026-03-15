-- =====================================================================================================
-- Script du 11/10/2021 
-- > Nom de la base de données : sdis29
-- > Les n° auto pour des attributs non clés primaires ont été transformés en SMALLINT.
-- > Les tables générées sont de type InnoDb.
-- > Les clés étrangères ne sont gérées que si MySql gère les tables InnoDb.
-- > Le jeu de caractères utilisé est utf8.
-- > Le mot de passe du pompier est chiffré à l'aide de MD5
--  =====================================================================================================
DROP DATABASE IF EXISTS `sdis29`;
CREATE DATABASE `sdis29` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sdis29;
set names 'utf8';
--  ----------------------------------------------------------------------------------------------
--  > Création des 4 tables
--  ----------------------------------------------------------------------------------------------
create table caserne(
     id SMALLINT not null,
     nom VARCHAR(30),
     adresse VARCHAR(60),
     tel VARCHAR(14),
     groupement VARCHAR(25),
     primary key(id)) 
     ENGINE=INNODB DEFAULT CHARSET=utf8mb4;
-- 

CREATE TABLE `pompier` (
  `id` smallint(6) NOT NULL,
  `idCaserne` smallint(6) NOT NULL,
  `nom` varchar(40) DEFAULT NULL,
  `prenom` varchar(40) DEFAULT NULL,
  `statut` smallint(6) DEFAULT NULL,
  `typePers` smallint(6) DEFAULT NULL,
  `mail` varchar(33) DEFAULT NULL,
  `mdp` varchar(10) NOT NULL,
  `login` varchar(10) DEFAULT NULL,
  `mdps` varchar(128) NOT NULL COMMENT 'UPDATE pompier SET salt = (@s := TO_BASE64(RANDOM_BYTES(16))), mdps = TO_BASE64(SHA2(CONCAT(@s, UPPER(login)), 256));',
  `salt` varbinary(32) NOT NULL,
  `adresse` varchar(32) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `ville` varchar(32) DEFAULT NULL,
  `bip` varchar(10) DEFAULT NULL,
  `nbGardes` smallint(6) DEFAULT NULL,
  `grade` smallint(6) DEFAULT NULL,
  `commentaire` varchar(200) DEFAULT NULL,
  `dateEnreg` datetime DEFAULT NULL,
  `dateModif` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

create table typeParametre(
     id VARCHAR(7) not null,
     libelle VARCHAR(70),
     bool TINYINT(1),
     choixMultiple TINYINT(1),
     primary key(id)) 
     ENGINE=INNODB DEFAULT CHARSET=utf8mb4;
--
create table parametre(
     idType VARCHAR(7) not null,
     indice SMALLINT not null,
     libelle VARCHAR(80),
     valeur VARCHAR(25),
     plancher INT,
     plafond INT,
     primary key(idType, indice),
     foreign key (idType) references typeParametre(id)) 
     ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

create table disponibilite (
    date_dispo DATE NOT NULL,
    pompierId SMALLINT(6),
    nuit ENUM('0', '1', '2', '3', '4') DEFAULT '0',
    matinee ENUM('0', '1', '2', '3', '4') DEFAULT '0',
    apres_midi ENUM('0', '1', '2', '3', '4') DEFAULT '0',
    soiree ENUM('0', '1', '2', '3', '4') DEFAULT '0'
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

--  ---------------------------------------------------------------------------------------------
--  > Jeu d'essai
--  ----------------------------------------------------------------------------------------------
insert into caserne(id, nom, adresse, tel, groupement) values
     (2901,'BANNALEC','Rue Eugène Cadic - 29380','02.98.39.83.02','CONCARNEAU'),
     (2902,'BENODET','37 route de Poulpry - 29950','02.98.57.05.00','QUIMPER'),
     (2903,'BRASPARTS','Rue de la Maine - 29190','02.98.81.45.65','MORLAIX'),
     (2904,'BREST','17 rue Amiral Romain Desfossés - 29200','02.98.34.56.13','BREST'),
     (2905,'BRIEC DE Lr ODET','Ty Eugène - 29S10','02.98.57.91.67','QUIMPER'),
     (2906,'CAMARET','Place Saint- Yves - 29S70','02.98.27.90.46','BREST'),
     (2907,'CAP-SIZUN - AUDIERNE','Rue du Goyen - 29770 AUDIERNE','02.98.70.11.96','QUIMPER'),
     (2908,'CAP-SIZUN - PONT CROIX','Rue du Goyen - 29770 AUDIERNE','02.98.70.42.14','QUIMPER'),
     (2909,'CAP-SIZUN - ILE DE SEIN','Place François le Sud - 29990','02.98.70.93.64','QUIMPER'),
     (2910,'CARANTEC','Kérouguelen - 29660','02.98.78.37.46','MORLAIX'),
     (2911,'CARHAIX','Rue Jean-Sébastien Corvellec - 29270','02.98.99.34.40','MORLAIX'),
     (2912,'CHATEAULIN','Rocade dt Quimill - 29150','02.98.86.83.47','BREST'),
     (2913,'CHATEAUNEUF DU FAOU','7 place aux chevaux - 29S20','02.98.81.84.15','MORLAIX'),
     (2914,'CLOHARS CARNOËT','Rue Quilhen Langlazic - 29360','02.98.71.98.88','CONCARNEAU'),
     (2915,'CONCARNEAU','112 rue de la Gare - 29900','02.98.97.32.40','CONCARNEAU'),
     (2916,'CORAY','Zone de Lanviho - 29370','02.98.59.74.47','CONCARNEAU'),
     (2917,'CROZON','Boulevard de Pralognan-la-Vanoise - 29160','02.98.27.14.65','BREST'),
     (2918,'DOUARNENEZ','4 route de Brest - 29100','02.98.92.00.38','QUIMPER'),
     (2919,'ELLIANT','Rue Pasteur - 29370','02.98.94.14.43','CONCARNEAU'),
     (2920,'FOUESNANT','31 rue du château d\'eau - 29170','02.98.56.11.83','QUIMPER'),
     (2921,'GUERLESQUIN','Route de Bolazec - 29650','02.98.72.86.25','MORLAIX'),
     (2922,'HUELGOAT','31 rue du Général de Gaulle - 29690','02.98.99.90.76','MORLAIX'),
     (2923,'ILE DE BATZ','Route du Jardin Colonial - 292S3','02.98.61.78.43','MORLAIX'),
     (2924,'ILE DE OUESSANT','Kernigou - 29242','02.98.48.85.59','BREST'),
     (2925,'LANDERNEAU','rue ingénieur Jacques Frimot - 29800','02.98.85.16.16','BREST'),
     (2926,'LANDIVISIAU','28 rue Georges Clemenceau - 29400','02.98.68.03.18','MORLAIX'),
     (2927,'LANMEUR','Rue des Quatre Vents - 29620','02.98.67.50.31','MORLAIX'),
     (2928,'LANNILIS','Rue Mathilde Delaporte - 29870','02.98.04.17.36','BREST'),
     (2929,'LE FAOU','Place aux Foires - 29590','02.98.81.01.11','BREST'),
     (2930,'LE GUILVINEC','43 rue Jean Jaurès - 29730','02.98.58.26.48','QUIMPER'),
     (2931,'LESNEVEN','Place du Champ de Bataille - 29260','02.98.83.02.68','BREST'),
     (2932,'LEUHAN','4 rue de l\'école - 29390','02.98.82.50.87','CONCARNEAU'),
     (2933,'LOCTUDY','Place des Anciens Combattants - 29750','02.98.87.40.18','QUIMPER'),
     (2934,'MELGVEN','Rue Neuve - 29140','02.98.97.99.88','CONCARNEAU'),
     (2935,'MOELAN SUR MER','46 rue de Pont ar Laer - 29350','02.98.39.68.90','CONCARNEAU'),
     (2936,'MORLAIX','7 rue de l\'Orée du Bois - 29600','02.98.88.16.18','MORLAIX'),
     (2937,'PENMARC\'H','Rue Edmond Michelet - 29760','02.98.58.72.16','QUIMPER'),
     (2938,'PLABENNEC','7 rue du Maréchal Leclerc - 29860','02.98.40.81.81','BREST'),
     (2939,'PLEYBEN','Rue Maurice de Trésiguidy - Zone du Drevers - 29190','02.98.26.32.87','MORLAIX'),
     (2940,'PLOBANNALEC','Place du 19 mars 1962 - 29740','02.98.87.80.27','QUIMPER'),
     (2941,'PLOMEUR','Rue du Prat Don - 29120','02.98.82.05.13','QUIMPER'),
     (2942,'PLONEOUR LANVERN','Place Amiral Ronarc\'h - 29720','02.98.87.70.99','QUIMPER'),
     (2943,'PLOUDALMEZEAU','Rue de Cullompton - 29830','02.98.48.05.78','BREST'),
     (2944,'PLOUESCAT','Boulevard de l\'Europe - 29430','02.98.69.61.99','MORLAIX'),
     (2945,'PLOUGONVEN','24 rue de Morlaix - 29640','02.98.78.70.72','MORLAIX'),
     (2946,'PLOUGUERNEAU','ZA Héliez - 29880','02.98.04.61.85','BREST'),
     (2947,'PLOZEVET','Rue de l\'usine - 29710','02.98.91.46.55','QUIMPER'),
     (2948,'PONT AVEN','Rue du Général de Gaulle - 29930','02.98.06.05.15','CONCARNEAU'),
     (2949,'PONT L\'ABBE','Place de la Gare - 29120','02.98.87.08.36','QUIMPER'),
     (2950,'POULDREUZIC','Rue de la Gare - 29710','02.98.54.46.33','QUIMPER'),
     (2951,'QUERRIEN','Rue du Château d\'Eau - 29310','02.98.71.37.57','CONCARNEAU'),
     (2952,'QUIMPER','60 avenue de Kéradennec - 29000','02.98.64.88.00','QUIMPER'),
     (2953,'QUIMPERLE','15 allée Victor Schœlcher   - Z.A. de Kergoaler - 29300','02.98.96.18.18','CONCARNEAU'),
     (2954,'RIEC SUR BELON','Rue centrale - 29340','02.98.06.41.34','CONCARNEAU'),
     (2955,'ROSPORDEN','ZI de Dioulan - 29140','02.98.59.94.93','CONCARNEAU'),
     (2956,'SAINT GOAZEC','Kervoazec - 29520','02.98.26.84.76','MORLAIX'),
     (2957,'SAINT POL DE LEON','Rue du Budou - 29250','02.98.69.20.18','MORLAIX'),
     (2958,'SAINT RENAN',' Route de Plouzané - 29290','02.98.84.21.76','BREST'),
     (2959,'SAINT THEGONNEC','Penfo - 29410','02.98.79.46.00','MORLAIX'),
     (2960,'SAINT THURIEN',' Route de Scaêr - 29380','02.98.39.48.16','CONCARNEAU'),
     (2961,'SCAER','Rue Queignec - 29390','02.98.59.42.33','CONCARNEAU'),
     (2962,'SIZUN','Rue du Léon - 29450','02.98.68.87.06','MORLAIX'),
     (2963,'SPEZET','8, rue des Ecoles - 29540','02.98.93.93.65','MORLAIX'),
     (2964,'TREGOUREZ','Rue Yvon Donnard - 29970','02.98.59.14.67','QUIMPER');
--  ----------------------------------------------------------------------------------------------
insert into typeParametre(id,libelle,bool,choixMultiple) values
     ('dispo','type de disponibilité',0,0),
     ('grade','Grade de l\'agent',0,0),
     ('statAgt','Statut de l\'agent',0,1),
     ('tranche','Tranche horaire',0,0),
     ('typePer','Type de personnel',0,0);
--  ----------------------------------------------------------------------------------------------
insert into parametre(idType,indice,libelle,valeur,plancher,plafond) values
     ('dispo',0,'Indisponible','gray',null,null),
     ('dispo',1,'Disponible','white',null,null),
     ('dispo',2,'Au travail','yellow',null,null),
     ('dispo',3,'Garde','lime',null,null),
     ('dispo',4,'Au travail-Garde','lime',null,null),
     ('grade',0,'Sapeur',null,null,null),
     ('grade',1,'Adjudant',null,null,null),
     ('grade',2,'Adjudant-Chef',null,null,null),
     ('grade',3,'Capitaine',null,null,null),
     ('grade',4,'Caporal',null,null,null),
     ('grade',5,'Caporal-Chef',null,null,null),
     ('grade',6,'Commandant',null,null,null),
     ('grade',7,'Lieutenant',null,null,null),
     ('grade',8,'Lieutenant-Colonel',null,null,null),
     ('grade',9,'Major',null,null,null),
     ('grade',10,'Sergent',null,null,null),
     ('grade',11,'Sergent-chef',null,null,null),
     ('statAgt',1,'pompier',null,null,null),
     ('statAgt',2,'chef de centre',null,null,null),
     ('statAgt',3,'responsable des alertes',null,null,null),
     ('tranche',1,'nuit :  0h/6h',null,null,null),
     ('tranche',2,'matin :  6h/12 h',null,null,null),
     ('tranche',3,'après-midi : 12h/18h',null,null,null),
     ('tranche',4,'soirée : 18h/24h',null,null,null),
     ('typePer',1,'pompier professionnel',null,null,null),
     ('typePer',2,'pompier volontaire',null,null,null),
     ('typePer',3,'personnel médical',null,null,null),
     ('typePer',4,'personnel administratif',null,null,null);
--  ----------------------------------------------------------------------------------------------
--
-- Déchargement des données de la table `pompier`
--

INSERT INTO `pompier` (`id`, `idCaserne`, `nom`, `prenom`, `statut`, `typePers`, `mail`, `mdp`, `login`, `mdps`, `salt`, `adresse`, `cp`, `ville`, `bip`, `nbGardes`, `grade`, `commentaire`, `dateEnreg`, `dateModif`) VALUES
(1, 2901, 'ROUAT', 'Michel', 2, 1, 'michel.rouat@sdis29.fr', 'MROUA', 'mROUA', 'MGU4NGVhMjllOWI4MGJlYjY4Y2Y2NGIxNDhkY2QzZTdmMGVjNDMwYjFjNjc1OGE4NTk4OGM2Nzgw\nNDVjNzhjNg==', 0x6b4f367372516865304848784b66764b4336624278513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(2, 2901, 'RANNOU', 'Michel', 1, 2, 'michel.rannou@sdis29.fr', 'MRANN', 'mRANN', 'YTY3N2I2ZjExNzE2YjYyNmFlYWViNzlhOTVlMDdlZTdjZTBmZjExNGVkNTVlYTZkZDEzY2I5MjNl\nYTUyMjI5OA==', 0x64385743715a61384a58664332674a497161543861673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(3, 2902, 'ROSEN', 'Alain', 2, 1, 'alain.rosen@sdis29.fr', 'AROSE', 'aROSE', 'NTU3NTgyZGMyMDcwYTc2OWJkMTdjNmRlNDQ5NDIzMDZhODA5MjliM2JkYWVmNTEzOGJiYjhmODJj\nZTc3OWJmMw==', 0x2b7a6b794a4875324d58526b47386d7a596a373368513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(4, 2902, 'LABORY', 'Bruno', 1, 2, 'bruno.labory@sdis29.fr', 'BLABO', 'bLABO', 'NjhmY2FjYjlhYTgxOGEyMDRjNGQzNTVhYTMyZjJjYmEzNzk0YWVkMTg1ZTBhMjYyOWFjYWY4ZTg2\nZDA0ZjZlZg==', 0x372b2b45327a794f5a6e37486b725a317651784668673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(5, 2903, 'RIVOAL', 'Ronan', 2, 1, 'ronan.rivoal@sdis29.fr', 'RRIVO', 'rRIVO', 'MTQ2YzUxMGU4MDMxYTkxNTYwNzAzYzM3NmVlN2Q4MzM5NDVkY2JjNTZkZTQ0ZDA5NmEzZTVjZDc5\nZDc0NjQyYw==', 0x42586a464c345a4846562f76415836736e70594b61773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(6, 2903, 'SIMON', 'Frédéric', 1, 2, 'frédéric.simon@sdis29.fr', 'FSIMO', 'fSIMO', 'MGM5YzQ0MGEzNWVlNGYyY2M0MTVhODZjNmFlYTQ1NjhlMWE2N2E2MmY0MGE5YTU4ZTg2ODQwMGRl\nNzk5YjQ1OA==', 0x53495834413033745243567a4a553446326d374475513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(7, 2904, 'FALC\'HUN', 'Jean-Luc', 2, 1, 'jean-luc.falchun@sdis29.fr', 'JFALC', 'jFALC', 'ODJkZDQ0MjlmZjY0MGRhZTliOWM5ZTZmYTgyZmMzYjhlZmE3N2M3MTcyYjcwMDA5ODkyNjE0NTg5\nMjQ1ODIyZQ==', 0x39555a4f624e35793644464a507a4d4c5676644b4e513d3d, NULL, NULL, NULL, '1', 0, 8, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(8, 2904, 'QUERE', 'Alain', 3, 1, 'alain.quere@sdis29.fr', 'AQUER', 'aQUER', 'N2VlMzA4ZTk2ODJlZDhhZjE3OGZkNzk3OWNhMTNhNDQwZDEyMzVjYTgzMmRkZTRiMDJjNTIzYmUy\nYmQ1MjY3OQ==', 0x55416c457a3531715848734653314e507639427177513d3d, NULL, NULL, NULL, '2', 0, 3, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(9, 2904, 'KEREBEL', 'Erwan', 1, 2, 'erwan.kerebel@sdis29.fr', 'EKERE', 'eKERE', 'ZDE2ZmY1YjQ5NWYyNWY1OGJkYzgzZWE3M2E0Y2Q0MzEzZTMyOTU0MWYyNTBhYWQwMDFmYzc0NmU2\nYmQ4NDY3YQ==', 0x2f374744684959707665543774502f786e4c314748673d3d, NULL, NULL, NULL, '3', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(10, 2904, 'PAULEAU', 'Pierre', 1, 2, 'pierre.pauleau@sdis29.fr', 'PPAUL', 'pPAUL', 'Nzk4NWFhYTNkNTc2NGMxYjI4MjBiZGUyM2Q4MGQ4ZTZjYWQ4MTA4ZDczY2MyYWJhYzkzYTk3MDE5\nNTc0YTU1MQ==', 0x6244756e6b556832647639526a59364f316d68326b413d3d, NULL, NULL, NULL, '4', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(11, 2904, 'DEROFF', 'Jacques', 1, 2, 'jacques.deroff@sdis29.fr', 'JDERO', 'jDERO', 'NzljNzlhMzg0N2M2ZGFhNGEzOTcxNWY1ZDRmMWNkODE5ZjBmYTljYWE3ODI2YTkwNDMyNzQzZGU4\nNjgyMmUxMA==', 0x73595468673839396d597a7375566d4b6561737767673d3d, NULL, NULL, NULL, '5', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(12, 2904, 'MAZE', 'Dominique', 1, 2, 'dominique.maze@sdis29.fr', 'DMAZE', 'dMAZE', 'NmYxZDE1ZThjNjdhNjI0NmU2ZjJkZTY4Y2FjZjlmZDY4MGUyMzhlMTJlYzRiNjQ1YWQzMDVlNjE1\nN2EyMjk3Nw==', 0x6a5a582b385645586b6b6b41304747773341653065673d3d, NULL, NULL, NULL, '6', 0, 6, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(13, 2904, 'TOULLEC', 'Jérôme', 1, 2, 'jérôme.toullec@sdis29.fr', 'JTOUL', 'jTOUL', 'M2E5MjRjYmI5MzhlMjYzYTQwODlkNjY5ZmE3MmRiMDcwYzdkMGY1OWQzZTk2ZWZmZTU0ZGM5MTU4\nZjFmMDc5MA==', 0x515343563378675a65756f6179736c6a644e525438673d3d, NULL, NULL, NULL, '7', 0, 3, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(14, 2904, 'KERBERENES', 'Pascal', 1, 2, 'pascal.kerberenes@sdis29.fr', 'PKERB', 'pKERB', 'MWU4ZDU4YzVkYTMwOWY4ZmNmZWZlYjc2ZDEyNjc2YzdmYmE5ZjI1MWNiYTA3MzUxNjRkZjJmMGU0\nODllMzRlYw==', 0x46464530474b727138654d5a6e6b754f7a73725a34413d3d, NULL, NULL, NULL, '8', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(15, 2904, 'JACQUET', 'Bertrand', 1, 2, 'bertrand.jacquet@sdis29.fr', 'BJACQ', 'bJACQ', 'YzE3YzJhOTkwZmZiYjk2YTE4ZDMwNzA4NzYyMGFhODBjMTIwNmU5MmI1ZTI2MDJiMmFlYThkZDky\nY2NmZWE1Mw==', 0x5145776e39793568666f31415a393264765345316e673d3d, NULL, NULL, NULL, '9', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(18, 2904, 'BOULIC', 'Louis', 1, 2, 'louis.boulic@sdis29.fr', 'LBOUL', 'lBOUL', 'ZDE1YjE2Y2Q0OGY5N2IxNGNiZWNlOTU4NzI0NGVhM2E4Y2FmM2U3ZWQyMTk0NzE1ZDgzYjk1MGVh\nMjQwZGY0Mg==', 0x52626655466a30716639515273436534552f495a33773d3d, NULL, NULL, NULL, '12', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(19, 2904, 'BERNARD', 'Luc', 1, 2, 'luc.bernard@sdis29.fr', 'LBERN', 'lBERN', 'ZTMxNjg4ODVkNDYwMDA5M2NhYzM5MDdiZTFmMDk4Y2YzZDk3OTAyMjhmN2YyYTk1MmVkY2QzMTA4\nMWRlODZiYw==', 0x385a364f4e346a34504c46325a2b614651496f664c513d3d, NULL, NULL, NULL, '13', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(20, 2904, 'DUROSE', 'Pierre', 1, 2, 'pierre.durose@sdis29.fr', 'PDURO', 'pDURO', 'MGM1Y2Q1YTg2YTRjNzliMDkxYjgyNTE1MzJmNGE0MmM3OWMwNGRiOGM4NDQwMzBhZDRiNjBiOTJh\nZDUxODcxMQ==', 0x4d48435a776f76705735336e426d76315a42546973673d3d, NULL, NULL, NULL, '14', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(21, 2905, 'PENNEC', 'Daniel', 2, 1, 'daniel.pennec@sdis29.fr', 'DPENN', 'dPENN', 'MDgyYWMwMmZjMGFlMjU0ZjJiZWIzZGU4ZDA1NzUxOGFlOTQ5ZjU4NGMyODQwMDkxY2FiM2Y3YTBj\nOTdhZDFiZg==', 0x3965716145675a746e4139586a7336595a55452f43773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(22, 2905, 'GAONAC\'H', 'Jean-Claude', 1, 2, 'jean-claude.gaonach@sdis29.fr', 'JGAON', 'jGAON', 'NmU0Nzc2N2NlMTljOWVkMDQxMmJhODE3YTE4MWZlMGY4ODQ5OWE3YTVkYjcyZTkzOWEzN2JlZDJm\nNDczMTY4Yg==', 0x524e596657616e51643544746f4477637961525953673d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(23, 2906, 'DAVAIC', 'José', 2, 1, 'josé.davaic@sdis29.fr', 'JDAVA', 'jDAVA', 'ZDM4NGYxYWE1ODA1MGQ4MjAwYzVjYjZkMjA5YjJlZWUwODFjODJmMjY2ODE2NDJjYjZkYTgxMjJm\nOGU2NWQ5Mg==', 0x7631366f4364644175765236594e79345837635137673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(24, 2906, 'TANIOU', 'Claude', 1, 2, 'claude.taniou@sdis29.fr', 'CTANI', 'cTANI', 'N2Q4YzMzZDMxZmQ0MWM5MzIxMjBhNzMwODM3OTFmZTIxMmVlYzA2ZGUxNzg2Yjc4YTcyN2I2M2Qz\nMThjOTRhMg==', 0x2b6c4a313865467857512f68324273385247483250673d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(25, 2907, 'MARZIN', 'Jean-François', 2, 1, 'jean-françois.marzin@sdis29.fr', 'JMARZ', 'jMARZ', 'MTBjZTcwOGNiNDk0MmUzMWQ5YzI3ZjIxZDYzYTc3ZGM4YzMzOWRlMWZiN2FmMDYyNDRjZDUwOWMz\nY2EwYzQ4MA==', 0x3933777936724e444535456a61347377316151642b773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(26, 2907, 'COÏC', 'Alain', 1, 2, 'alain.coïc@sdis29.fr', 'ACOÏC', 'aCOÏC', 'Y2Q4NTBlZmU5ZDE1OGE4ZTUwZWU4NjlhODhmYTVmZmFjYmI2ZTBhMDhkNzc1OGNmZGU0NWQxOTE1\nMDFjMjA0NA==', 0x434c7a30374233774b41492b682b42676564687164673d3d, NULL, NULL, NULL, '2', 0, 5, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(27, 2908, 'KERSUAL', 'Hervé', 2, 1, 'hervé.kersual@sdis29.fr', 'HKERS', 'hKERS', 'ZTUxZjhkNzczNDRkOTc5N2FlYzI2NDAxMWIyM2M5NTNhODA1MTc5Y2M3NTRhYWZlZDNhZTNlZDgy\nMGQ5MGFiMg==', 0x455139632b564b676c30615a316b436d424d354e31413d3d, NULL, NULL, NULL, '1', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(28, 2909, 'COÏC', 'Alain', 2, 1, 'alain.coïc@sdis29.fr', 'ACOÏC', 'aCOÏC', 'OGY1YTk2NjkzOWVjNGIyNWU4NTRkMmY3NDBjMTIyYzMwOTQ4ZjFhYzE0NjRkY2VkZTIwMTE2NTIy\nZTQyZDVkNg==', 0x6964434b64414832687972586b6f717573686f4456513d3d, NULL, NULL, NULL, '1', 0, 4, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(29, 2911, 'CADIOU', 'Philippe', 2, 1, 'philippe.cadiou@sdis29.fr', 'PCADI', 'pCADI', 'YTFmYTkyZDY1OTgxYTc0ODhmNjk3YjBkMWU3N2IwNWI4ODEyMGRiYjFlM2Q1ZmE0NDdlZWIyMjk5\nYTlkYjA3OQ==', 0x65377a6d636a422f7a6337534579413056506a3257773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(30, 2911, 'COCHENNEC', 'Eric', 1, 2, 'eric.cochennec@sdis29.fr', 'ECOCH', 'eCOCH', 'NGMyYTMzMTM4ZmM2YjI1Mzk5ZjkyNTAzZTdmN2RjMTdmYjY1NTI0ZjkxZThiYzU1ZWEzMDQyZTJj\nNGM2MTA5Mg==', 0x6738674f764e34444e6d566837776264364a556143773d3d, NULL, NULL, NULL, '2', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(31, 2912, 'DURET', 'Nicolas', 2, 1, 'nicolas.duret@sdis29.fr', 'NDURE', 'nDURE', 'YjZmZTk1MDkwMzlmZGZmMjI2ZDExZmQ5NWUxMDgxNjhjZDFjMDgyNjUyMmRmMTI3ZTg0MmUzMGU2\nM2E5ZTNlYw==', 0x735259526554777a506b6e452b32736a48674c4752513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(32, 2912, 'SCOARNEC', 'Stéphane', 1, 2, 'stéphane.scoarnec@sdis29.fr', 'SSCOA', 'sSCOA', 'OGQ2ZDg4MDNmMmI0NmEzYTE3MmZmYmJjNTcyNWIzZGNlZWFiMzZlNDgxYTIyYmJmNGY4MzNiYzQ0\nNzk1MTE1YQ==', 0x752b314c686633424233437269614f2b7779766c4e673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(33, 2913, 'DELAPORTE', 'David', 2, 1, 'david.delaporte@sdis29.fr', 'DDELA', 'dDELA', 'YzAxZGZiNGE4OGYwOWEzYWQ5OGRiNzczZDkxNzZmYTk0ODFjYzZiNGEzNmEwMjIyYzg1YzhhZDZk\nZTAyOWRlOA==', 0x5152706a696a4355367a78596f68576430356a506e513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(34, 2914, 'GUERROUE', 'Eric', 2, 1, 'eric.guerroue@sdis29.fr', 'EGUER', 'eGUER', 'ZWI1M2RhNDQyNmMxMDNiYjc4YWU2NjVhMDJjYjQ5ZTg4NGJlYWQ0MDY1YTFiNmNjMTk0ZDA0NWVh\nNWYyYTEzYQ==', 0x3135377a6572386c59473071475574694745624661413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(35, 2914, 'LE BOURHIS', 'Bruno', 1, 2, 'bruno.le_bourhis@sdis29.fr', 'BLE B', 'bLE B', 'YWRhMjg5NDZmMzk3MjVlMWQ4Y2I2ODc5ODk0NGY5ZGFhYmYzNTE1OTk5NjczMTE2ZTcxZmM2Zjc4\nMTZiZWYyMw==', 0x5449366b2f434666542b51416f3248356777657547673d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(36, 2915, 'BOUSSIN', 'Cédric', 2, 1, 'cédric.boussin@sdis29.fr', 'CBOUS', 'cBOUS', 'NTJiNzgyYjI5YjFhMTFmZTNhNWJkNTcyM2JjNWVmNTMzMGEyZWZlYjU1NDM1NjM3MjkzZTMwNGM1\nZTZiMmFlOQ==', 0x31537231502b39746d6c6f41684d702f7942654175513d3d, NULL, NULL, NULL, '1', 0, 6, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(37, 2915, 'PITOR', 'Pascal', 3, 1, 'pascal.pitor@sdis29.fr', 'PPITO', 'pPITO', 'NjdmMWMzMWU2NGRlNDBkMmRiNTIwNDQ4MjQwZTcyOTYyODBkNjEwNTU0MDk2NjI2ZTcyYTJlOTQx\nYzFhZTQ2Nw==', 0x366c46424c57376d4b774c2f623561626246515979413d3d, NULL, NULL, NULL, '2', 0, 6, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(38, 2915, 'GIRE', 'Gilbert', 1, 2, 'gilbert.gire@sdis29.fr', 'GGIRE', 'gGIRE', 'MTE0NmY0ZTQ3ODFlZDhjOGFiZGQ4NmY3YTYwMTRiOGYxMzczZDMzZDZkNzBmNjM0MGEwMzhhMDU2\nODI1MzI1OQ==', 0x617375436c7a384e54345864632b45724f796f5a2b513d3d, NULL, NULL, NULL, '3', 0, 3, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(39, 2915, 'PICAUT', 'Franck', 1, 2, 'franck.picaut@sdis29.fr', 'FPICA', 'fPICA', 'MDcwNDgyY2RjOWM3Zjg3ZmQyZmEwYzE4OTBkNDgxNTUxODEzMGM3OTI4YWVmMWUyYmE2ZGIwMjA4\nZTA4OWMyNA==', 0x55356c4f644675773933367954534d4f4955436d66413d3d, NULL, NULL, NULL, '4', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(40, 2915, 'VIOL', 'Alain', 1, 2, 'alain.viol@sdis29.fr', 'AVIOL', 'aVIOL', 'MmQ4YzI0YzA4Yjk1MTNjOGZmMjBjMDBjMzAyNjQ1ZmU2NjkzNTNhYWMxMjliNzE5OWE0ZWQyMGQ4\nN2M1ODY0NA==', 0x734668424f6159624e444e6b79525a41454b776839673d3d, NULL, NULL, NULL, '5', 0, NULL, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(41, 2915, 'QUEAU', 'Erwan', 1, 2, 'erwan.queau@sdis29.fr', 'EQUEA', 'eQUEA', 'YTFlYjdjOGU1Y2RjNTMxY2RjMzlmOGM1N2E3YTJhYmNmMzczYmUxYWFjZjQ4ZGVmNmU5YTgyYjRl\nNWE1NTQ5OA==', 0x7636646c7943334d776c4869446d4d2f3741476f65773d3d, NULL, NULL, NULL, '6', 0, 3, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(42, 2915, 'VAXELAIRE', 'Francis', 1, 2, 'francis.vaxelaire@sdis29.fr', 'FVAXE', 'fVAXE', 'MTYwOTg4NzU1MDQ1YTQ1N2I4YWI4MjYxNjk5ZGI3NTU4YTRmOTEyOTg0NzI0YTQ3ZDdkNTYxZDNl\nNGRmNDg2YQ==', 0x4a424f784b524161466938364f7271354475517765773d3d, NULL, NULL, NULL, '7', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(43, 2916, 'HEMERY', 'Michel', 2, 1, 'michel.hemery@sdis29.fr', 'MHEME', 'mHEME', 'MzNjNzk3MWUxMmQ3MDU4OTllNDlhZTM3MzlkYzlmMmE3NGE5NTllMTgyNTg3NmQ4Yjc1NThkMjcz\nNmYxMjY3Mg==', 0x3266306f3770646e496e386e59636d46394e594c51413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(44, 2916, 'LE BARS', 'Didier', 1, 2, 'didier.le bars@sdis29.fr', 'DLE B', 'dLE B', 'ZWViMWEwNGFlMWYzNjYwYmQzMTgzMTVmMzI5NmI5NDU5YWFkNmQ4MmY4ZTMwYmU3MTc2MzAzZDcx\nZTVjNmVjNw==', 0x6b4236704f7a74782b327457493662432b3658754c513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(45, 2917, 'GAY', 'Lionel', 2, 1, 'lionel.gay@sdis29.fr', 'LGAY', 'lGAY', 'NjY1MWM1YzAzOTY5MjljZDhhZmJjNmVhOTNiNWRiZTJkNWVhNjI4MThjY2IxNWZiYWQ0YzdjNjFj\nMGFjZDIzMg==', 0x566b4156502f744e442b39716273794a2f74666256773d3d, NULL, NULL, NULL, '1', 0, 3, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(46, 2917, 'LARGENTON', 'Anthony', 1, 2, 'anthony.largenton@sdis29.fr', 'ALARG', 'aLARG', 'Y2Q2YjdhZmQ3OGMwMjRhM2QzN2NiOGE0OTYyOTRiN2ZjYzFkZWZkOGNjOGZjNGQ4ZDRiM2RjNTg0\nMzE5OGQ3ZQ==', 0x6c6d4663784256534957317845373948496275665a413d3d, NULL, NULL, NULL, '2', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(47, 2918, 'AMET', 'Olivier', 2, 1, 'olivier.amet@sdis29.fr', 'OAMET', 'oAMET', 'ZGVhMzA4Zjk4Y2Y4ZThhYWE5MTdmYWJmNmVmMTc2YzZjYjVlOGQyZmRjNThkYmEzYmRlZjE1MDNi\nNTIxNzExYg==', 0x474e334e69525657315756674e5672747a4f345a79773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(48, 2918, 'BIDET', 'Xavier', 1, 2, 'xavier.bidet@sdis29.fr', 'XBIDE', 'xBIDE', 'ZDAyYTdiM2VjYmEyOWI0ZTQ3MDg0ZTY0ZDA2NjVhMTUxMzg5OTBmYzA4OGUyMDllMmMxZjM4NDgw\nNmFiMmY4OA==', 0x52712f4a44396f594578534370677167657339474e773d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(49, 2919, 'LE ROY', 'Jean-Michel', 2, 1, 'jean-michel.le_roy@sdis29.fr', 'JLE R', 'jLE R', 'MmZlMjIxZTZhMTZjZWY2ZDcwNjYwYTlkODczYjYzODdjNzg3OWEyZTA4MDMzNWU3OTJjNjA3ZDZk\nNmM2NDc3OA==', 0x37484f704c767253314d584e79396c2b66444c5035673d3d, NULL, NULL, NULL, '1', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(50, 2919, 'COTTEN', 'François', 1, 2, 'françois.cotten@sdis29.fr', 'FCOTT', 'fCOTT', 'Nzk0ZDE4MDdiOTc1NTNlZTM1Y2RlNzYwNDg1MTA2NGU0MzZiMTRkZDJhZTc2Mzc5OWY4MjViMmFj\nZGI2YmQ1Yg==', 0x65652b6f2b636d662b4c79424e4933584649742b38413d3d, NULL, NULL, NULL, '2', 0, 5, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(51, 2920, 'GOARDET', 'Christian', 2, 1, 'christian.goardet@sdis29.fr', 'CGOAR', 'cGOAR', 'NDIyNWZiODFlMjU0NGU5YTliYmRjNDdlMDYwM2FkMjJhN2Y1ZGE1Mjk5Nzk2ZTRmODQyMDNiYWI3\nYWQ4YmIwMg==', 0x4f726a52673036586146324e4f3266416a4e566673513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(52, 2920, 'CORCUFF', 'Gaël', 1, 2, 'gaël.corcuff@sdis29.fr', 'GCORC', 'gCORC', 'MWM4NzBmZjIyYjY1M2YwYzM0MWE3ZDUzMWU3ZmU3MGJiMDlhM2U3YzI2YmNlOWYyNGNlOWQ4YmQw\nY2QzMjE5Nw==', 0x6972424a6155515074646e50594337566941782b35673d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(53, 2921, 'LE SCRAGNE', 'David', 2, 1, 'david.le scragne@sdis29.fr', 'DLE S', 'dLE S', 'ZGE5NzNkODliMTFhZjUyYjJhOTQ5Mzk2NTc2MzQzMjQzYmZmOWMxZTMzNmRkM2U0NjE2NDMyM2Y0\nZWY4YzAwMw==', 0x724b6d6c574e65544b5131594d62734847454d5452413d3d, NULL, NULL, NULL, '1', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(54, 2921, 'GUERN', 'Jean-Luc', 1, 2, 'jean-luc.guern@sdis29.fr', 'JGUER', 'jGUER', 'YjA2MTA1OGMwZWJkZTkxNzJhNDZlMzhjYWJlMWRjNmM4YWI2YWU3ZTM0ZDM4NWJkY2Q1NWFlNDll\nZWY2ZDRkMA==', 0x32316132686b34552b686233535a4847644d735a35513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(55, 2922, 'MOREAU', 'Jean-Pierre', 2, 1, 'jean-pierre.moreau@sdis29.fr', 'JMORE', 'jMORE', 'NGVlY2ExN2U3YmFkY2ZlYTlkNDdjNjIwZWFiNDY0MGUyNjExNGRlZjM0Yzc2ZjI2NDQ0NGZmNzIw\nMTAwM2E2NQ==', 0x4e664d6256665167724367766b7463363044375a2f513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(56, 2922, 'HERVIOU', 'Patrick', 1, 2, 'patrick.herviou@sdis29.fr', 'PHERV', 'pHERV', 'YmEyMzQwNDYxODRlNmI1ZTM2YThmMjUzM2EzMjdmNmFjOTMwZGEyMjk2Zjc2ZmQ3YWMyZDFmYzI2\nYWJmNGFhZg==', 0x4b7178772f2f614874616348593264686a56742f50413d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(57, 2923, 'MARTIN', 'Nicolas', 2, 1, 'nicolas.martin@sdis29.fr', 'NMART', 'nMART', 'OWY2MWNiMGJhMDA0MjgyY2NiYzZmMmE3Y2MxNDkyZmU4OTExY2NjYjU3MjI0ODBmZmRmMzg0OGY4\nYzZkZWUzNg==', 0x6c6a564630386649516c375a786936363878374359673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(58, 2923, 'GLIDIC', 'David', 1, 2, 'david.glidic@sdis29.fr', 'DGLID', 'dGLID', 'MTAyMTI4MTA2ZjRkMzYxYmVhYjVjMTkzNTdjY2I2MTE1ZTc2MjE2ZjEwZTZlMDcyYTQwZTRlMWJj\nYzVhODM4Zg==', 0x5966736e66456e4f42305a312b326e3376797a3545673d3d, NULL, NULL, NULL, '2', 0, 10, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(59, 2924, 'DURAND', 'François', 2, 1, 'françois.durand@sdis29.fr', 'FDURA', 'fDURA', 'ZWZjOWJkYjQzNDIxMTllZTBjYjliMWNlOWU4YWZjN2E5YmU1Yzg4ZDNlNjBjMjVjYmE5YWJjNjUx\nMTk4MjY1Mw==', 0x7a715536336853756f61724735757a42734a76386f513d3d, NULL, NULL, NULL, '2', 12, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(60, 2924, 'LEGALL', 'Yasmina', 1, 2, 'yasmina.legall@sdis29.fr', 'YLEGA', 'yLEGA', 'ZGYxZjI2M2YyN2FlMjlkMjg3YjZlNzU4NDMyMGRlMDA5YzJmYjAyOTczMWJjODg0YzZkZGY2OTJj\nMjgwNGQ4ZA==', 0x4d6271437257397a335a317861566b337257477976513d3d, NULL, NULL, NULL, '3', 10, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(61, 2924, 'DUBOIS', 'Yves', 1, 2, 'yves.dubois@sdis29.fr', 'YDUBO', 'yDUBO', 'Y2MwM2JmMzJkY2IxOTZjZjc4MDI2ZDMxMTA0ZmI2ZGY5MjQxYTg5ZDE5YTBiZGUwYmM0N2JkOGI0\nZGM4Y2ZiZQ==', 0x6a4b4f67515a7a6e77505a7735524d6a6345676b48773d3d, NULL, NULL, NULL, '9', 14, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(62, 2924, 'MARTIN', 'Alain', 1, 2, 'alain.martin@sdis29.fr', 'AMART', 'aMART', 'NjVkYmViNDAyNTFmMjUxYmI5N2MzM2QzODFkM2YyMTUxZDc3NzhmZmJmYjVjYWNjMmEyN2U2ZGIy\nNmJmOTYwMg==', 0x6e4e4934414f466950333544794d6a664c4f70435a673d3d, NULL, NULL, NULL, '17', 12, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(63, 2924, 'DUPOND', 'Carole', 1, 2, 'carole.dupond@sdis29.fr', 'CDUPO', 'cDUPO', 'YWY1NmQ0YjE0N2ZlNTRlYzRmZWYyYzFkMzQwMTM0N2ZkNjJlN2EyYzA4ZGUzZWE0MTQ3Yjc0MDI1\nNTRhNTkwZA==', 0x4b396c4f312b56416f41574f4e49706f625056647a673d3d, NULL, NULL, NULL, '4', 10, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(64, 2924, 'YAYAOUI', 'Pierre', 1, 2, 'pierre.yayaoui@sdis29.fr', 'PYAYA', 'pYAYA', 'NDMyNGI3NjhhOGU3YzQ0OGNmODVkMTcwNzc4OWFiMmY3ZDNmOTVhMDZiNDVmYjI0OTMyN2UzYjVm\nOTczMDhhNA==', 0x68784f576c33774e484f474d3943494b657a38322f513d3d, NULL, NULL, NULL, '11', 10, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(65, 2924, 'CARETTE', 'Patrick', 1, 2, 'patrick.carette@sdis29.fr', 'PCARE', 'pCARE', 'OTI4NzY2NTI1MWJmN2ZmOTE2N2U1Y2QzZGI0YjViOGQ1MGQ3N2NmNDVlMWVjZTA0OTZmZjk3OTlj\nYTY0MjdhMw==', 0x4e73634e67676d57306a66334c45627a502b436457773d3d, NULL, NULL, NULL, '12', 2, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(66, 2924, 'FERNANDEZ', 'Henri', 1, 2, 'henri.fernandez@sdis29.fr', 'HFERN', 'hFERN', 'ZDgxZmY0YzMyZjg4NTc1ZjNlOWVmMWZhMDFjYTQ2YzkyOTczOTViNjY1YjExN2UzNTViMjhlMDk0\nZThjOTAwMw==', 0x6e50326a514b5831466e4d6c466b414d6251594a52673d3d, NULL, NULL, NULL, '18', 14, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(67, 2924, 'CABON', 'Yohann', 1, 2, 'yohann.cabon@sdis29.fr', 'YCABO', 'yCABO', 'ZTBiNDc1MmNmYmYzODZhZGY2NGExMTY4MjE3MjZiMDlhOGZkYzY2MGYwNmVhYWRkZmMxMGNhNzM5\nZWE0MWQ5Mg==', 0x556c6759693335694843467a344d46764447722f63773d3d, NULL, NULL, NULL, '6', 12, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(68, 2924, 'BRETON', 'Joëlle', 1, 2, 'joëlle.breton@sdis29.fr', 'JBRET', 'jBRET', 'OWI2OTYyY2UzZjM0OTE1ZTljMzhhNGJhYmY0MWExM2M5ZjhmYzA0ZjA4Y2JjMzJiMmVjZTgxNDI0\nYTJjYWZhYQ==', 0x306b4c71533879444f3038504f704d52352b577673413d3d, NULL, NULL, NULL, '5', 14, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(69, 2924, 'DUJARDIN', 'Alex', 1, 2, 'alex.dujardin@sdis29.fr', 'ADUJA', 'aDUJA', 'MGU3MmVmZGIzOWJlNzBiMWJhMDEwYTFhNGVkMjRiZTllMDUwYTRjZjc2ZjQwZDliYmY5MGRjNjgw\nNWY1ZmYwZA==', 0x5a4258756245466139727a6a2f48326a646d45794b773d3d, NULL, NULL, NULL, '10', 11, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(70, 2924, 'CLÉBERT', 'Marc', 1, 2, 'marc.clebert@sdis29.fr', 'MCLÉB', 'mCLÉB', 'OWUwZDAyZDZkMDU0OWY2N2VkMTk0ZWY2NmU5Njg4MDA1N2Y2NTY2ZGJlMjE0M2U5YWY1ZWE0Y2U3\nNzRhMGViZQ==', 0x387739664a6f2f396d687a7a517674676956772f61413d3d, NULL, NULL, NULL, '19', 10, 0, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(71, 2924, 'MASSON', 'Nicolas', 1, 2, 'nicolas.masson@sdis29.fr', 'NMASS', 'nMASS', 'MWNhODg2ZjU1ZDFkNzdiMDYxMDg1MzcwNjFmZTU3NGU4NzA4ZWE0MDk4NGViYzFhMGM3ZmE1NjUy\nYjU5NzBlOQ==', 0x72666e67716b354169453032573642413174636a53773d3d, NULL, NULL, NULL, '13', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(72, 2924, 'CORNIC', 'Patrick', 1, 2, 'patrick.cornic@sdis29.fr', 'PCORN', 'pCORN', 'NGYxNWYyY2Y0OGNjYzAyYmRmMGU3MjgzNDAwY2ZjYWE0NGFmMTdlYTliMDUyN2Q2YTMzYjRkNDkx\nMWY0YzJhOA==', 0x2b66397653696a3137614e67366f753552786c7471513d3d, NULL, NULL, NULL, '14', 0, 4, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(73, 2925, 'LE FUR', 'Pierre', 2, 1, 'pierre.le_fur@sdis29.fr', 'PLE F', 'pLE F', 'MmZlNzRkYmQyZDk3MGVhNzExZmNiNGNiZjUxYTMyMjI3MGMzN2E5MWQ5MjZlZDRiNDQ2MGNmYzQ0\nNWNjNTk0Nw==', 0x36516363676a4277526a6469727157782b744a4973673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(74, 2925, 'BOUCHER', 'Jean-Paul', 1, 2, 'jean-paul.boucher@sdis29.fr', 'JBOUC', 'jBOUC', 'MjU0MzlkODYzOTQ3NTRjNDIwODVmOWRlMjRmODY2MGFjNTRjNjdiNWRmMDQ2NjQ4ODVlNjY3OGM0\nNDFmZTIxNw==', 0x66574f57723174384b6e4c4c644877346634794a33513d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(75, 2926, 'SALAUN', 'Yvon', 2, 1, 'yvon.salaun@sdis29.fr', 'YSALA', 'ySALA', 'NzI2NDRmMmU4NzRhZjY2ZDliMDA5NzVmMTVjN2M4YmI1MDhhYTg1YmI2ZTQ3MmZmNzJhMmY4YTNl\nMzUwZDZmZA==', 0x694666764b51776669623369585747694348523132413d3d, NULL, NULL, NULL, '1', 0, 3, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(76, 2926, 'LEROU', 'Philippe', 1, 2, 'philippe.lerou@sdis29.fr', 'PLERO', 'pLERO', 'ZGI4MTEzODcwMmE2MDMxMTA2ZTI0YzZiNzIyMDU1YTIxYzRmMTkwNTA1ZDNmMGMxNWIxMjEwNzhl\nNjNiMDI1MA==', 0x325a693754355254414d4d51372b73443946755733673d3d, NULL, NULL, NULL, '2', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(77, 2926, 'BODILIS', 'Marc', 1, 2, 'marc.bodilis@sdis29.fr', 'MBODI', 'mBODI', 'MWVlZDA0NWEzMzE3M2QzMDc1OWQ3ZmU5MWQ2MTk3YmFlZGFlMGQxNWEwMTZhMGU3NTY0YThiMmMz\nMzdjN2ZkOQ==', 0x7348595a455870713335567130694f795a6b456873413d3d, NULL, NULL, NULL, '3', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(78, 2927, 'PUIL', 'Thierry', 2, 1, 'thierry.puil@sdis29.fr', 'TPUIL', 'tPUIL', 'MDE2M2Y5MTJhYzdjODRiOTE5ZjYxNjdiMWU1NmRkZDU4YzFlMGFiYTk3ZTEzZDMxZTdhNzIzODFh\nZDgzOTVhNg==', 0x74722b5474555a696e52356976747a5a7778317161413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(79, 2927, 'FOLGALVEZ', 'Jean-Pierre', 1, 2, 'jean-pierre.folgalvez@sdis29.fr', 'JFOLG', 'jFOLG', 'YWU0YTQ4NWU4ZjM0MzJjZTdiZTk3MGM0ZjRmMzRkNTNhMTYzMzFiYjY0NTg0MDY3ZTRkMWM1NGNi\nZTllMDFjMQ==', 0x3466455a64416b703074642f746434734965777672673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(80, 2928, 'L\'HOURRE', 'Christian', 2, 1, 'christian.lhourre@sdis29.fr', 'CL\'HO', 'cL\'HO', 'NTA1Nzk1MWExM2U5ZThiNDBiZDU3NmYyZThkNmJlOGEzMjk3ZDliYmU2NzE3YTA4YWUxM2VlMmI0\nZDU5MmU2YQ==', 0x545145343269544a5655304c394146786b34454b77673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(81, 2928, 'MARZIN', 'Roland', 1, 2, 'roland.marzin@sdis29.fr', 'RMARZ', 'rMARZ', 'MDI4ZTY3YTZlY2EwZWZmOTJjM2ZkMjZlM2ZkODg5YjM3ZGU2MGU4YTk1ZmNiOGUxZjQ3YjY1ODYx\nYzg4ZDZmNg==', 0x3970356a6f2b786765723866416b47454837767435513d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(82, 2929, 'SALAUN', 'Mickael', 2, 1, 'mickael.salaun@sdis29.fr', 'SMICK', 'sMick', 'YzlhYmIyZWU4Nzg2NWZmYWVlZjY0MzkxOTQ5ZDRkMjhiNmJjODJhZGU4MjE5ZWIwNGM2MTM5ZTY4\nZGM4ODZkOA==', 0x3639536b776c6571444c534e6c4350563659325958673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(83, 2929, 'GUEDES', 'Ambroise', 1, 2, 'ambroise.guedes@sdis29.fr', 'AGUED', 'aGUED', 'YTM1OWIzZjM4MzI4YmE4ZDEyN2FmMDZhNjg3OGNlNjE1Yjg4NTBmZWQ3MGJiNmMxMmM2NGIyZmVh\nOGI0YTEyZQ==', 0x36775432594c33545553754a30345441483871314e513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(84, 2930, 'JOLIVET', 'Patrick', 2, 1, 'patrick.jolivet@sdis29.fr', 'PJOLI', 'pJOLI', 'MTJhNmExZGY4MjRlYzI5YWM1YjAyYjE4NDI1MmE5NDE5OGZhMjg1N2VjYzBlNTQyNjAyNzZlNzJj\nYTYyY2Y4YQ==', 0x6753562b48734b6d4b4d5349433555547278494241513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(85, 2931, 'BERTRAND', 'Lionel', 2, 1, 'lionel.bertrand@sdis29.fr', 'LBERT', 'lBERT', 'N2RkNDE2MTExMjA4ZDk2ZTk3YTAxZWE0YTdkMjBjZjFiNTE3NDU1MGVkYmQ3MDk2MDE0YTM1ZjRm\nOTFkOTA2ZQ==', 0x666d416b476359646a654c354a66525a7047653941773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(86, 2931, 'ABIVEN', 'Pierre', 1, 2, 'pierre.abiven@sdis29.fr', 'PABIV', 'pABIV', 'MzBiNzRlNWE0ODk1MmU1NmIzMWMzNzQxMmU3ZDNhMzdhMjliNWQ1ZWM1NDU4MTNlNTJhMmM3NmFj\nZjAwNGFjOQ==', 0x745057794c4267685862766d306f542f564a516574413d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(87, 2932, 'BENOIT', 'Yves', 2, 1, 'yves.benoit@sdis29.fr', 'YBENO', 'yBENO', 'MzkyNzA2NjI1YzAxNjc2YmMzNjAwZjVjMmYyYTI0ODQ5MzUzMzE0YTU4NjI3NzQzYzkwZjYyYjlj\nNjExOWNmZg==', 0x702f323053732b355969534c396a6c774c3441534a773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(88, 2932, 'BOLZER', 'Emile', 1, 2, 'emile.bolzer@sdis29.fr', 'EBOLZ', 'eBOLZ', 'NzRkNzdmNGZlYjhlMjI3YzMwMDc0ODUzMTUwNzkwODJjOTZlYzA1Y2YzZjdiN2QxMTBhNjIwYTUy\nYzhjM2JhOQ==', 0x5a4974497456695146514b61437657667051423446513d3d, NULL, NULL, NULL, '2', 0, 10, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(89, 2933, 'SPAGNOL', 'Joël', 2, 1, 'joël.spagnol@sdis29.fr', 'JSPAG', 'jSPAG', 'NTFhZjUwNDEwMmUzYjVmYzMwMjZhNjJhY2IxNDdiMTk4MDBjOGJhMTc4OGY4NmMxNjUyOTk2ZmM2\nYzVmYTg0NQ==', 0x513779435341574a434e656370326138575a643136673d3d, NULL, NULL, NULL, '1', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(90, 2933, 'THOMAS', 'Nicolas', 1, 2, 'nicolas.thomas@sdis29.fr', 'NTHOM', 'nTHOM', 'YjkwYTZmY2Y3NmNmZWRhMGM2MTc0ZjRkN2YxNTJiMDk5NWE4YjgyMmYxMGZiZjdmYzhhMDM1NDVh\nMTU5ZDFjZg==', 0x4f68624b622f592f56744362682f5a4a62582f5368513d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(91, 2933, 'MORVAN', 'Daniel', 1, 2, 'daniel.morvan@sdis29.fr', 'DMORV', 'dMORV', 'NDE4YjgzNTBhMTVhNmVjNzgxNmVhNTBkOTlmMmYzZGEyYmI3YWZjZmFmNzU0YjhlOTJmOGRiMmI0\nM2M2Y2VkOA==', 0x35514f544b41303977786350536330763332517841773d3d, NULL, NULL, NULL, '3', 0, 10, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(92, 2934, 'LE DUIGOU', 'Christian', 2, 1, 'christian.le duigou@sdis29.fr', 'CLE D', 'cLE D', 'NjFmNmM0MmYxMjc2ZGMyNGEzZGIxMWM0NWZmZmIxMDlkM2Y5ZmE2MDI5M2QxMjhlM2Q1MGI5MjY3\nZGUwYWQxNg==', 0x69366c35434b4e427879355678305152516138486e673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(93, 2934, 'LE NOC', 'Arnaud', 1, 2, 'arnaud.le_noc@sdis29.fr', 'ALE N', 'aLE N', 'NThkM2M2ZjQ0NTA4MDVjNGU5YTEzN2FkODBlYjA3MGU4YzdkYmU4OTlkODdhYjhjYzBmMGRlZGVj\nYWMyZDdjYQ==', 0x6578776e33626173344e3279547768374670744155513d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(94, 2935, 'LE DOZE', 'Serge', 2, 1, 'serge.le_doze@sdis29.fr', 'SLE D', 'sLE D', 'YmNkZDgwZWE4ODZhMDg4M2YzMzVjNTZkMzVkNTE4ZmRjNWY3ODgzNDYwZDBjYmZjZWJhMDEwMGVl\nMmVmYTJjZA==', 0x6c48644d347a4e5450524e754a66764271412b7754513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(95, 2935, 'MARCEUL', 'Patrick', 1, 2, 'patrick.marceul@sdis29.fr', 'PMARC', 'pMARC', 'ZDk0MzI2YTU3OWY5MTZkYThkYzJmNDRjODM4YzdmNWU1NWM1ZmZmMTc2MzVlOWU1MWQ2MTYwZDdj\nMGYyNWU4NQ==', 0x746a433270463834745a666c662b70442b58426f78773d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(96, 2936, 'MOSES', 'Didier', 2, 1, 'didier.moses@sdis29.fr', 'DMOSE', 'dMOSE', 'ZDczMjk2NGVhMWMxYjRiZmI4NzZhM2Q4M2NlNDU5NDRiN2M0NmI3YjM2N2Y2NWE4NGY3YzkxNDZl\nZDhjNzZiNQ==', 0x6b445958556e786f736158664d6b52565845425539513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(97, 2936, 'LECLÈRE', 'Jean-Raphaël', 1, 2, 'jean-raphaël.leclère@sdis29.fr', 'JLECL', 'jLECL', 'NWZkMzVjOGRiMWMwM2U1Mjg1MzE0ZjE5NjMyNzc0MGVlYzU3ZmNlN2QyMzc0NDgzZmIyODIyZGY0\nNDQ5YzgzZg==', 0x656876787059556c3358626f792b58495266707570413d3d, NULL, NULL, NULL, '2', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(98, 2937, 'GLOAGUEN', 'Christophe', 2, 1, 'christophe.gloaguen@sdis29.fr', 'CGLOA', 'cGLOA', 'MzUyNzM1OGUzMmI3NjYyMzk1ZjdiMDI5ZjEwYzc2MjVlZDhmZjBjNGI4MzI1ZTVlNjkzMzk1OTNk\nMTgzMjE0NA==', 0x722b48385945516f5a7737367949473575446d6c38673d3d, NULL, NULL, NULL, '1', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(99, 2937, 'STEPHAN', 'Bertrand', 1, 2, 'bertrand.stephan@sdis29.fr', 'BSTEP', 'bSTEP', 'YmIyMzQxNjMzMjA4MTU1NGYwOWNiNzY5MWQyMDQwOTEyOGQxMzA0NmNkYjVkNGE4MmI2MzhlMWRh\nZWFmYWVmZg==', 0x735a47686178593131474d5753334f4e624963394f673d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(100, 2938, 'QUERE', 'Mickaël', 2, 1, 'mickaël.quere@sdis29.fr', 'MQUER', 'mQUER', 'NDM4OTQ3MzUyYjMxN2E2NjNmMDAxMmRmOTYzNGNkMmI0NTNhZDJlMGY1MjI4MTYxMDE0ODExNjMw\nYjNlMzBmZA==', 0x67674261322b684a427744434e514c354b57684e33773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(101, 2938, 'CORCUFF', 'Thierry', 1, 2, 'thierry.corcuff@sdis29.fr', 'TCORC', 'tCORC', 'MWU1ZTI4Y2IwNmUxYjZiNDQ2MjMwNzkzZTkwZDk1ZmJlNDdjODM1MDM0NDViZDliODBlZjg5NmEx\nMWZiZDU0NA==', 0x363658667a3936325235696d79447731515838506d673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(102, 2939, 'LEVER', 'Olivier', 2, 1, 'olivier.lever@sdis29.fr', 'OLEVE', 'oLEVE', 'YThmNGRmYWU3ZjNlMzVlMjVjMThlYTUwMTE2M2E0NmEzMDI4ZDI3NzQ1ZjQ2ZTVjYzg2MTg4MWNk\nOGI2N2JmMA==', 0x6574434c714e4661776443664a66724e6a2f543157513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(103, 2939, 'SEVELLEC', 'Serge', 1, 2, 'serge.sevellec@sdis29.fr', 'SSEVE', 'sSEVE', 'YWUwYjk0NzY0YjEwNjM3NDYyZGFmMGRlNjE2NWFlMGIwNjkyMDY4ZjdiZGJlNThkMDk0ZWE5Y2Mx\nYWJiMmUzYw==', 0x5947625a46582f54706b71334b694d664c4c696b47773d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(104, 2940, 'KERVEC', 'Philippe', 2, 1, 'philippe.kervec@sdis29.fr', 'PKERV', 'pKERV', 'YmVlMDM1YjIzNDlmN2QyZjNlOTQ4ZjM3YThmZTYyNDc1NzliM2UyYzJmMDQyZTAzNmJmNzEwMjkw\nZmY2YzFmOA==', 0x414d2f5532502b4e574c70715a4f38524b64497956773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(105, 2940, 'LE COSSEC', 'Stéphane', 1, 2, 'stéphane.le cossec@sdis29.fr', 'SLE C', 'sLE C', 'N2RmODFmYmE4NmUxMThhZWUxN2UwNjljMjA0MzA2NjY4YTdhZTAwZTA0YmFhYjg3NzNkNGVkYTJi\nMjZmY2E1Yg==', 0x75576c4158645a336f33704c74736d50384a327262413d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(106, 2941, 'BLERIOT', 'Sylvain', 2, 1, 'sylvain.bleriot@sdis29.fr', 'SBLER', 'sBLER', 'NGM2NjIzODNhNmMyYmQzMWFjOTlmNWI2NWYxZTYyNzU3YzVjODY5Y2ZhODU1YWZlYmRjNzI0OGU3\nNTBjYjE5MA==', 0x474e6c7a2b4a5547487075624a666933474e52466e413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(107, 2941, 'LAGADIC', 'Philippe', 1, 2, 'philippe.lagadic@sdis29.fr', 'PLAGA', 'pLAGA', 'NzlmZTQ0YWIzZDJlYWY1OGMzYWEyYmZjZmUwZDM2MjY0N2YwMjFiNmQwYzgzNjJhMThkNWU4Mjk2\nYWQxZjM3YQ==', 0x5179626b6a49534e6d353072736a382f6762795544673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(108, 2942, 'RIOUAL', 'Johann', 2, 1, 'johann.rioual@sdis29.fr', 'JRIOU', 'jRIOU', 'NWUwZTlmYmZjZmE1Y2MyNzlkZDdiODMwN2MyMmExZjM4NzVkODY4MmE3ZjRmODQwNjYyNjRjYTZi\nOWFjMTU5NQ==', 0x55663943586b41456446463072357854582f563965413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(109, 2942, 'QUINIOU', 'Arnaud', 1, 2, 'arnaud.quiniou@sdis29.fr', 'AQUIN', 'aQUIN', 'ZjY4MDEwNGVmNGExYTE3ZDAwNGUzM2QxZGY0ZTNiNzZiMWM5MDcwZjJhMGZhOTgyNmNkODM0Yjg2\nNDUwN2I1OA==', 0x45696868675a36524e386b585755544c6d416d3755513d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(110, 2943, 'NORMANT', 'Philippe', 2, 1, 'philippe.normant@sdis29.fr', 'PNORM', 'pNORM', 'YWFiODgzMmUzZTVhZmRlMDk0NTc2Yzc5MzY2ZjJjZmM1MmY1ZTEwNDk0MjQ3Njk4MjZlMjQ3NzQz\nNmI1NjZhNA==', 0x774971704c637a564942527a6a49455a7662315073773d3d, NULL, NULL, NULL, '1', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(111, 2943, 'BONNIN', 'Antoine', 1, 2, 'antoine.bonnin@sdis29.fr', 'ABONN', 'aBONN', 'Y2Y2MzAwNTVkNDdjYzZkODY3MzRmMzY2YTdhOThjNzZkMTQ4Y2QxNmE3NmFhYWIzMzU4NWFhMmM1\nNDVkZDhlMg==', 0x5a496e63783943434d6d75614b66395a7a714d6e68773d3d, NULL, NULL, NULL, '2', 0, 10, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(112, 2944, 'QUEFFEULOU', 'Mickaël', 2, 1, 'mickaël.queffeulou@sdis29.fr', 'MQUEF', 'mQUEF', 'ZmY5ZWYwZjZlZjkyYzAxNjY3MWRhYmJhNmJkZTgxZWVkZGUzYTNkZDRiZTRmN2ViZGFmNWU2ZGNk\nMTAzMDg1OQ==', 0x325a71387a355055505a64414c7942306348703132413d3d, NULL, NULL, NULL, '1', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(113, 2944, 'LE DUFF', 'Guy', 1, 2, 'guy.le_duff@sdis29.fr', 'GLE D', 'gLE D', 'YmQ5MjkwODgxNzNjZmNjMjJkYjE2MmE3OTJlZjFkZGY1OTA2NWFiYzY4NDE0ZDg4NzBmZDE3MjE0\nMjBmY2I0MA==', 0x4f37676b49497331466f475272467671734d305156513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(114, 2945, 'COQUIL', 'Jean-Yves', 2, 1, 'jean-yves.coquil@sdis29.fr', 'JCOQU', 'jCOQU', 'MWE2M2M4NTJkMTRlOTI0NTUyN2QyNzM5N2YwN2U4OTY1NzU1ZmMzMDU5MWZiNDkxNWZiNmIyMWFm\nMTg2MmZiNg==', 0x3956447153576d6a77672f6174557250576e515279413d3d, NULL, NULL, NULL, '1', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(115, 2945, 'REIG', 'Christophe', 1, 2, 'christophe.reig@sdis29.fr', 'CREIG', 'cREIG', 'N2QzYTVmYzY0MjE2YmVlNmU0Y2M5YjdhNGMyM2VjOGUwYmFkM2FiNGMyMDAxZDhhZjliOWVhMWNh\nZTU3NzAwNA==', 0x6f44714534676f61644e436f6753334d4171554879513d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(116, 2946, 'JAMBET', 'Laurent', 2, 1, 'laurent.jambet@sdis29.fr', 'LJAMB', 'lJAMB', 'OWI4YzJkMjRhYTc5NGRiOTNmZmU2OTFlZjgwZDk1OWIyMTUyMmY0ODhmOTVlMzNjNjFjNzdkNTZm\nMGMwYWQxYw==', 0x7863525a356e373262676832775631376431414c4e513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(117, 2946, 'LOAEC', 'Olivier', 1, 2, 'olivier.loaec@sdis29.fr', 'OLOAE', 'oLOAE', 'Nzc3YThlOGE2YWRjNDg0NGRlYWQzZTAxNmM1NzQwNGJmMzZiYzI5MmZhZjA0NzM4Njk2OGUyMWVl\nOGQ3ZmJkZg==', 0x522b75546941537533627176637574434a67396175773d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(118, 2947, 'LE FLOCH', 'André', 2, 1, 'andré.le_floch@sdis29.fr', 'ALE F', 'aLE F', 'YjAwOWUxOGE1MjA0MmJlN2JiMGY5NzhiODZlNmM4OGQ5OGE1OWU3YjE4NjAyZGQyZGFlNWViNDI2\nOWM2OWY2MQ==', 0x392b317867654b31314a64636463634e6f31596a78413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(119, 2947, 'LE GOFF', 'Robert', 1, 2, 'robert.le_goff@sdis29.fr', 'RLE G', 'rLE G', 'OGY2NGE4Njg2ZGI4MzQ1ZDBjYmQ5OTBkMTFjYjFlZmNlNzBmYWNkOGUwMGE4ODVkNmZhMTM2MTlj\nZGYzYWE1NQ==', 0x364743727a647a3879786971746f54774e7172515a413d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(120, 2948, 'POSTIC', 'Bruno', 2, 1, 'bruno.postic@sdis29.fr', 'BPOST', 'bPOST', 'Yzk5Mjk2NjM3ODIzN2Y1NDk4ZjJlMmExYTcyNWRmYjcwZWY0NDI1ZjdmMzU2NTNjY2JkYzk1MzEz\nYzRmOTNlMQ==', 0x615834664961464b6a4b4c61584b75382b31476f4f413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(121, 2948, 'VERNON', 'Claude', 1, 2, 'claude.vernon@sdis29.fr', 'CVERN', 'cVERN', 'ZGQ5ZmNmZWE0YzI0YmI1NjA0YTQzNzcwOWQwOWNjYWNjNWE4NmY5YmI1NDhlZmU2YTE0OTJmODFj\nODU3YjhiZA==', 0x72356138616272785451634677746e75764562347a413d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(122, 2949, 'CREIGNOU', 'Pierre', 2, 1, 'pierre.creignou@sdis29.fr', 'PCREI', 'pCREI', 'NDRkOTJjNjI4YTAzOTk4ZTMzYWQwYzU0MjBlMDY5ZTgwMzMzMDU4NWZlNzI3NTczYTVjY2I2Njlm\nZDNmY2RhZQ==', 0x2f2f7343656b437778564a57583059417863754c57413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(123, 2949, 'BUANIC', 'Christophe', 1, 2, 'christophe.buanic@sdis29.fr', 'CBUAN', 'cBUAN', 'NjQ5Mzg2NjliYTk0MGJjYjk4MTY5ZWM3ODg2Y2E0ODE4NjM1OTE2MzNmOWRiMjkyZjllZjViY2E3\nNzJjNDZiMw==', 0x726270314378764a526c7550335770487339453971773d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(124, 2949, 'ROLLAND', 'Pascal', 1, 2, 'pascal.rolland@sdis29.fr', 'PROLL', 'pROLL', 'OGI4Y2QyMTRkNTNmZmVjMGEwMTZjZmE5YjRjNjkzZTMzZWM4MjlkYWZmNmRlZGZiYTJmMzM5MzI2\nMjA2OTMxMA==', 0x2f464e32484345776f54475963364d42565471794a413d3d, NULL, NULL, NULL, '3', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(125, 2950, 'L\'HELGUEN', 'Jean-Jacques', 2, 1, 'jean-jacques.lhelguen@sdis29.fr', 'JL\'HE', 'jL\'HE', 'MzIxNzM1MDM4MzcyM2MwNGViMGQzYTUzMTkyMWE4MTRmMzg4YzZiNDFkMjQ2NzE0NWYzOWM2YTRm\nODBlY2I4Mg==', 0x6761346e7654482b75617858486d72307573386574773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(126, 2950, 'ANDRO', 'Guy', 1, 2, 'guy.andro@sdis29.fr', 'GANDR', 'gANDR', 'Njk3Zjc3ZDFmNzE5NGQ2NDM0YTRlZmQ3MmIyZWZkMmNlYTM4YjQyNzRlNTI4ZDIzMTNhZTY2ZDY0\nNjM0ODE5Nw==', 0x64335a774555686c6f754d5863595670524c4a7674413d3d, NULL, NULL, NULL, '2', 0, 9, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(127, 2951, 'ROBIN', 'Michel', 2, 1, 'michel.robin@sdis29.fr', 'MROBI', 'mROBI', 'YzQ0ZDljM2ZkYzUyMWJjNWI5NzFkMGI2YmNlMWI5MmE2YmRhNmQwMGIyNGIyNGViMjcxZTZlYWM2\nMWM4Y2Q0OQ==', 0x626859745265717076757742537132323674735862413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(128, 2951, 'MOYSAN', 'Ronan', 1, 2, 'ronan.moysan@sdis29.fr', 'RMOYS', 'rMOYS', 'NTFjMzk0OGI4OWUwNGY3NTY5NWM4OTJhNmEyMzZhNDczYWU5NWY1YTBkOWIzZmVmZDA0OWE2OGIz\nYTUyNTY0NA==', 0x766a715157776f4c3559434a2b7668716339704c53513d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(129, 2952, 'BOURGOIN', 'Géraldine', 2, 1, 'géraldine.bourgoin@sdis29.fr', 'GBOUR', 'gBOUR', 'ZmRmNjdiZGU5ZjVhYzRiZDU4YWZlNTViNmY1YmU2OTI3YTMzYjdlZjVjNTFhN2QyNmFkYWM3YjU3\nZjgxNzFlMA==', 0x4143614b436b615a66394476576b584e63704b6c79413d3d, NULL, NULL, NULL, '1', 0, 6, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(130, 2952, 'RICHARD', 'Timothée', 3, 1, 'timothée.richard@sdis29.fr', 'TRICH', 'tRICH', 'NGYzOTJkYzNhZmYwOWIyZjBjZjc3NzZhYzA5OWI1NWI1YzM3N2U4MGI3ZDRkMzAwNmRiY2UyYTJk\nY2ExZjI3Nw==', 0x5150546364694f3670366c46783044763645574431673d3d, NULL, NULL, NULL, '2', 0, NULL, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(131, 2952, 'MAHOUDO', 'Hervé', 1, 2, 'hervé.mahoudo@sdis29.fr', 'HMAHO', 'hMAHO', 'YzY0MTBjMWNlMTgzNWI3NjEwYzc5MTMyYTg3MGQzMTQ4NDkzOTBkYTk0OGMyNDEzZDgxZDA5Yjg3\nYThkMjQ3Yw==', 0x726b44464a736f3571544d372b6754326f54303353773d3d, NULL, NULL, NULL, '3', 0, 8, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(132, 2952, 'GOURVENNEC', 'Claudine', 1, 2, 'claudine.gourvennec@sdis29.fr', 'CGOUR', 'cGOUR', 'NjljZWIxNTcwNzRiNmI3OGU5MWFmMDc5MmUxN2IzMGIwYmRhNjdiZjYyZThkYzFkZTA5M2UxM2Rl\nNTk4NTc4YQ==', 0x43767068715158566b6c6e7a4272416c6148503237413d3d, NULL, NULL, NULL, '4', 0, 6, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(133, 2952, 'RICHARD', 'Philippe', 1, 2, 'philippe.richard@sdis29.fr', 'PRICH', 'pRICH', 'MzFlMmJhNmFiNWE4ZmRiNGIzZWFmZWFjNWFlYzhjOGMwNDEyNjIwMmRhY2U5ODI5OGE5NThjM2Rh\nOTA1YjdkNA==', 0x5257584a3230354c724a4d39384652563978656530513d3d, NULL, NULL, NULL, '5', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(134, 2952, 'DREAN', 'Matthieu', 1, 2, 'matthieu.drean@sdis29.fr', 'MDREA', 'mDREA', 'YTIwODJiMTBkYjNiMDQzNDc0ODdkOWM5MTQ2NTM2ZDI5ZmJiZDZjYjAyMjA3NjI5OGUxZjExY2U2\nOTllYWEzYg==', 0x65366c72676443396b4d4b4c667655466b50494969773d3d, NULL, NULL, NULL, '6', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(135, 2952, 'TREFAULT', 'Pascal', 1, 2, 'pascal.trefault@sdis29.fr', 'PTREF', 'pTREF', 'ODZjN2JiYWFkOWJlYTViNWUwNzQwOGRhY2YwNmU3NTcyYmE1NTE4ZGMxZWU3MjhlMWUzNTgwMTM4\nOWVjNWE1MA==', 0x36554e714735435256443843792f39644f594c7572773d3d, NULL, NULL, NULL, '7', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(136, 2952, 'REINS', 'Nicolas', 1, 2, 'nicolas.reins@sdis29.fr', 'NREIN', 'nREIN', 'OTZiMzRkZTgxMDJmM2Q0NTYwNjNiYzdiOThmODY0M2YxYjQzODM1N2JjNTFkMmM2M2Y0MmVkN2Jk\nOGVlMzQzZA==', 0x4b45444e3576696e744c4354596c5a4e2f706a4e2f773d3d, NULL, NULL, NULL, '8', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(137, 2952, 'LAURET-CATROS', 'Christine', 1, 2, 'christine.lauret-catros@sdis29.fr', 'CLAUR', 'cLAUR', 'MDgzN2ExMTVjMzBkZjdkYTk4YzE1ODkxZGJlOTNmNDVlZmMzNzljOTMyNWQzNTFjODZmMDYwODhi\nZTA2NzhlOA==', 0x3950436f652b33536c2f5a4b774a3057453952447a673d3d, NULL, NULL, NULL, '9', 0, NULL, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(138, 2953, 'CHEVALIER', 'Fabrice', 2, 1, 'fabrice.chevalier@sdis29.fr', 'FCHEV', 'fCHEV', 'YTM3NzRkNDZiMDU2MDk0NmY1YmY5MGY1YTEzZjI4Njc2NGUxYjc0ZjNjMWNlM2QzMTAzZTk0MDM2\nZWY2N2EyNQ==', 0x6969716345462f43483636342b6d4d315242774e44673d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(139, 2953, 'LANDREIN', 'Jean-Luc', 1, 2, 'jean-luc.landrein@sdis29.fr', 'JLAND', 'jLAND', 'ODJhZWZjZmI5MDEwZWFiYjcxMWE0N2QwNTJjMDI2N2FmZjQ4ZjNjODBkNzJlMDljZDNkZTMzOGU0\nZWU1YjFhNg==', 0x547a455252596e63525939776b4f5a6e6d4b2b475a773d3d, NULL, NULL, NULL, '2', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(140, 2954, 'DREO', 'Jacques', 2, 1, 'jacques.dreo@sdis29.fr', 'JDREO', 'jDREO', 'NjhlYzgzZWZkMjI5NjkxMDYzNTMyZWU5MDM2YmRjOWVjMGYzNDc3YTk1ZWZjMGZmZDY5YzU5ZTFj\nZjllMGMyMg==', 0x6c4d79646e5847434a434f4b715378416c48354232413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(141, 2954, 'GUILLOU', 'Yvan', 1, 2, 'yvan.guillou@sdis29.fr', 'YGUIL', 'yGUIL', 'NzY3MmZjMjE4ZjY5ZGY1ZDYwYjRmOGIyOGQ2M2RmMzcyNjA4OTYyYWQxMDk5YmZmYzYwNTI5YzRm\nMGYyNzE1YQ==', 0x4b55716d58464a55705032346c745547307443415a513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(142, 2955, 'CAUDAL', 'Xavier', 2, 1, 'xavier.caudal@sdis29.fr', 'XCAUD', 'xCAUD', 'YjcyYjQxODZkNDRiNjQyOTg4OTYxOTY4ZmRhNzg2ZjA2NGFiY2M4MmE4OWMwODkwOWNmZjZmNTNm\nYWUzYTU2NQ==', 0x2f74764f3351326b6955556a49764d727955786935513d3d, NULL, NULL, NULL, '1', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(143, 2955, 'FOURRIER', 'Eric', 1, 2, 'eric.fourrier@sdis29.fr', 'EFOUR', 'eFOUR', 'ZjAyNjNiNjE5NGNlMGUwZGVmMTVlY2UxZWQ2MzEzNjZhNmFmYzU0YmNkZTBmYmNhZjc3NGRiN2Yw\nYTQ0NjgxNw==', 0x355476374378504c305476312f7433695554757466513d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(144, 2956, 'MORVAN', 'Didier', 2, 1, 'didier.morvan@sdis29.fr', 'DMORV', 'dMORV', 'OWY4MzQyYmY5NWZlZDA2OTAwZGU3ZTE0Yzg4ZTRkNDdhY2U1YWFmNjU2OWY0YmRjODZhYTZlNTAz\nODg1MDkzOQ==', 0x7a46586b444c754e55717746764238597956447844413d3d, NULL, NULL, NULL, '1', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(145, 2956, 'STEPHAN', 'David', 1, 2, 'david.stephan@sdis29.fr', 'DSTEP', 'dSTEP', 'ODYyMmQ4YzdmNzQ0ZTJjNjliMDNjM2MwYmZmNjMxZTUwNDg5OWZjYjllNWIzZTcyMGNjMTY5OWE3\nZjU0MWExZg==', 0x2f454545587a59576c2b42576677466b333332706e673d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(146, 2957, 'MARTIN', 'Nicolas', 2, 1, 'nicolas.martin@sdis29.fr', 'NMART', 'nMART', 'YjlkYzU5OWU0ZGM5YTBjMTMwOWZiNmIxYjc0M2U3ZTA1YWJiYWExYTNlYzA2Y2ZjM2ExODc5ODE2\nZWJmMmJmYQ==', 0x6f6e554b466e53313651484356782b68432b734f47773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(147, 2957, 'COMBOT', 'Christophe', 3, 1, 'christophe.combot@sdis29.fr', 'CCOMB', 'cCOMB', 'MmU1M2NmZDU3MTEyODE2MTBkOGYzYTkyN2U1MGI5NGQ3MGQ0YmU5ZGJmZjM5NWY0NTUwMzQ2NmYz\nOTU3ZjkyNA==', 0x6b532f3536453364566e7472547878596173613244413d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(148, 2957, 'BOUKELIFA', 'David', 1, 2, 'david.boukelifa@sdis29.fr', 'DBOUK', 'dBOUK', 'ZGIxZmJkNDgzOTg2ZDQ3ZDk1OGIxNGQ2MjQxN2I3Zjk2NzQxNzdhMjBjNTE2NDY0M2JiOWU1ZmM2\nNjVmNjk5Yg==', 0x49664f377a527230315575576c78694c3265727966513d3d, NULL, NULL, NULL, '3', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(149, 2958, 'PELLEN', 'Roland', 1, 2, 'roland.pellen@sdis29.fr', 'RPELL', 'rPELL', 'ZWM1YTNiYTM2YzgxMDRkNWI0MWJiZWI5ZjJmOGVkYjA5YjdmY2QxMzY0YjQyZjNmOTU4NzQ5OWRk\nOGQ2MzliNg==', 0x6f74594b46304232734e2f46446b504f5642413932673d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(150, 2959, 'TREICHEL', 'Bruno', 2, 1, 'bruno.treichel@sdis29.fr', 'BTREI', 'bTREI', 'YzE0ZjRjYmE2NWE3MTMyOTRhNTAwYjk4Yzc0YmJlMTc0NjlkNWE5N2ViNDNlMWU2MzVhMjgwMTk2\nODgwYWJlYQ==', 0x4e78666a4b424731505a42506670796b7a6b7a3943413d3d, NULL, NULL, NULL, '1', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(151, 2959, 'ABGRALL', 'Jean-Michel', 1, 2, 'jean-michel.abgrall@sdis29.fr', 'JABGR', 'jABGR', 'NTljZjA2MTZjYTVlYTlkNDY5MDVhNWFlMjFiODUwYjc3NjgwNDcxNzJlODg1MzkxN2NiYTAxZmYx\nOGE2ZDM4NQ==', 0x4942773756796370744872592b54372f4d634c5333413d3d, NULL, NULL, NULL, '2', 0, 2, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(152, 2960, 'SINIC', 'Philippe', 2, 1, 'philippe.sinic@sdis29.fr', 'PSINI', 'pSINI', 'ODQzZGE3YjE1ZmVlN2EyNGRkZjQzY2VhZWE5ZmYzYWMxNmIzZDZhZDI1YWUzYTA3YzQyZjA0MzE2\nNDJmYjhiZg==', 0x39366e325467646871634f5a527269505877716756673d3d, NULL, NULL, NULL, '1', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(153, 2960, 'SINIC', 'Frédéric', 1, 2, 'frédéric.sinic@sdis29.fr', 'FSINI', 'fSINI', 'NjQyMzc2NTMxOWExMDE3ODMzNTkyMzRhZmY4MzhmNmE0ZTEyZDkxYTU0NjZlZmE2NjBmMmY2MzFl\nZmRiOTdjYQ==', 0x6c7a7447334e5843682f5649766970397943357862773d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(154, 2961, 'LENNON', 'Michel', 2, 1, 'michel.lennon@sdis29.fr', 'MLENN', 'mLENN', 'OTEwYzY3YzQxODQ1MWU2ZTU5YTI4NWM5YTEwYTA2YmE3ZDc0NDIwNDhjZmRjZmEzNGU4ZDRiN2Ez\nMmFmNGQyYQ==', 0x4c4f36473557636256507962384462575a6d725248773d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(155, 2961, 'VIEZ', 'Laurent', 1, 2, 'laurent.viez@sdis29.fr', 'LVIEZ', 'lVIEZ', 'MjdmZTE4ZDRjNzMwM2JjY2RjYTViMGU1NzJhZDBkZjNhMzI5Njg1MWVmNzEyMzRkNjY0Yzk0ZDNm\nNzg5YjhlYw==', 0x5550554a54667171727737612f4641327070484f61413d3d, NULL, NULL, NULL, '2', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(156, 2962, 'JEGOU', 'Patrick', 2, 1, 'patrick.jegou@sdis29.fr', 'PJEGO', 'pJEGO', 'ODRmZTVjNmU3YjIxYjFhNTlhMGU4NTU3Mzc3M2E4ZTVhNzIyMmJjMDViMjhkZmYwNjA0OTBiOWQ2\nZmNlMTM4ZA==', 0x3947425155677a566b414e78666a4b55554d4f6f4c513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(157, 2962, 'MORIZUR', 'Stéphane', 1, 2, 'stéphane.morizur@sdis29.fr', 'SMORI', 'sMORI', 'ZDdkNzRjN2Q5YThiMjk5OTgwMzM4NzVhMTc1OWU4ZTBlZDRmMjlhZDMyODAzMzk5Y2QyMGJjYTI3\nYzRiMGIxOQ==', 0x463171756b41357476624b3847766e766d71365872513d3d, NULL, NULL, NULL, '2', 0, 11, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(158, 2963, 'PICHON', 'Yannick', 2, 1, 'yannick.pichon@sdis29.fr', 'YPICH', 'yPICH', 'MThkMzc3OTFkZWFiNWVkZDI5OTNkNjA3MDkwN2M4MzNiOWYxMDc4ZTVkOGIzZDg0N2MzYzFhYjNl\nNzkzZTcyMA==', 0x6e4e4c544a3366766375735867705768316246386d413d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(159, 2963, 'DANIEL', 'Yannick', 1, 2, 'yannick.daniel@sdis29.fr', 'YDANI', 'yDANI', 'MmU4Y2JlYWQwMDA0Nzk4ZTNmYTE5ODRkYmVmYmU0MjM0ZmQyYmU2M2UxYTQwNTcyNTc0YTQ4ODA2\nNmViYTMxOA==', 0x62786158702b386c5571656b58615869614b694346773d3d, NULL, NULL, NULL, '2', 0, 1, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(160, 2964, 'QUINIOU', 'Christian', 2, 1, 'christian.quiniou@sdis29.fr', 'CQUIN', 'cQUIN', 'Nzg4Yzg5NTE0ZTIwMzljY2M3ZGQ4Yzc0YmFhZTJkOWVmNjg5OWRiY2EwOGVkNGQxZGRhNjFiMTZm\nMDE2YjA3ZA==', 0x584e795457643131364b3639436332417952553457513d3d, NULL, NULL, NULL, '1', 0, 7, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00'),
(161, 2964, 'RANNOU', 'Jean', 1, 2, 'jean.rannou@sdis29.fr', 'JRANN', 'jRANN', 'YTRmZGYxNjczZTJkZjVkNzcxNzM1NjYzMmI5ZWQxZmE5ZTA5N2NhYTk4MTYyMTY3YzE0NTA1ZGQ3\nMjA2YTllNg==', 0x4b335463367a69757943375a5953346e5853707739673d3d, NULL, NULL, NULL, '2', 0, 9, NULL, '2020-09-13 00:00:00', '2020-09-13 00:00:00');


INSERT INTO disponibilite (date_dispo, pompierId, nuit, matinee, apres_midi, soiree)
SELECT 
    DATE_ADD(CURDATE(), INTERVAL (0 - WEEKDAY(CURDATE())) + d.num DAY) AS date_dispo,
    p.id AS pompierId,
    '0', '0', '0', '0'
FROM 
    pompier p
CROSS JOIN 
    (SELECT 0 AS num UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION 
            SELECT 4 UNION SELECT 5 UNION SELECT 6) d;


INSERT INTO disponibilite (date_dispo, pompierId, nuit, matinee, apres_midi, soiree)
SELECT 
    DATE_ADD(CURDATE() + INTERVAL 7 DAY, INTERVAL (0 - WEEKDAY(CURDATE() + INTERVAL 7 DAY)) + d.num DAY) AS date_dispo,
    p.id AS pompierId,
    '0', '0', '0', '0'
FROM 
    pompier p
CROSS JOIN 
    (SELECT 0 AS num UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION 
     SELECT 4 UNION SELECT 5 UNION SELECT 6) d;

--
-- Index pour la table `pompier`
--
ALTER TABLE `pompier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCaserne` (`idCaserne`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `pompier`
--
ALTER TABLE `pompier`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `pompier`
--
ALTER TABLE `pompier`
  ADD CONSTRAINT `pompier_ibfk_1` FOREIGN KEY (`idCaserne`) REFERENCES `caserne` (`id`);

--
-- Suppression de l'attribut mdp de pompier
--

ALTER TABLE `pompier` DROP COLUMN mdp;


--
-- Contrraintes pour la table `disponibilite`
--

ALTER TABLE `disponibilite`
  ADD CONSTRAINT `disponilibite_uniquek_1` UNIQUE KEY (`date_dispo`, `pompierId`);

ALTER TABLE `disponibilite`
  ADD CONSTRAINT `disponibilite_ibfk_1` FOREIGN KEY (`pompierId`) REFERENCES `pompier` (`id`);

--  ----------------------------------------------------------------------------------------------
--  > VUES DES PARAMÈTRES
--  ------------------------------------------------------------------------------------------------

CREATE VIEW statut AS
SELECT indice, libelle FROM parametre
WHERE idType="statAgt";

CREATE VIEW grade AS
SELECT indice, libelle FROM parametre
WHERE idType="grade";

CREATE VIEW personnel AS
SELECT indice, libelle FROM parametre
WHERE idType="typePer";

CREATE VIEW disponible AS
SELECT indice, libelle FROM parametre
WHERE idType="dispo";

--  ----------------------------------------------------------------------------------------------
--  > PROCÉDURE DE HACHAGE AUTOMATIQUE
--  ------------------------------------------------------------------------------------------------

DELIMITER |
CREATE PROCEDURE initMdp (IN pompierId INT)
BEGIN
   UPDATE pompier SET salt = (@s := TO_BASE64(RANDOM_BYTES(16))), mdps = TO_BASE64(SHA2(CONCAT(@s, UPPER(login)), 256)) WHERE id=pompierId;
END |
DELIMITER ;

--  ----------------------------------------------------------------------------------------------
--  > ÉVÈNEMENT D'AJOUT DES DISPONIBILITÉS
--  ------------------------------------------------------------------------------------------------
DELIMITER |
CREATE EVENT IF NOT EXISTS generer_disponibilites_semaine_suivante
ON SCHEDULE
    EVERY 1 WEEK
    STARTS (TIMESTAMP(CURRENT_DATE) 
            + INTERVAL ((9 - DAYOFWEEK(CURRENT_DATE)) % 7) DAY 
            + INTERVAL 1 HOUR)
DO
BEGIN
    -- Lundi prochain
    SET @lundi_suivant = CURRENT_DATE + INTERVAL 
    CASE DAYOFWEEK(CURRENT_DATE)
        WHEN 1 THEN 1  -- Dimanche + 1 jour
        WHEN 2 THEN 0  -- Lundi + 0 jours
        WHEN 3 THEN 6  -- Mardi + 6 jours
        WHEN 4 THEN 5  -- Mercredi + 5 jours
        WHEN 5 THEN 4  -- Jeudi + 4 jours
        WHEN 6 THEN 3  -- Vendredi + 3 jours
        WHEN 7 THEN 2  -- Samedi + 2 jours
    END DAY;

    -- Insérer 7 jours × tous les pompiers
    INSERT INTO disponibilite (date_dispo, pompierId, nuit, matinee, apres_midi, soiree)
    SELECT 
        DATE_ADD(@lundi_suivant, INTERVAL d.num DAY) AS date_dispo,
        p.id AS pompierId,
        '0', '0', '0', '0'
    FROM pompier p
    CROSS JOIN (
        SELECT 0 AS num 
        UNION SELECT 1
        UNION SELECT 2
        UNION SELECT 3
        UNION SELECT 4
        UNION SELECT 5
        UNION SELECT 6
    ) d;
END;
DELIMITER ;

COMMIT;

--  ----------------------------------------------------------------------------------------------
--  > user
--  ------------------------------------------------------------------------------------------------

DROP USER IF EXISTS 'adminBDsdis'@'localhost';
CREATE USER 'adminBDsdis'@'localhost' IDENTIFIED BY 'mdpBDsdis';
GRANT ALL PRIVILEGES ON sdis29.* to "adminBDsdis"@"localhost";

DROP USER IF EXISTS 'adminBDsdis'@'%';
CREATE USER 'adminBDsdis'@'%' IDENTIFIED BY 'mdpBDsdis';
GRANT ALL PRIVILEGES ON sdis29.* to "adminBDsdis"@"%";