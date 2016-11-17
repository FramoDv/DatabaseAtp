/* CREATE TABLE RELATIVI AL DB ATP IN ORDINE DI INSERIMENTO */

/* 1) TABELLA SPONSOR TECNICO  150 rec*/

create table sponsor_tec(
	marchio_t varchar(20) not null primary key,
	sede_leg  varchar(20) not null,
	p_iva char(11) not null, /* tutte le p_iva devono essere di preciso 11 caratteri ne + ne - */
	genere varchar(15) not null,
	fatturato integer not null
);
	
/* esempio di insert 
insert into sponsor_tec values('Nike' , 'New York' , '123456abcdef' , 'sportwear' , 999999999);*/

/************** 2) TABELLA MAJOR SPONSOR 100 rec **************/

create table sponsor_maj(
	marchio_m varchar(20) not null primary key,
	sede_leg  varchar(20) not null,
	p_iva varchar(11) not null,
	/*posso togliere ambito */
	apporto mediumint not null, /* in quanto non supera mai il milione */
	fatturato integer not null
);

/*esempio di insert 
insert into sponsor_maj values ('Prova' , 'Roma' , '123456abcdef' , 600000 , 999999999);*/

/************* 3) TABELLA TV ************** 50 rec */

create table tv(
	canale varchar(20) not null primary key,
	hd boolean not null,
	3d boolean not null,
	lingua varchar(15) not null
);

/* esempio di insert 
insert into tv values ('sky1' , TRUE , FALSE , 'Italiano');*/

/*********** TABELLA ARBITRI ************ 250 row */  

create table arbitri(
	matricola_ar varchar(4) not null primary key, /* sarà numero concatenato con a */
	nome varchar(15) not null,
	cognome varchar(15) not null,
	livello char(1) not null, /* valori che vanno da A ad E */
	eta tinyint(2) not null,
	sesso char(1) not null /*  valori M o F */
);

/* esempio di insert INSERITO
insert into arbitri values ('249A' , 'Mohammed' , 'Lhaiani' , 'A' , 56 , 'M');
insert into arbitri values ('250A' , 'Pascal' , 'Mariah' , 'A' , 45 , 'M');*/

/* 5) TABELLA GIOCATORE 250 row*/

create table giocatore(
	classifica tinyint unsigned not null primary key, /* primi 250 giocatori al mondo come regola atp */
	nome varchar(15) not null,
	cognome varchar(15) not null,
	eta tinyint(2) unsigned not null,
	nazione char(3) not null, /* srb,ita,fra */
	titoli tinyint(2) unsigned not null, /* xk non esiste uomo con + di 89 titoli */
	car_p_money integer(8) not null /* max 90 milioni */
);

/* esempio di insert 
insert into giocatore values (3 , 'Roger' , 'Federer' , '35' , 'SUI' , 90 , 89000000);*/


/* 6) SPETTATORE   100000 record tra cui mio personale */

create table spettatore(
	cod_f char(12) primary key not null,
	nome varchar(15) not null,
	cognome varchar(15) not null,
	eta tinyint(2) not null,
	nazione varchar(3) not null, /* hai i file nazioni */
	sesso char(1) not null, /* valri M o F */
	residenza varchar(20) not null /* hai le città più quelle a caso di mookaro */
);

/* esempio di insert 
insert into spettatore values ('abcdefghilmn' , 'Francesco' , 'Monti' , 21 , 'ITA' , 'M' , 'Sora');*/

/* 7) TABELLA SUPERVISOR  250 row */

create table supervisor(
	matricola_sv varchar(4) not null primary key, /* da 1 a 200 forse con numero concat con S */
	nome varchar(15) not null,
	cognome varchar(15) not null,
	eta tinyint(2) not null, /* da 40 a 65 */
	sesso char(1) not null /* valri M o F */
);

/* esempio di insert INSERITO
insert into supervisor values (001 , 'Mario' , 'Rossi' , 33 , 'M');*/

/* 8) TABELLA TORNEO  100 row */

