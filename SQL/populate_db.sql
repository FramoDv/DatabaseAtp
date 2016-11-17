
/*------------- riempimento arbitri ---------- status :  OK ------------ 250 rec */

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/arbitri/arbitri.csv' 
INTO TABLE arbitri 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0,@1,@2,@3,@4,@5) set matricola_ar = @0, nome = @1,cognome = @2, livello = @3, eta = @4, sesso = @5 ;

/* personalizzati */
insert into arbitri values ('249A' , 'Mohammed' , 'Lhaiani' , 'A' , 56 , 'M');
insert into arbitri values ('250A' , 'Pascal' , 'Mariah' , 'A' , 45 , 'M');


SHOW WARNINGS;

/*------------- riempimento supervisor --------- status : OK ----------- 250 rec */

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/superv/supervisor.csv' 
INTO TABLE supervisor
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0,@1,@2,@3,@4) set matricola_sv = @0 ,nome =@1,cognome = @2, eta = @3, sesso = @4 ;

SHOW WARNINGS;

/*------------- riempimento tv --------- status : OK ---------- 50 rec */ 

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/tv/tv.sql

/*------------ test riempimento Giocatori --------- status : OK ----------- 250 rec*/

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/giocatori/giocatori.txt' 
INTO TABLE giocatore 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
(@0,@1,@2,@3,@4) set classifica = @0 ,nome =@1,cognome = @2, eta = @3, nazione = @4;

SHOW WARNINGS;

/* personalizzati */
update giocatore set titoli = "10" where cognome = "Coric";  
update giocatore set titoli = "7" where cognome = "Thiem";
update giocatore set titoli = "7" where cognome = "Kudla";
update giocatore set titoli = "6" where cognome = "Vesely";
update giocatore set titoli = "10" where cognome = "Zverev";


/* ho generato gli update table con java */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/giocatori/p_money.sql

/* aggiornamenti per dati reali nei to 40  */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/giocatori/tornei.sql

/*------------ caricamento Sponsor_Tec ---------- status : OK ----------  150 rec*/

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/sponsor_t/sponsor_tec.csv' 
INTO TABLE sponsor_tec
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0,@1,@2,@3,@4) set marchio_t = @0 ,sede_leg =@1, p_iva = @2, genere = @3, fatturato = @4;

SHOW WARNINGS;

   /* principali  aggiungi 4 */

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/sponsor_t/principal.csv' 
INTO TABLE sponsor_tec
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0,@1,@2,@3,@4) set marchio_t = @0 ,sede_leg =@1, p_iva = @2, genere = @3, fatturato = @4;


/*------------ caricamento Sponsor_Major ---------- status : OK ---------- */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/sponsor_m/sponsor_maj.sql

/*------------ caricamento Torneo ---------- status : OK ---------- 100 rec */

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/torneo/torneoAll.csv' 
INTO TABLE torneo
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0,@1,@2,@3,@4,@5,@6,@7,@8,@9) set citta = @0 ,nome_t =@1, p_money = @2, cogn_finalista = @3, cogn_vincitore = @4 , nazione = @5 , data_i = @6 , data_f = @7 , matricola_ar = @8, matricola_sv = @9;

/*------------ caricamento stadio ---------- status : OK ----------*/

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi2.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi3.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi4.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi4two.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi5.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/stadio/stadi5two.csv' 
INTO TABLE stadio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3,@4) set nome_st = @0 ,capienza =@1,superficie = @2, tetto = @3, citta = @4;


/*------------ caricamento spettatori ---------- status :ok ---------- actualy 100000 row */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/spett/men.sql /* 49999 uomini */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/spett/women.sql /* 50000 donne */

insert into spettatore values ( 'mntfnc12892abr','Francesco','Monti',21,'ITA','M','Broccostella'); /* insert speciale */


/* --------------- caricamento trasmesso ------------ status : ok -------  rec 4999 */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/trasmesso/trasmesso.sql 

/* --------------- caricamento finanziato ------------ status : ok -------  rec 4999 */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/finanziato/fin.sql 

/* --------------- caricamento supportato ------------ status : ok -------  rec 500  */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/supportato/supportato.sql 

/* --------------- caricamento partecipa ------------ status : ok -------  rec  14236 */

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/partecipa/partecipa.sql 

/* --------------- caricamento BIGLIETTO ------------ status :  -------  rec 100 mila  

source /Users/Framo/Desktop/Programming/Data_sql/Progetto/generati/biglietto/biglietto.sql 

	 nettamente + veloce quest approccio per molti dati */

LOAD DATA LOCAL INFILE '/Users/Framo/Desktop/Programming/Data_sql/Progetto/biglietto1ok.txt' 
INTO TABLE biglietto
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@0, @1,@2,@3) set id_b = @0 ,prezzo =@1,cod_f = @2, nome_st = @3;



