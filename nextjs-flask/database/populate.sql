GRANT CONNECT ON DATABASE "moviesearch" TO PUBLIC;

CREATE ROLE movie_user;
GRANT SELECT ON Movie TO movie_user;
GRANT SELECT ON Actor TO movie_user;
GRANT INSERT ON Review TO movie_user;

INSERT INTO Actor(actorID, fname, lname, DoB, since) VALUES
('APacino1940', 'Al', 'Pacino', '1940-04-25', 1967),
('DKeaton1946', 'Diane', 'Keaton', '1946-01-05', 1970),
('AGarcia1956', 'Andy', 'Garcia', '1956-04-12', 1983),
('LThompson1961', 'Lea', 'Thompson', '1961-05-31', 1983),
('MGibson1956', 'Mel', 'Gibson', '1956-01-03', 1976),
('SMarceau1966', 'Sophie', 'Marceau', '1966-11-17', 1976),
('PMcGoohan1928', 'Patrick', 'McGoohan', '1928-03-19', 1955),
('HBogart1899', 'Humphrey', 'Bogart', '1899-12-25', 1921),
('IBergman1915', 'Ingrid', 'Bergman', '1915-08-29', 1932),
('PHenreid1908', 'Paul', 'Henreid', '1908-01-10', 1932),
('HFord1942', 'Harrison', 'Ford', '1942-07-13', 1966),
('SConnery1930', 'Sean', 'Connery', '1930-08-25', 1954),
('ADoody1966', 'Alison', 'Doody', '1966-11-11', 1985),
('SNeill1947', 'Sam', 'Neill', '1947-09-14', 1975),
('LDern1967', 'Laura', 'Dern', '1967-02-10', 1979),
('JGoldblum1952', 'Jeff', 'Goldblum', '1952-10-22', 1974),
('KAllen1950', 'Karen', 'Allen', '1950-10-05', 1978),
('PFreeman1944', 'Paul', 'Freeman', '1944-01-18', 1975),
('MHamill1951', 'Mark', 'Hamill', '1951-09-25', 1969),
('CFisher1941', 'Carrie', 'Fisher', '1941-10-21', 1975),
('CElwes1962', 'Cary', 'Elwes', '1962-10-26', 1979),
('RWright1966', 'Robin', 'Wright', '1966-04-08', 1984),
('MPatinkin1952', 'Mandy', 'Patinkin', '1952-11-30', 1980),
('ASchwarzenegger1947', 'Arnold', 'Schwarzenegger', '1947-07-30', 1970),
('LHamilton1956', 'Linda', 'Hamilton', '1956-09-26', 1980),
('MBiehn1956', 'Michael', 'Biehn', '1956-07-31', 1977),
('JGarland1922', 'Judy', 'Garland', '1922-06-10', 1930),
('FMorgan1890', 'Frank', 'Morgan', '1890-06-01', 1916),
('RBolger1903', 'Ray', 'Bolger', '1903-01-10', 1926),
('THanks1956', 'Tom', 'Hanks', '1956-07-09', 1979),
('TAllen1950', 'Tim', 'Allen', '1950-06-13', 1980),
('APotts1952', 'Annie', 'Potts', '1952-10-28', 1977),
('LDiCaprio1974', 'Leonardo', 'DiCaprio', '1974-11-11', 1989),
('JGordon1960', 'Joseph', 'Gordon-Levitt', '1960-02-17', 1988),
('EPage1987', 'Ellen', 'Page', '1987-02-21', 1997),
('MDamon1970', 'Matt', 'Damon', '1970-10-08', 1988),
('TSizemore1961', 'Tom', 'Sizemore', '1961-11-29', 1989),
('LNeeson1952', 'Liam', 'Neeson', '1952-06-07', 1976),
('BKingsley1943', 'Ben', 'Kingsley', '1943-12-31', 1966),
('RFiennes1962', 'Ralph', 'Fiennes', '1962-12-22', 1985),
('JNicholson1952', 'Jack', 'Nicholson', '1937-04-22', 1957),
('MBrando1924', 'Marlon', 'Brando', '1924-04-03', 1950),
('JCaan1940', 'James', 'Caan', '1940-01-26', 1961),
('ARevolori1996', 'Anthony', 'Revolori', '1996-04-28', 1998),
('FAbraham1939', 'F. Murray', 'Abraham', '1938-10-24', 1971),
('IMcKellen1940', 'Ian', 'McKellen', '1939-05-25', 1961),
('VMortensen1958', 'Viggo', 'Mortensen', '1958-10-20', 1984),
('MFreeman1937', 'Morgan', 'Freeman', '1937-06-01', 1958),
('CBale1974', 'Christian', 'Bale', '1974-01-30', 1986),
('SJohansson1984', 'Scarlett', 'Johansson', '1984-11-22', 1994),
('BGunton1945', 'Bob', 'Gunton', '1945-11-15', 1969),
('KSpacey1959', 'Kevin', 'Spacey', '1959-07-26', 1986),
('GByrne1950', 'Gabriel', 'Byrne', '1950-05-12', 1978),
('CPalmiteri1952', 'Chazz', 'Palminteri', '1952-05-15', 1984),
('KWinslet1975', 'Kate', 'Winslet', '1975-10-05', 1991),
('BZane1966', 'Billy', 'Zane', '1966-02-24', 1985),
('ABening1958', 'Annette', 'Bening', '1958-05-29', 1988),
('TBirch1982', 'Thora', 'Birch', '1982-03-11', 1988),
('BPitt1963', 'Brad', 'Pitt', '1963-12-18', 1987),
('RDeNiro1943', 'Robert', 'De Niro', '1943-08-17', 1963),
('RLiotta1954', 'Ray', 'Liotta', '1954-12-18', 1976),
('JPesci1943', 'Joe', 'Pesci', '1943-02-09', 1976),
('CWaltz1956', 'Christoph', 'Waltz', '1956-10-04', 1977),
('UThurman1949', 'Uma', 'Thurman', '1949-04-29', 1988),
('SJackson1947', 'Samuel', 'Jackson', '1948-12-21', 1972),
('GPaltrow1972', 'Gwyneth', 'Paltrow', '1972-09-27', 1989),
('EFurlong1977', 'Edward', 'Furlong', '1977-08-22', 1991),
('RDowney1965', 'Robert', 'Downey Jr.', '1965-04-04', 1970),
('CEvans1981', 'Chris', 'Evans', '1981-06-13', 2000),
('HLedger1979', 'Heath', 'Ledger', '1979-04-04', 1997),
('AEckhart1968', 'Aaron', 'Eckhart', '1968-03-12', 1992),
('RDuvall1931', 'Robert', 'Duvall', '1931-01-05', 1952),
('LFishburne1961', 'Laurence', 'Fishburne', '1961-07-30', 1983),
('CMoss1967', 'Carrie-Anne', 'Moss', '1967-08-21', 1989),
('ABrody1973', 'Adrien', 'Brody', '1973-04-14', 1989),
('TKretschmann1962', 'Thomas', 'Kretschmann', '1962-09-08', 1984),
('EFox1974', 'Emilia', 'Fox', '1974-07-31', 1996),
('JNicholson1937', 'Jack', 'Nicholson', '1937-04-22', 1957),
('SDuvall1949', 'Shelley', 'Duvall', '1949-07-07', 1970),
('DLloyd1973', 'Danny', 'Lloyd', '1973-01-01', 1980),
('JFoster1962', 'Jodie', 'Foster', '1962-11-19', 1967),
('AHopkins1937', 'Anthony', 'Hopkins', '1937-12-31', 1960),
('SGlenn1941', 'Scott', 'Glenn', '1941-01-26', 1965),
('BWillis1955', 'Bruce', 'Willis', '1955-03-19', 1980),
('HOsment1988', 'Haley Joel', 'Osment', '1988-04-10', 1994),
('TCollette1972', 'Toni', 'Collette', '1972-11-01', 1992),
('JEisenberg1983', 'Jesse', 'Eisenberg', '1983-10-05', 2002),
('AGarfield1983', 'Andrew', 'Garfield', '1983-08-20', 2004),
('JTimberlake1981', 'Justin', 'Timberlake', '1981-01-31', 2000),
('JCarrey1962', 'Jim', 'Carrey', '1962-01-17', 1981),
('LLinney1964', 'Laura', 'Linney', '1964-02-05', 1990),
('EHarris1950', 'Ed', 'Harris', '1950-11-28', 1975),
('MDuncan1957', 'Michael Clark', 'Duncan', '1957-12-10', 1995),
('DMorse1953', 'David', 'Morse', '1953-10-11', 1971),
('MBroderick1962', 'Matthew', 'Broderick', '1962-03-21', 1982),
('JIrons1948', 'Jeremy', 'Irons', '1948-09-19', 1969),
('JJones1931', 'James', 'Jones', '1931-01-17', 1953),
('EWood1981', 'Elijah', 'Wood', '1981-01-28', 1981),
('HJackman1968', 'Hugh', 'Jackman', '1968-10-12', 1973),
('TRobbins1958', 'Tim', 'Robbins', '1958-10-16', 1982),
('MFox1961', 'Michael J.', 'Fox', '1961-06-09', 1977),
('CLloyd1938', 'Christopher', 'Lloyd', '1938-10-22', 1975),
('ENorton1969', 'Edward', 'Norton', '1969-08-18', 1996), 
('HCarter1966', 'Helena Bonham', 'Carter', '1966-05-26', 1983),
('GSinise1955', 'Gary', 'Sinise', '1955-03-17', 1971),
('RCrowe1964', 'Russell', 'Crowe', '1964-04-07', 1986),
('JPhoenix1974', 'Joaquin', 'Phoenix', '1974-10-28', 1982),
('CNielsen1965', 'Connie', 'Nielsen', '1965-07-03', 1984),
('RWilliams1951', 'Robin', 'Williams', '1951-07-21', 1977),
('BAffleck1972', 'Ben', 'Affleck', '1972-08-15', 1984),
('MLaurent1983', 'Melanie', 'Laurent', '1983-02-21', 1999),
('JTravolta1954', 'John', 'Travolta', '1954-02-18', 1972),
('THardy1977', 'Tom', 'Hardy', '1977-09-15', 2001),
('AHathaway1982', 'Anne', 'Hathaway', '1982-11-12', 1999),
('KReeves1964', 'Keanu', 'Reeves', '1964-09-02', 1984),
('EEstevez1962', 'Emilio', 'Estevez', '1962-05-12', 1982),
('MRingwald1968', 'Molly', 'Ringwald', '1968-02-18', 1973),
('JNelson1959', 'Judd', 'Nelson', '1959-11-28', 1984),
('FCoppola1939', 'Francis Ford', 'Coppola', '1939-04-07', 1962),
('RZemeckis1942', 'Robert', 'Zemeckis', '1952-05-14', 1978),
('MCurtiz1899', 'Michael', 'Curtiz', '1886-12-24', 1912),
('SSpielberg1946', 'Steven', 'Spielberg', '1946-12-18', 1969),
('IKershner1943', 'Irvin', 'Kershner', '1923-04-29', 1950),
('RReiner1947', 'Rob', 'Reiner', '1947-03-06', 1984),
('JCameron1944', 'James', 'Cameron', '1954-08-16', 1978),
('VFleming1882', 'Victor', 'Fleming', '1889-02-23', 1919),
('JLasseter1947', 'John', 'Lasseter', '1957-01-12', 1995),
('CNolan1970', 'Christopher', 'Nolan', '1970-07-30', 1998),
('MScorsese1942', 'Martin', 'Scorsese', '1942-11-17', 1963),
('WAnderson1969', 'Wes', 'Anderson', '1969-05-01', 1994),
('FDarabont1959', 'Frank', 'Darabont', '1959-01-28', 1990),
('RAllers1940', 'Roger', 'Allers', '1949-06-26', 1994),
('PJackson1952', 'Peter', 'Jackson', '1961-10-31', 1987),
('BSinger1955', 'Bryan', 'Singer', '1965-09-17', 1988),
('SMendes1961', 'Sam', 'Mendes', '1965-08-01', 1999),
('DFincher1956', 'David', 'Fincher', '1962-08-28', 1984),
('RScott1937', 'Ridley', 'Scott', '1937-11-30', 1977),
('GSant1959', 'Gus Van', 'Sant', '1952-07-24', 1985),
('QTarantino1963', 'Quentin', 'Tarantino', '1963-03-27', 1987),
('JWhedon1964', 'Joss', 'Whedon', '1964-06-23', 2005),
('JHughes1950', 'John', 'Hughes', '1950-02-18', 1984),
('LWachowski1965', 'Lana', 'Wachowski', '1965-06-21', 1996),
('RPolanski1933', 'Roman', 'Polanski', '1933-08-18', 1962),
('SKubrick1928', 'Stanley', 'Kubrick', '1928-07-26', 1951),
('JDemme1944', 'Jonathan', 'Demme', '1944-02-22', 1974),
('MShyamalan1970', 'M. Night', 'Shyamalan', '1970-08-06', 1992),
('PWeir1944', 'Peter', 'Weir', '1944-08-21', 1974);