create table torneo(
	citta varchar(20) primary key not null,
	nome_t varchar(30) not null, /* citta concat "-tennis , -tour, -master, -ace, -world , -cup" */
	p_money integer(7) not null, /* mai oltre i 5 milioni */
	cogn_finalista varchar(15) not null, /* i cognomi dei migliori giocatori + qualche sorpresa */
	cogn_vincitore varchar(15) not null, /* i cognomi dei migliori giocatori + qualche sorpresa */
	nazione char(3) not null, /* controlla file nazione */
	data_i date not null,
	data_f date not null,
	matricola_ar varchar(4) not null , /* matricola arbitro che ha diretto la finale, generate in java*/
	foreign key (matricola_ar) references arbitri(matricola_ar) on update cascade on delete no action,
	matricola_sv varchar(4) not null , /* matricola supervisor torneo, generate in java */
	foreign key (matricola_sv) references supervisor(matricola_sv) on update cascade on delete no action
);

/* esempio di insert INSERIMENTO 
insert into torneo values ('Brisbane' , 'BrisbaneTennis' , 500000 , 'Nadal' , 'Federer' , 'AUT' ,'2015-01-04' , '2015-01-11' , '1A' , '1B' );*/

/* 9) TABELLA STADIO  almeno 3 stadi per torneo minimo max 5  400/500 row */

create table stadio(
	nome_st varchar(20) primary key not null, /* generare in java concatenando array nomi città con numeri 1 2 3 4  a caso dinamicamente o a pezzi */
	capienza smallint not null, /* controlla */
	superficie varchar(7) not null,
	tetto boolean not null,
	citta varchar(20) not null ,
	foreign key (citta) references torneo(citta) on update cascade on delete no action
);

/*------------------------- TABELLE DERIVANTI DA RELAZIONI ---------------------------

 10) TABELLA SUPPORTATO rel tra SPONSOR tecnico e GIOCATORE 
 	 mi serve il marchio esatto dello sponsor tecnico e la classifica */

create table supportato(
	marchio_t varchar(20) not null, /* prendi le istanze + frequenti nella realtà una ventina e combinale random con la classifica */
	foreign key (marchio_t) references sponsor_tec(marchio_t) on update cascade on delete no action,
	classifica tinyint unsigned not null,
	foreign key (classifica) references giocatore(classifica) on update cascade on delete no action,
	primary key ( marchio_t, classifica)
);

/*--------- 11) TABELLA FINANZIATO rel tra SPONSOR major e TORNEO -------*/
/* mi serve il marchio dello sponsor major esatto e la citta */
 /* tutti tornei hanno bnl e fly emirates */
create table finanziato(
	id_fin varchar(5) primary key not null, /* poi dipende da quante vuoi inserirne */
	marchio_m varchar(20) not null, /* HAI IL FILE COMPAGNIE */
	foreign key (marchio_m) references sponsor_maj(marchio_m) on update cascade on delete no action,
	citta varchar(20) not null, /* hai il file città */
	foreign key (citta) references torneo(citta) on update cascade on delete no action
);

insert into finanziato values ('5001F', 'Prova' , 'Roma' );

/*--------- 12) TABELLA PARTECIPA rel tra GIOCATORE e TORNEO ---------*/
/* mi serve la classifica esatta di ogni giocatore  e la città chiave di torneo*/

create table partecipa(
	classifica tinyint unsigned not null, 
	foreign key (classifica) references giocatore(classifica) on update cascade on delete no action,
	citta varchar(20) not null,
	foreign key (citta) references torneo(citta) on update cascade on delete no action,
	primary key( classifica , citta)
);

/* -------- 13) TABELLA TRASMESSO rel tra TV e TORNEEO ---------- */
/* mi servono nomi esatti dei canali e le città esatte dei tornei */

create table trasmesso(
	id_tr varchar(5) primary key not null, /* AUTOINCREMENT??? */
	canale varchar(20) not null, /*  hai lista canali */
	foreign key (canale) references tv(canale) on update cascade on delete no action,
	citta varchar(20) not null, /* hai file cityes */
	foreign key (citta) references torneo(citta) on update cascade on delete no action
);

/*------ 14) TABELLA BIGLIETTO rel tra SPETTATORE e STADIO ---------*/
/* mi servono i codici fiscali esatti di spettatori e i nomi esatti degli stadi */

create table biglietto(
	id_b varchar(7) primary  key not null , /* esempio: 100000B */
	prezzo tinyint unsigned not null, /* no sopra 250 euro per biglietto in una sessione */
	cod_f char(12) not null,
	foreign key (cod_f) references spettatore(cod_f) on update cascade on delete no action,
	nome_st varchar(20) not null,
	foreign key (nome_st) references stadio(nome_st) on update cascade on delete no action
);
























