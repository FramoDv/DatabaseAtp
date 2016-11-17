/* 1) SELEZIONARE TUTTI I VINCITORI DELLA STAGIONE 2015
	con questa query , vado ad identificare tramite classifica, nome e cognome
	tutti i vincitori di un torneo nell anno 2015. Da notare che la sintassi		
	sottostante è resa possibile dal fatto che, non ho giocatori con cognome 
	uguale nei primi 250 del mondo. Nel caso ce ne fossero stati, una possibile 
	correzzione consisteva nell inserire un campo nome nella tabella torneo, 
	per filtrare i giocatori con stesso cognome. 
*/

SELECT giocatore.classifica, torneo.cogn_vincitore, giocatore.nome , giocatore.nazione
FROM torneo JOIN partecipa ON torneo.citta = partecipa.citta
JOIN giocatore ON partecipa.classifica = giocatore.classifica
WHERE torneo.cogn_vincitore = giocatore.cognome
GROUP BY giocatore.cognome
ORDER BY giocatore.classifica;


/* 2) SELEZIONARE NOME ,COGNOME ,CLASSIFICA DEL NUMERO 1 DELLA CLASSIFICA ATP, SPECIFICANDO QUANTI SONO I TORNEI DA LUI VINTI IN STAGIONE 
	usiamo il count con una ridenominazione per identifiare meglio il campo e gli opportuni join per navigare nel db */

SELECT count( * ) "Vittorie 2015", giocatore.classifica, giocatore.nome, giocatore.cognome
FROM torneo JOIN partecipa ON torneo.citta = partecipa.citta
JOIN giocatore ON partecipa.classifica = giocatore.classifica
WHERE torneo.cogn_vincitore = giocatore.cognome  
AND giocatore.classifica = 1;


/*  3) VOGLIAMO CONOSCERE I GIOCATORI CON WILSON COME SPONSOR TECNICO */

SELECT giocatore.nome , giocatore.cognome 
FROM giocatore JOIN supportato ON giocatore.classifica = supportato.classifica
JOIN sponsor_tec ON supportato.marchio_t = sponsor_tec.marchio_t
WHERE sponsor_tec.marchio_t = "Wilson";


/* 4) SI VUOLE CONOSCERE  LA CIFRA RELATIVA ALL' APPORTO COMPLESSIOVO annuale dello sponsor BNL */

SELECT sum(sponsor_maj.apporto) "TOT.APPORTO BNL"
FROM sponsor_maj JOIN finanziato ON sponsor_maj.marchio_m = finanziato.marchio_m
JOIN torneo ON finanziato.citta = torneo.citta
WHERE sponsor_maj.marchio_m = "BNL" ;


/* 5) Si vuole avere il nome e cognome e nazione degli spettatori non Russi al torneo della città di Mosca */

SELECT spettatore.nome, spettatore.cognome, spettatore.nazione
FROM spettatore JOIN biglietto ON spettatore.cod_f = biglietto.cod_f
JOIN stadio ON biglietto.nome_st = stadio.nome_st
JOIN torneo ON stadio.citta = torneo.citta
WHERE torneo.citta = "Mosca" 
AND spettatore.nazione != "RUS";

/* 6)selezionare citta e nome del torneo che, nel circuito che ha venduto più biglietti . */

SELECT COUNT(*) "biglietti Venduti" , torneo.nome_t 
FROM biglietto JOIN stadio ON biglietto.nome_st = stadio.nome_st 
JOIN torneo ON stadio.citta = torneo.citta
WHERE torneo.data_i BETWEEN '2015-01-1' 
AND '2015-12-28'
GROUP BY (torneo.citta)
ORDER BY COUNT(*) DESC LIMIT 1;

/* 7) selezionare i 10 tornei su cui investire maggiormente il prossimo anno , 
	analizzando i ricavi derivanti dai biglietti
 venduti ed ordinandoli per numero di biglietti venduti */

SELECT 
COUNT(id_b) "biglietti Venduti" , torneo.nome_t , SUM(biglietto.prezzo)
FROM biglietto JOIN stadio ON biglietto.nome_st = stadio.nome_st 
JOIN torneo ON stadio.citta = torneo.citta
WHERE torneo.data_i BETWEEN '2015-01-1' AND '2015-12-28'
GROUP BY (torneo.citta)
ORDER BY COUNT(id_b) DESC LIMIT 10;