INSERT INTO Movie(movieID, title, release_date, duration, directorID) VALUES
('TheGo1990', 'The Godfather: Part III', '1972-03-24', '2:42:00', 'FCoppola1939'),
('Backt1989', 'Back to the Future Part II', '1989-11-22', '1:48:00', 'RZemeckis1942'),
('Brave1975', 'Braveheart', '1995-05-24', '2:58:00', 'MGibson1956'),
('Casab1942', 'Casablanca', '1942-01-23', '1:42:00', 'MCurtiz1899'),
('India1989', 'Indiana Jones and the Last Crusade', '1989-05-24', '2:07:00', 'SSpielberg1946'),
('Juras1993', 'Jurassic Park', '1993-06-11', '2:07:00', 'SSpielberg1946'),
('Raide1981', 'Raiders of the Lost Ark', '1981-06-12', '1:55:00', 'SSpielberg1946'),
('TheEm1980', 'The Empire Strikes Back', '1980-05-21', '2:04:00', 'IKershner1943'),
('ThePr1987', 'The Princess Bride', '1987-09-25', '1:38:00', 'RReiner1947'),
('TheTe1984', 'The Terminator', '1984-10-26', '1:48:00', 'JCameron1944'),
('TheWi1939', 'The Wizard of Oz', '1939-08-25', '1:42:00', 'VFleming1882'),
('ToySt1995', 'Toy Story', '1995-11-22', '1:21:00', 'JLasseter1947'),
('Incep2010', 'Inception', '2010-07-16', '2:28:00', 'CNolan1970'),
('Savin1998', 'Saving Private Ryan', '1998-07-24', '2:49:00', 'SSpielberg1946'),
('Schin1993', 'Schindler''s List', '1993-12-15', '3:15:00', 'SSpielberg1946'),
('TheDe2006', 'The Departed', '2006-10-06', '2:31:00', 'MScorsese1942'),
('TheGo1972', 'The Godfather', '1972-03-24', '2:55:00', 'FCoppola1939'),
('TheGr2014', 'The Grand Budapest Hotel', '2014-03-28', '1:39:00', 'WAnderson1969'),
('TheGr1999', 'The Green Mile', '1999-12-10', '3:09:00', 'FDarabont1959'),
('TheLi1994', 'The Lion King', '1994-06-24', '1:28:00', 'RAllers1940'),
('TheLo2001', 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', '2:58:00', 'PJackson1952'),
('ThePr2006', 'The Prestige', '2006-10-20', '2:10:00', 'CNolan1970'),
('TheSh1994', 'The Shawshank Redemption', '1994-10-14', '2:22:00', 'FDarabont1959'),
('TheUs1995', 'The Usual Suspects', '1995-08-16', '1:46:00', 'BSinger1955'),
('Titan1997', 'Titanic', '1997-12-19', '3:15:00', 'JCameron1944'),
('Ameri1999', 'American Beauty', '1999-09-08', '2:02:00', 'SMendes1961'),
('Backt1985', 'Back to the Future', '1985-07-03', '1:56:00', 'RZemeckis1942'),
('Fight1999', 'Fight Club', '1999-10-15', '2:19:00', 'DFincher1956'),
('Forre1994', 'Forrest Gump', '1994-07-06', '2:22:00', 'RZemeckis1942'),
('Gladi2000', 'Gladiator', '2000-05-05', '2:35:00', 'RScott1937'),
('GoodW1997', 'Good Will Hunting', '1997-12-05', '2:06:00', 'GSant1959'),
('Goodf1990', 'Goodfellas', '1990-09-19', '2:28:00', 'MScorsese1942'),
('Inglo2009', 'Inglourious Basterds', '2009-08-21', '2:33:00', 'QTarantino1963'),
('PulpF1994', 'Pulp Fiction', '1994-10-14', '2:34:00', 'QTarantino1963'),
('Se7en1995', 'Se7en', '1995-09-22', '2:07:00', 'DFincher1956'),
('Termi1991', 'Terminator 2: Judgment Day', '1991-07-03', '2:17:00', 'JCameron1944'),
('TheAv2012', 'The Avengers', '2012-05-04', '2:23:00', 'JWhedon1964'),
('TheBr1985', 'The Breakfast Club', '1985-02-15', '1:37:00', 'JHughes1950'),
('TheDa2008', 'The Dark Knight', '2008-07-18', '2:32:00', 'CNolan1970'),
('TheDa2012', 'The Dark Knight Rises', '2012-07-20', '2:45:00', 'CNolan1970'),
('TheGo1974', 'The Godfather: Part II', '1974-12-20', '3:22:00', 'FCoppola1939'),
('TheLo2003', 'The Lord of the Rings: The Return of the King', '2003-12-17', '3:21:00', 'PJackson1952'),
('TheLo2002', 'The Lord of the Rings: The Two Towers', '2002-12-18', '2:59:00', 'PJackson1952'),
('TheMa1999', 'The Matrix', '1999-03-31', '2:16:00', 'LWachowski1965'),
('ThePi2002', 'The Pianist', '2002-09-25', '2:30:00', 'RPolanski1933'),
('TheSh1980', 'The Shining', '1980-05-23', '2:26:00', 'SKubrick1928'),
('TheSi1991', 'The Silence of the Lambs', '1991-02-14', '1:58:00', 'JDemme1944'),
('TheSi1999', 'The Sixth Sense', '1999-08-06', '1:47:00', 'MShyamalan1970'),
('TheSo2010', 'The Social Network', '2010-10-01', '2:00:00', 'DFincher1956'),
('TheTr1998', 'The Truman Show', '1998-06-05', '1:43:00', 'PWeir1944');

INSERT INTO Acts(movieID, actorID) VALUES
('TheGo1972', 'APacino1940'),
('TheGo1972', 'DKeaton1946'),
('TheGo1972', 'AGarcia1956'),
('Backt1989', 'MFox1961'),
('Backt1989', 'CLloyd1938'),
('Backt1989', 'LThompson1961'),
('Brave1975', 'MGibson1956'),
('Brave1975', 'SMarceau1966'),
('Brave1975', 'PMcGoohan1928'),
('Casab1942', 'HBogart1899'),
('Casab1942', 'IBergman1915'),
('Casab1942', 'PHenreid1908'),
('India1989', 'HFord1942'),
('India1989', 'SConnery1930'),
('India1989', 'ADoody1966'),
('Juras1993', 'SNeill1947'),
('Juras1993', 'LDern1967'),
('Juras1993', 'JGoldblum1952'),
('Raide1981', 'HFord1942'),
('Raide1981', 'KAllen1950'),
('Raide1981', 'PFreeman1944'),
('TheEm1980', 'MHamill1951'),
('TheEm1980', 'HFord1942'),
('TheEm1980', 'CFisher1941'),
('ThePr1987', 'CElwes1962'),
('ThePr1987', 'RWright1966'),
('ThePr1987', 'MPatinkin1952'),
('TheTe1984', 'ASchwarzenegger1947'),
('TheTe1984', 'LHamilton1956'),
('TheTe1984', 'MBiehn1956'),
('TheWi1939', 'JGarland1922'),
('TheWi1939', 'FMorgan1890'),
('TheWi1939', 'RBolger1903'),
('ToySt1995', 'THanks1956'),
('ToySt1995', 'TAllen1950'),
('ToySt1995', 'APotts1952'),
('Incep2010', 'LDiCaprio1974'),
('Incep2010', 'JGordon1960'),
('Incep2010', 'EPage1987'),
('Savin1998', 'THanks1956'),
('Savin1998', 'MDamon1970'),
('Savin1998', 'TSizemore1961'),
('Schin1993', 'LNeeson1952'),
('Schin1993', 'BKingsley1943'),
('Schin1993', 'RFiennes1962'),
('TheDe2006', 'LDiCaprio1974'),
('TheDe2006', 'MDamon1970'),
('TheDe2006', 'JNicholson1952'),
('TheGo1972', 'MBrando1924'),
('TheGo1972', 'APacino1940'),
('TheGo1972', 'JCaan1940'),
('TheGr2014', 'RFiennes1962'),
('TheGr2014', 'ARevolori1996'),
('TheGr2014', 'FAbraham1939'),
('TheGr1999', 'THanks1956'),
('TheGr1999', 'MDuncan1957'),
('TheGr1999', 'DMorse1953'),
('TheLi1994', 'MBroderick1962'),
('TheLi1994', 'JIrons1948'),
('TheLi1994', 'JJones1931'),
('TheLo2001', 'EWood1981'),
('TheLo2001', 'IMcKellen1940'),
('TheLo2001', 'VMortensen1958'),
('ThePr2006', 'HJackman1968'),
('ThePr2006', 'CBale1974'),
('ThePr2006', 'SJohansson1984'),
('TheSh1994', 'TRobbins1958'),
('TheSh1994', 'MFreeman1937'),
('TheSh1994', 'BGunton1945'),
('TheUs1995', 'KSpacey1959'),
('TheUs1995', 'GByrne1950'),
('TheUs1995', 'CPalmiteri1952'),
('Titan1997', 'LDiCaprio1974'),
('Titan1997', 'KWinslet1975'),
('Titan1997', 'BZane1966'),
('Ameri1999', 'KSpacey1959'),
('Ameri1999', 'ABening1958'),
('Ameri1999', 'TBirch1982'),
('Backt1985', 'MFox1961'),
('Backt1985', 'CLloyd1938'),
('Backt1985', 'LThompson1961'),
('Fight1999', 'BPitt1963'),
('Fight1999', 'ENorton1969'),
('Fight1999', 'HCarter1966'),
('Forre1994', 'THanks1956'),
('Forre1994', 'RWright1966'),
('Forre1994', 'GSinise1955'),
('Gladi2000', 'RCrowe1964'),
('Gladi2000', 'JPhoenix1974'),
('Gladi2000', 'CNielsen1965'),
('GoodW1997', 'MDamon1970'),
('GoodW1997', 'RWilliams1951'),
('GoodW1997', 'BAffleck1972'),
('Goodf1990', 'RDeNiro1943'),
('Goodf1990', 'RLiotta1954'),
('Goodf1990', 'JPesci1943'),
('Inglo2009', 'BPitt1963'),
('Inglo2009', 'CWaltz1956'),
('Inglo2009', 'MLaurent1983'),
('PulpF1994', 'JTravolta1954'),
('PulpF1994', 'UThurman1949'),
('PulpF1994', 'SJackson1947'),
('Se7en1995', 'BPitt1963'),
('Se7en1995', 'MFreeman1937'),
('Se7en1995', 'GPaltrow1972'),
('Termi1991', 'ASchwarzenegger1947'),
('Termi1991', 'LHamilton1956'),
('Termi1991', 'EFurlong1977'),
('TheAv2012', 'RDowney1965'),
('TheAv2012', 'CEvans1981'),
('TheAv2012', 'SJohansson1984'),
('TheBr1985', 'EEstevez1962'),
('TheBr1985', 'MRingwald1968'),
('TheBr1985', 'JNelson1959'),
('TheDa2008', 'CBale1974'),
('TheDa2008', 'HLedger1979'),
('TheDa2008', 'AEckhart1968'),
('TheDa2012', 'CBale1974'),
('TheDa2012', 'THardy1977'),
('TheDa2012', 'AHathaway1982'),
('TheGo1974', 'APacino1940'),
('TheGo1974', 'RDeNiro1943'),
('TheGo1974', 'RDuvall1931'),
('TheLo2003', 'EWood1981'),
('TheLo2003', 'IMcKellen1940'),
('TheLo2003', 'VMortensen1958'),
('TheLo2002', 'EWood1981'),
('TheLo2002', 'IMcKellen1940'),
('TheLo2002', 'VMortensen1958'),
('TheMa1999', 'KReeves1964'),
('TheMa1999', 'LFishburne1961'),
('TheMa1999', 'CMoss1967'),
('ThePi2002', 'ABrody1973'),
('ThePi2002', 'TKretschmann1962'),
('ThePi2002', 'EFox1974'),
('TheSh1980', 'JNicholson1937'),
('TheSh1980', 'SDuvall1949'),
('TheSh1980', 'DLloyd1973'),
('TheSi1991', 'JFoster1962'),
('TheSi1991', 'AHopkins1937'),
('TheSi1991', 'SGlenn1941'),
('TheSi1999', 'BWillis1955'),
('TheSi1999', 'HOsment1988'),
('TheSi1999', 'TCollette1972'),
('TheSo2010', 'JEisenberg1983'),
('TheSo2010', 'AGarfield1983'),
('TheSo2010', 'JTimberlake1981'),
('TheTr1998', 'JCarrey1962'),
('TheTr1998', 'LLinney1964'),
('TheTr1998', 'EHarris1950');

INSERT INTO Movie_Genre (movieID, genre) VALUES
('TheGo1990', 'Crime'),
('TheGo1990', 'Drama'),
('Backt1989', 'Adventure'),
('Backt1989', 'Science Fiction'),
('Brave1975', 'Historical'),
('Brave1975', 'Drama'),
('Casab1942', 'Romance'),
('Casab1942', 'War'),
('Casab1942', 'Mystery'),
('India1989', 'Adventure'),
('India1989', 'Action'),
('India1989', 'Family'),
('Juras1993', 'Adventure'),
('Juras1993', 'Science Fiction'),
('Juras1993', 'Thriller'),
('Raide1981', 'Adventure'),
('Raide1981', 'Action'),
('TheEm1980', 'Action'),
('TheEm1980', 'Adventure'),
('TheEm1980', 'Fantasy'),
('ThePr1987', 'Romance'),
('ThePr1987', 'Adventure'),
('ThePr1987', 'Comedy'),
('TheTe1984', 'Action'),
('TheTe1984', 'Sci-Fi'),
('TheWi1939', 'Fantasy'),
('TheWi1939', 'Adventure'),
('TheWi1939', 'Family'),
('ToySt1995', 'Animation'),
('ToySt1995', 'Adventure'),
('ToySt1995', 'Comedy'),
('Incep2010', 'Action'),
('Incep2010', 'Adventure'),
('Incep2010', 'Sci-Fi'),
('Savin1998', 'War'),
('Savin1998', 'Drama'),
('Schin1993', 'Biography'),
('Schin1993', 'Drama'),
('Schin1993', 'History'),
('TheDe2006', 'Thriller'),
('TheDe2006', 'Drama'),
('TheDe2006', 'Crime'),
('TheGo1972', 'Crime'),
('TheGo1972', 'Drama'),
('TheGr2014', 'Adventure'),
('TheGr2014', 'Comedy'),
('TheGr2014', 'Drama'),
('TheGr1999', 'Drama'),
('TheGr1999', 'Fantasy'),
('TheGr1999', 'Mystery'),
('TheLi1994', 'Animation'),
('TheLi1994', 'Adventure'),
('TheLi1994', 'Drama'),
('TheLo2001', 'Adventure'),
('TheLo2001', 'Fantasy'),
('ThePr2006', 'Drama'),
('ThePr2006', 'Mystery'),
('ThePr2006', 'Thriller'),
('TheSh1994', 'Drama'),
('TheUs1995', 'Crime'),
('TheUs1995', 'Drama'),
('TheUs1995', 'Mystery'),
('Titan1997', 'Drama'),
('Titan1997', 'Romance'),
('Ameri1999', 'Drama'),
('Backt1985', 'Adventure'),
('Backt1985', 'Sci-Fi'),
('Fight1999', 'Drama'),
('Forre1994', 'Drama'),
('Forre1994', 'Romance'),
('Gladi2000', 'Action'),
('Gladi2000', 'Adventure'),
('Gladi2000', 'Drama'),
('GoodW1997', 'Drama'),
('Goodf1990', 'Biography'),
('Goodf1990', 'Crime'),
('Goodf1990', 'Drama'),
('Inglo2009', 'War'),
('Inglo2009', 'Adventure'),
('PulpF1994', 'Crime'),
('PulpF1994', 'Drama'),
('Se7en1995', 'Crime'),
('Se7en1995', 'Drama'),
('Se7en1995', 'Mystery'),
('Termi1991', 'Action'),
('Termi1991', 'Sci-Fi'),
('TheAv2012', 'Action'),
('TheAv2012', 'Adventure'),
('TheAv2012', 'Sci-Fi'),
('TheBr1985', 'Comedy'),
('TheBr1985', 'Drama'),
('TheDa2008', 'Action'),
('TheDa2008', 'Crime'),
('TheDa2008', 'Drama'),
('TheDa2012', 'Action'),
('TheDa2012', 'Crime'),
('TheDa2012', 'Drama'),
('TheGo1974', 'Crime'),
('TheGo1974', 'Drama'),
('TheLo2003', 'Adventure'),
('TheLo2003', 'Fantasy'),
('TheLo2002', 'Adventure'),
('TheLo2002', 'Fantasy'),
('TheMa1999', 'Action'),
('TheMa1999', 'Sci-Fi'),
('ThePi2002', 'Biography'),
('ThePi2002', 'Drama'),
('ThePi2002', 'War'),
('TheSh1980', 'Horror'),
('TheSi1991', 'Crime'),
('TheSi1991', 'Drama'),
('TheSi1991', 'Thriller'),
('TheSi1999', 'Mystery'),
('TheSi1999', 'Thriller'),
('TheSo2010', 'Biography'),
('TheSo2010', 'Drama'),
('TheTr1998', 'Comedy'),
('TheTr1998', 'Drama');
