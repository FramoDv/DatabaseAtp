/*-------------- VIEW ----------- 
	sono tabelle "virtuali" che condividono lo stesso spazio di memoria della tabella fisica che considerano
 	sono utili per quanto riguarda l' interfacciamento con l' esterno, ma possono essere 
 	pericolosee in aggiornamento perchè si rischia di modificare dati nella tabella originale.
*/

/* ViewTorneo */

CREATE VIEW ViewTorneo AS
SELECT citta, nome_t , p_money , cogn_vincitore , nazione , data_i , data_f
FROM torneo;

/* ViewVincitori */

CREATE VIEW ViewVincitori AS
SELECT  giocatore.classifica, torneo.cogn_vincitore, giocatore.nome , giocatore.nazione
FROM torneo JOIN partecipa ON torneo.citta = partecipa.citta
JOIN giocatore ON partecipa.classifica = giocatore.classifica
WHERE torneo.cogn_vincitore = giocatore.cognome
GROUP BY giocatore.cognome
ORDER BY giocatore.classifica;

/* ViewFinalisti */

CREATE VIEW ViewFinalisti AS
SELECT  giocatore.classifica, torneo.cogn_finalista, giocatore.nome , giocatore.nazione
FROM torneo JOIN partecipa ON torneo.citta = partecipa.citta
JOIN giocatore ON partecipa.classifica = giocatore.classifica
WHERE torneo.cogn_finalista = giocatore.cognome
GROUP BY giocatore.cognome
ORDER BY giocatore.classifica;

/* ViewStadio */

CREATE VIEW ViewStadio AS
SELECT stadio.nome_st ,stadio.citta ,stadio.capienza
FROM stadio;

/* ViewSponsorTec */

CREATE VIEW ViewSponsorTec AS
SELECT sponsor_tec.marchio_t , sponsor_tec.p_iva , sponsor_tec.genere
FROM sponsor_tec;
