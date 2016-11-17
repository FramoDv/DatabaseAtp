/* tornei custom primi 40 giocatori */

UPDATE giocatore SET titoli = 54 WHERE classifica = 1;
UPDATE giocatore SET titoli = 23 WHERE classifica = 2;
UPDATE giocatore SET titoli = 90 WHERE classifica = 3;
UPDATE giocatore SET titoli = 22 WHERE classifica = 4;
UPDATE giocatore SET titoli = 70 WHERE classifica = 5;
UPDATE giocatore SET titoli = 16 WHERE classifica = 6;
UPDATE giocatore SET titoli = 13 WHERE classifica = 7;
UPDATE giocatore SET titoli = 12 WHERE classifica = 8;
UPDATE giocatore SET titoli = 10 WHERE classifica = 9;
UPDATE giocatore SET titoli = 8 WHERE classifica = 10;
UPDATE giocatore SET titoli = 6 WHERE classifica = 11;
UPDATE giocatore SET titoli = 7 WHERE classifica = 12;
UPDATE giocatore SET titoli = 4 WHERE classifica = 13;
UPDATE giocatore SET titoli = 7 WHERE classifica = 14;
UPDATE giocatore SET titoli = 3 WHERE classifica = 15;
UPDATE giocatore SET titoli = 3 WHERE classifica = 16;
UPDATE giocatore SET titoli = 9 WHERE classifica = 17;
UPDATE giocatore SET titoli = 5 WHERE classifica = 18;
UPDATE giocatore SET titoli = 7 WHERE classifica = 19;
UPDATE giocatore SET titoli = 4 WHERE classifica = 20;
UPDATE giocatore SET titoli = 6 WHERE classifica = 21;
UPDATE giocatore SET titoli = 4 WHERE classifica = 22;
UPDATE giocatore SET titoli = 4 WHERE classifica = 23;
UPDATE giocatore SET titoli = 4 WHERE classifica = 24;
UPDATE giocatore SET titoli = 5 WHERE classifica = 25;
UPDATE giocatore SET titoli = 1 WHERE classifica = 26;
UPDATE giocatore SET titoli = 3 WHERE classifica = 27;
UPDATE giocatore SET titoli = 4 WHERE classifica = 28;
UPDATE giocatore SET titoli = 3 WHERE classifica = 29;
UPDATE giocatore SET titoli = 1 WHERE classifica = 30;
UPDATE giocatore SET titoli = 0 WHERE classifica = 31;
UPDATE giocatore SET titoli = 1 WHERE classifica = 32;
UPDATE giocatore SET titoli = 2 WHERE classifica = 33;
UPDATE giocatore SET titoli = 3 WHERE classifica = 34;
UPDATE giocatore SET titoli = 3 WHERE classifica = 35;
UPDATE giocatore SET titoli = 2 WHERE classifica = 36;
UPDATE giocatore SET titoli = 4 WHERE classifica = 37;
UPDATE giocatore SET titoli = 6 WHERE classifica = 38;
UPDATE giocatore SET titoli = 2 WHERE classifica = 39;
UPDATE giocatore SET titoli = 0 WHERE classifica = 40;

/* per giocatori con calssifica da 40 a 100 */
UPDATE  giocatore SET titoli = 1 WHERE classifica > 40 and eta = 26;
UPDATE  giocatore SET titoli = 2 WHERE classifica > 40 and eta > 32;
UPDATE  giocatore SET titoli = 1 WHERE classifica > 100 and eta = 26;
UPDATE  giocatore SET titoli = 0 WHERE classifica > 160 ;