/* 8) estendere l analisi precedente alle 5 nazioni più redditizzie per il circuito Atp */

SELECT 
COUNT(id_b) "Tot Biglietti Venduti" , torneo.nazione , SUM(biglietto.prezzo) "Guadagno per Nazione"
FROM biglietto JOIN stadio ON biglietto.nome_st = stadio.nome_st 
JOIN torneo ON stadio.citta = torneo.citta
WHERE torneo.data_i BETWEEN '2015-01-1' 
AND '2015-12-28'
GROUP BY (torneo.nazione)
ORDER BY COUNT(id_b) DESC LIMIT 5;

/* 9) selezionare i 5 tornei principali e più ambiti dell anno , cioè quelli con il price money maggiore */

SELECT torneo.nome_t , torneo.nazione , torneo.citta ,torneo.p_money
FROM torneo
ORDER BY torneo.p_money DESC LIMIT 5;

/* 10) le aziende che supportano i tornei vogliono avere un analisi dei 5 giovani più vincenti in stagione ( max 23 anni ) 
		per indirizzare su di loro le future campagne pubblicitarie */ 

SELECT giocatore.nome , giocatore.cognome , giocatore.eta ,giocatore.titoli
FROM torneo JOIN partecipa ON partecipa.citta = torneo.citta
JOIN giocatore ON giocatore.classifica = partecipa.classifica 
WHERE giocatore.cognome = torneo.cogn_vincitore AND giocatore.eta <= 23 
GROUP BY (giocatore.nome)
ORDER BY (titoli) DESC;

/* 11) ai fini dell assegnazione del premio "miglior giovane",
selezionare nome cognome età il più giovane tra i vincitori di almeno 1 torneo nell anno 2015 */

SELECT giocatore.nome , giocatore.cognome , giocatore.eta ,giocatore.titoli
FROM torneo JOIN partecipa ON partecipa.citta = torneo.citta
JOIN giocatore ON giocatore.classifica = partecipa.classifica 
WHERE giocatore.cognome = torneo.cogn_vincitore 
ORDER BY (eta) LIMIT 1;

/* 12) ai fini dell assegnazione del premio "miglior under30" ,
selezionare nome cognome età il più giovane tra i vincitori di almeno 1 torneo nell anno 2015 */

SELECT giocatore.nome , giocatore.cognome , giocatore.eta ,giocatore.titoli
FROM torneo JOIN partecipa ON partecipa.citta = torneo.citta
JOIN giocatore ON giocatore.classifica = partecipa.classifica 
WHERE giocatore.cognome = torneo.cogn_vincitore 
ORDER BY (eta) DESC LIMIT 1;

/* 13) vogliamo scoprire chi è stato il giocatore più "fortunato" della stagione in termini di incassi 
	cosi da poter calcolare le tasse appropriate sul montepremi vinto LORDO */

SELECT giocatore.nome ,giocatore.cognome, SUM(torneo.p_money)
FROM torneo JOIN partecipa ON partecipa.citta = torneo.citta
JOIN giocatore ON giocatore.classifica = partecipa.classifica 
WHERE giocatore.cognome = torneo.cogn_vincitore 
GROUP BY (giocatore.nome)
ORDER BY (SUM(torneo.p_money)) DESC LIMIT 1;

/* 14)come tutti l Atp è in crisi e vogliamo calcolare per ogni giocatore vincitore di almeno 1 torneo  nel 2015 
	le tasse da versare in base ai guadagni 2015 mostrando il guadagno netto */

SELECT giocatore.nome ,giocatore.cognome, SUM(torneo.p_money), 
((SUM(torneo.p_money) * 20 )/100) AS "TASSA",
(SUM(torneo.p_money) - ((SUM(torneo.p_money) * 20 )/100)) AS "NETTO"
FROM torneo JOIN partecipa ON partecipa.citta = torneo.citta
JOIN giocatore ON giocatore.classifica = partecipa.classifica 
WHERE giocatore.cognome = torneo.cogn_vincitore 
GROUP BY (giocatore.nome)
ORDER BY (SUM(torneo.p_money)) DESC ;

/* 15) selezionare elencando nome e cognome dei , tornei vinti dal numero 1 del monfo nel 2015 
	cosi da capire quanti punti e dove dovrà difendere nel 2016*/

