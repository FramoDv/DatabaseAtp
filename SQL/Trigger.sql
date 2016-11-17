/* --------------- TRIGGER ------------- */

/* blocco inserimento spettatori minorenni */

DELIMITER $$

CREATE TRIGGER Alert_Minorenni
BEFORE INSERT ON spettatore
FOR EACH ROW BEGIN

DECLARE msg VARCHAR(255);
	
IF  ( NEW.eta < 18 ) THEN
	set msg = concat('Impossibile inserire nel DB un individuo minorenne, per analisi di mercato, nel rispetto dell articolo 52.');
	signal sqlstate '45000' set message_text = msg;
END IF; 

END $$ 

DELIMITER ;


/* giocatore non può superare un max di 3 sponsor tecnici */

DELIMITER $$

CREATE TRIGGER Sponsor
BEFORE INSERT ON supportato
FOR EACH ROW BEGIN

DECLARE msg VARCHAR(255);

SET @ACTUAL=(SELECT count(supportato.classifica) "num sponsor"  
FROM supportato
WHERE supportato.classifica = NEW.classifica
);

SET @MAX = 2;

IF  ( @ACTUAL > @MAX ) THEN
	@X = NEW.classifica;
	set msg = concat('Troppi sponsor tecnici per il giocatore!);
	signal sqlstate '45000' set message_text = msg;
END IF; 

END $$ 

DELIMITER ;