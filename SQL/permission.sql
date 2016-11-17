/*---------------- gestione permessi ed accessi -----------*/

/* ADMIN 
 	livello che identifica le persone che gestiscono il database. Naturalmente essi avranno ogni tipo di permesso ed accesso.
*/

GRANT all privileges 
ON *.* 
TO ‘admin’@’localhost’ identified by ‘password’ with GRANT option;

/* ADDETTI ALLA MANUTENZIONE ED AGGIORNAMENTO DEL DB 
	livello che identifica coloro che, si occupano degli inserimenti, aggiornamenti e cancellazione dati nel database.
*/

GRANT SELECT, INSERT, UPDATE, DELETE, privileges 
ON Atp.* 
To ‘manutentore’@’esempio.com’ identified by ‘password’;


/* UTENTI 
	livello che identifica persone che hanno accesso parziale al database e con azioni limitate su di esso.
	per motivi di sicurezza , come spesso accade nella realtà, agli utenti vengono rese visibili solo apposite
	viste del Db.
*/

GRANT SELECT privileges 
ON Atp.ViewTorneo, Atp.ViewVincitori, Atp.ViewFinalisti, Atp.ViewStadio, Atp.ViewSponsorTec
TO ‘userTest’@’esempio.com’;


/* ANALISTI & STAMPA AUTORIZZATA 
	persone che per fini statistici o giornalistici hanno bisogno , previa concessione dell Atp di accedere
	all intero db, cosi da poter sottomettere le interrogazioni di loro interesse.
*/

GRANT SELECT privileges 
ON Atp.* 
TO ‘stampaEdAnalisti’@’esempio.com’ identified by ‘password’ ;