SELECT giocatore.nome ,giocatore.cognome, torneo.nome_t, torneo.p_money
FROM torneo JOIN partecipa ON partecipa.citta = torneo.citta
JOIN giocatore ON giocatore.classifica = partecipa.classifica 
WHERE giocatore.cognome = torneo.cogn_vincitore 
AND giocatore.classifica = 1;

/* 16) contare gli spettatori italiani presenti durante la stagione 
	query banale ma utile a fini statistici. la query verrà utilizzata anche per le altre nazioni */

SELECT nazione , COUNT(nazione) "Tot Italiani"
FROM spettatore
WHERE nazione = "ITA"; 

/* 17) sempre per fini promozionali si vuole scoprire qual è il popolo ( nazione ) più presente nella stagione atp 2015 
	si mostri l elenco dei primi 3 ordinati in base al totale*/

SELECT nazione , count(nazione) "Tot per nazione"
FROM spettatore
GROUP BY nazione
ORDER BY COUNT(nazione) DESC LIMIT 3;

/* 18) si vouole analizzare l afflusso al torneo di un pubblico femminile non superiore ai 30 anni , precisamente al toreno di roma.
		in particolare vogliamo analizzare la correlazione prezzo biglietto - numero acquisti fascia giovane femminile */

SELECT prezzo , COUNT(spettatore.sesso) "TOT biglietti per sesso femminile"
FROM spettatore JOIN biglietto ON spettatore.cod_f = biglietto.cod_f
JOIN stadio ON biglietto.nome_st = stadio.nome_st
JOIN torneo ON stadio.citta = torneo.citta
WHERE spettatore.sesso = "F" 
AND spettatore.eta <= 30 
AND torneo.citta = "Roma"
GROUP BY biglietto.prezzo
ORDER BY COUNT(spettatore.sesso);

/* 19) si vuole sapere qual è lo sponsor più ""facoltoso"(che ha sborsato maggiore denaro nell anno)
	 esclusi BNL ed Fly-Emirates che sono i major sponsor per eccellenza */

SELECT sponsor_maj.marchio_m, SUM(sponsor_maj.apporto) "TOT.APPORTO BNL" 
FROM sponsor_maj JOIN finanziato ON sponsor_maj.marchio_m = finanziato.marchio_m
JOIN torneo ON finanziato.citta = torneo.citta
WHERE sponsor_maj.marchio_m != "BNL" 
AND  sponsor_maj.marchio_m != "Fly-Emirates" 
GROUP BY (sponsor_maj.marchio_m) 
ORDER BY SUM(sponsor_maj.apporto) DESC LIMIT 1;


/* 20) ai fini dell assegnazione del premio a sorpresa "Fedeltà" , si vuole avere una lista dei 100 spettatori che hanno aprtecipato a più tornei
ordinati in modo decrescente */

explain SELECT spettatore.nome , spettatore.eta, spettatore.cognome ,count(id_b) AS "Acquistati"
FROM spettatore JOIN biglietto ON spettatore.cod_f = biglietto.cod_f
WHERE spettatore.sesso = "M" and eta > 50
GROUP BY biglietto.cod_f
ORDER BY count(id_b) DESC LIMIT 100 \G

/* 21) sugli inglese xk sono i + numerosi vogliamo conoscere i 5 brand con maggior appial nei tornei usa per riproporlo nella stagione 2016. Più precisamente vogliamo analizzare 
la propensione degli spettatori ad accedere a tornei sponsorizzati da marchi precisi. analizzeremo per ogni marchio il numero di
spettatori presenti in un torneo dove il marchio faceva da sponsor.  */

explain SELECT 
COUNT(id_b) "presenti" , sponsor_maj.marchio_m 
FROM spettatore JOIN biglietto ON spettatore.cod_f = biglietto.cod_f
JOIN stadio ON biglietto.nome_st = stadio.nome_st
JOIN torneo ON stadio.citta = torneo.citta
JOIN finanziato ON torneo.citta = finanziato.citta
JOIN sponsor_maj ON finanziato.marchio_m = sponsor_maj.marchio_m
WHERE torneo.nazione = "ENG" 
AND spettatore.nazione = "ENG"
AND sponsor_maj.marchio_m != "BNL" 
AND sponsor_maj.marchio_m != "Fly-Emirates" 
GROUP BY sponsor_maj.marchio_m
ORDER BY COUNT(id_b) DESC \G


/* 22) si vuole sapere qual è lo sponsor tecnico che supporta più giocatori nel circuito */

SELECT sponsor_tec.marchio_t , COUNT(sponsor_tec.marchio_t)
FROM sponsor_tec JOIN supportato ON sponsor_tec.marchio_t = supportato.marchio_t
JOIN giocatore ON supportato.classifica = giocatore.classifica
GROUP BY sponsor_tec.marchio_t
ORDER BY COUNT(sponsor_tec.marchio_t) DESC;

/* 23) vogliamo sapere quanti sono gli spettatore più anziani dell anno 2015 */

SELECT COUNT(spettatore.cod_f) "I più anziani" ,spettatore.eta
FROM spettatore
WHERE spettatore.eta = (
	SELECT max(spettatore.eta)
	FROM spettatore);

/* una versione più elegante ed efficiente*/

set  @test = (SELECT max(eta) FROM spettatore)

SELECT COUNT(spettatore.cod_f) "I più anziani" , spettatore.eta 
FROM spettatore  
WHERE spettatore.eta  = @test;


/* 24) vogliamo sapere quanti sono stati gli spettatori con massimo 21 nel 2015 */

SELECT count( spettatore.eta) "Giovani" 
FROM spettatore
WHERE spettatore.eta < 22;

/* 25) vogliamo avere il dato riguardante al biglietto più apprezzato dai giovani,
 in modo da valutare se riproporlo o meno la prossima stagione */

SELECT 
count(biglietto.id_b) "Venduti" , biglietto.prezzo
FROM biglietto JOIN spettatore ON biglietto.cod_f = spettatore.cod_f
WHERE spettatore.eta <= 22 
GROUP BY biglietto.prezzo
ORDER BY COUNT(biglietto.id_b);

/* 26) si vuole premiare il miglior  arbitri della stagione con un assegno che rispecchia il conpenso per le partite arbitrate */

SELECT  arbitri.nome , arbitri.cognome ,arbitri.matricola_ar, 
COUNT( arbitri.matricola_ar) " Finali arbitrate",
(COUNT(arbitri.matricola_ar)* 25000) AS "Compenso_lordo_arbitro#1"
FROM  arbitri JOIN torneo ON  arbitri.matricola_ar = torneo.matricola_ar
GROUP BY arbitri.matricola_ar
ORDER BY COUNT( arbitri.matricola_ar) DESC ;

/* 27) vogliamo sapere quanti spettatori sono stati ai tornei vinti da federer */

SELECT COUNT(spettatore.cod_f) "ROGERIANI"
FROM spettatore JOIN biglietto ON spettatore.cod_f = biglietto.cod_f
JOIN stadio ON biglietto.nome_st = stadio.nome_st
JOIN torneo ON stadio.citta = torneo.citta
WHERE torneo.cogn_vincitore = "Federer";

/* 28) vogliamo conoscere qual è la tv che ha trasmesso più tornei in hd nella stagione 2015 */

SELECT 
COUNT(tv.canale) "Trasmissioni" , tv.canale
FROM tv JOIN trasmesso ON tv.canale = trasmesso.canale
JOIN torneo ON trasmesso.citta = torneo.citta
WHERE trasmesso.canale = tv.canale 
AND tv.hd = 1
GROUP BY tv.canale
ORDER BY COUNT(tv.canale) DESC;

/* 29) i giocatori per scegliere bene lo sponsor tecnico per la prossima stagione ,
	vogliono avere una statistica sgli sponsor tecnici presenti nelle finali come vincitori */

SELECT COUNT(sponsor_tec.marchio_t) , sponsor_tec.marchio_t AS sponsor_in_finale_da_vincitori
FROM sponsor_tec JOIN supportato ON sponsor_tec.marchio_t = supportato.marchio_t
jOIN giocatore ON  supportato.classifica = giocatore.classifica 
JOIN partecipa ON giocatore.classifica = partecipa.classifica
JOIN torneo ON partecipa.citta = torneo.citta
WHERE giocatore.cognome = torneo.cogn_vincitore
GROUP BY sponsor_tec.marchio_t
ORDER BY COUNT(sponsor_tec.marchio_t) DESC;



 

