-- creare tabele:


create table autori(
  id_autor int primary key,
  nume varchar(30) not null,
  prenume varchar(50) not null,
  nationalitate varchar(30) not null,
  data_nastere date not null,
  data_deces date null,
  constraint CHL_data check(data_deces > data_nastere)
  
);

create table colectii(
  id_colectie int primary key,
  nume_colectie varchar(30) not null,
  pret_colectie decimal(6,2) default 0.00 not null check (pret_colectie >= 0),
  data_start date not null,
  id_autor int null,
  foreign key (id_autor) references autori(id_autor) on delete cascade
  
  
);


create table domenii_principale(
  id_domeniu int primary key,
  nume_domeniu varchar(30) not null 
);

create table promotii(
  id_promotie int primary key,
  nume_promotie varchar(50) not null,
  reducere int not null,
  data_start date not null,
  data_final date not null,
  constraint CHK_reducere check (reducere>0 and reducere<= 100)
  
);
create table carti(
  id_carte int primary key,
  titlu varchar(50) not null,
  nr_pagini int not null,
  pret decimal(6,2) not null check(pret >= 0),
  limba varchar(30) not null,
  data_editie date not null,
  data_aparitie date,
  disponibilitate varchar(20) not null check(disponibilitate = 'Disponibil' or disponibilitate = 'Indisponibil'),
  
  id_domeniu int not null,
  foreign key (id_domeniu) references domenii_principale(id_domeniu) on delete cascade ,
  id_colectie int null,
  foreign key (id_colectie) references colectii(id_colectie) on delete cascade
  
);
create table autor_carte (
  id_ac int primary key,
  id_carte int not null,
  id_autor int not null,
  constraint FK_autor_carte foreign key (id_autor) references autori(id_autor) on delete cascade,
  constraint FK_carte_autor foreign key (id_carte) references carti(id_carte) on delete cascade,
  unique (id_autor, id_carte)
);

create table carte_promotie (
  id_cp int primary key,
  id_carte int not null,
  id_promotie int not null,
  constraint FK_promotie_carte foreign key (id_promotie) references promotii(id_promotie) on delete cascade,
  constraint FK_carte_promotie foreign key (id_carte) references carti(id_carte) on delete cascade,
  unique (id_promotie, id_carte)
);


-- introducere date:

--autori:
insert into autori
values (1,'Dostoievski', 'Feodor','rusa', to_date('11/11/1821', 'dd/mm/yyyy'), to_date('09/02/1881', 'dd/mm/yyyy') );

insert into autori
values (2,'Tolstoi', 'Lev','rusa', to_date('09/09/1828', 'dd/mm/yyyy'), to_date('20/11/1910', 'dd/mm/yyyy') );

insert into autori
values (3,'Serghi', 'Cella','romana', to_date('04/11/1907', 'dd/mm/yyyy'), to_date('19/09/1992', 'dd/mm/yyyy') );

insert into autori
values (4,'Cartarescu', 'Mircea','romana', to_date('01/06/1956', 'dd/mm/yyyy'), null );

insert into autori
values (5,'Stancu', 'Elena','romana', to_date('1982', 'yyyy'), null );

insert into autori
values (6,'Bumbut', 'Cosmin','romana', to_date('1968', 'yyyy'),null );

insert into autori
values (7,'Kiyosaki', 'Robert','americana', to_date('08/04/1947', 'dd/mm/yyyy'), null );


insert into autori
values (8,'Petrescu', 'Camil','romana', to_date('21/04/1894', 'dd/mm/yyyy'), to_date('14/05/1957', 'dd/mm/yyyy') );

insert into autori
values (9,'Freud', 'Sigmund','austriaca', to_date('06/05/1856', 'dd/mm/yyyy'), to_date('23/09/1939', 'dd/mm/yyyy') );

insert into autori
values (10,'Peterson', 'Jordan','canadiana', to_date('12/06/1962', 'dd/mm/yyyy'), null );


-- domenii:

insert into domenii_principale
values (1,'Literatura');

insert into domenii_principale
values (2,'Diverse');

insert into domenii_principale
values (3,'Psihologie');

insert into domenii_principale
values (4, 'Dezvoltare personala');

insert into domenii_principale
values (5,'Economie');

insert into domenii_principale
values (6,'Filozofie');

insert into domenii_principale
values(7,'Arte');

insert into domenii_principale
values (8,'Stiinta');

--colectii:

insert into colectii
values (1,'Serie de autor F. Dostoievski', 0, to_date('15-08-2016','dd-mm-yyyy'),1);

insert into colectii
values (2,'Serie de autor Tolstoi', 0, to_date('20-10-2018','dd-mm-yyyy'),2);

insert into colectii
values (3,'Fundamentele Psihologiei', 0, to_date('15-08-2010','dd-mm-yyyy'), null);

insert into colectii
values (4,'Best of economy', 0, to_date('15-08-2017','dd-mm-yyyy'),null);

--promotii:

insert into promotii
values (1,'Saptamana literaturii ruse', 50, to_date('14-02-2021','dd-mm-yyyy'),to_date('20-02-2021','dd-mm-yyyy'));

insert into promotii
values (2,'Ziua cartilor', 40, to_date('23-04-2021','dd-mm-yyyy'),to_date('23-04-2021','dd-mm-yyyy'));


insert into promotii
values (3,'Ziua Nationala a Romaniei', 60, to_date('01-12-2020','dd-mm-yyyy'),to_date('01-12-2020','dd-mm-yyyy'));


--carti:
insert into carti
values (1,'Crima si pedeapsa', 592 ,39.99, 'Romana',to_date('15-08-2016','dd-mm-yyyy'),to_date('15-01-1866','dd-mm-yyyy'), 'Disponibil',1, 1);
insert into autor_carte
values(1, 1, 1);


insert into carti
values (2,'Idiotul', 600 ,49.99, 'Romana',to_date('15-08-2017','dd-mm-yyyy'),to_date('15-01-1868','dd-mm-yyyy'), 'Disponibil',1, 1);
insert into autor_carte
values(2, 2, 1);


insert into carti
values (3,'Demonii', 616 ,52.99, 'Romana',to_date('15-08-2018','dd-mm-yyyy'),to_date('15-01-1871','dd-mm-yyyy'), 'Disponibil',1, 1);
insert into autor_carte
values(3, 3, 1);



insert into carti
values (4,'Razboi si pace', 1432 ,88.00, 'Romana',to_date('20-10-2018','dd-mm-yyyy'),to_date('15-01-1865','dd-mm-yyyy'), 'Disponibil',1, 2);
insert into autor_carte
values(4, 4, 2);


insert into carti
values (5,'Anna Karenina', 936 ,58.00, 'Romana',to_date('20-10-2019','dd-mm-yyyy'),to_date('15-01-1877','dd-mm-yyyy'), 'Disponibil',1, 2);
insert into autor_carte
values(5, 5, 2);


insert into carti
values (6,'Moartea lui Ivan Ilici', 124 ,23.00, 'Romana',to_date('20-10-2000','dd-mm-yyyy'),to_date('15-01-1886','dd-mm-yyyy'), 'Indisponibil',1, null);
insert into autor_carte
values(6, 6, 2);


insert into carti
values (7,'Interpretarea viselor', 632 ,49.00, 'Romana',to_date('15-08-2010','dd-mm-yyyy'),to_date('04-11-1899','dd-mm-yyyy'), 'Disponibil',3, 3);
insert into autor_carte
values(7, 7, 9);

insert into carti
values (8,'Despre psihanaliza', 272 ,29.00, 'Romana',to_date('15-08-2011','dd-mm-yyyy'),to_date('15-12-1938','dd-mm-yyyy'), 'Disponibil',3, 3);
insert into autor_carte
values(8, 8, 9);

insert into carti
values (9,'Acasa, pe drum', 388 ,56.00, 'Romana',to_date('20-10-2017','dd-mm-yyyy'),to_date('20-10-2017','dd-mm-yyyy'), 'Disponibil',2, null);
insert into autor_carte
values(9, 9, 5);
insert into autor_carte
values(10, 9, 6);


insert into carti
values (10,'Rich Dad Poor Dad ', 336 ,89.75, 'Engleza',to_date('15-08-2017','dd-mm-yyyy'),to_date('15-04-2017','dd-mm-yyyy'), 'Disponibil',5, 4);
insert into autor_carte
values(11, 10, 7);

insert into carti
values (11 ,'Rich Dad`s guide to investing', 490 ,93.59, 'Engleza',to_date('15-08-2018','dd-mm-yyyy'),to_date('15-04-2018','dd-mm-yyyy'), 'Disponibil',5, 4);
insert into autor_carte
values(12, 11, 7);


insert into carti
values (12 ,'12 Rules for Life: An Antidote to Chaos', 409 ,60.00, 'Engleza',to_date('15-08-2018','dd-mm-yyyy'),to_date('15-04-2018','dd-mm-yyyy'), 'Disponibil',4, null);
insert into autor_carte
values(13, 12, 10);

insert into carti
values (13 ,'Patul lui Procust', 330 ,30.00, 'Romana',to_date('23-07-2015','dd-mm-yyyy'),to_date('15-02-1933','dd-mm-yyyy'), 'Disponibil',1, null);
insert into autor_carte
values(14, 13, 8);

insert into carti
values (14 ,'Panza de paianjen', 400 ,40.00, 'Romana',to_date('23-07-2011','dd-mm-yyyy'),to_date('15-02-1937','dd-mm-yyyy'), 'Disponibil',1, null);
insert into autor_carte
values(15, 14, 3);

insert into carti
values (15 ,'Melancolia', 256 ,49.99, 'Romana',to_date('23-07-2019','dd-mm-yyyy'),to_date('23-07-2019','dd-mm-yyyy'), 'Disponibil',1, null);
insert into autor_carte
values(16, 15, 4);

--aplicarea promotiilor: 
declare
  nr number :=0;
  nation varchar(30);
  ok_rus number;
  ok_roman number;
begin
  for carte in (select id_carte, id_domeniu from carti) loop
    ok_rus:=0;
    ok_roman:=0;
    nr:=nr+1;
    insert into carte_promotie
    values(nr,carte.id_carte,2);
    for autor in (select id_autor from autor_carte where id_carte = carte.id_carte)loop
        select nationalitate
        into nation
        from autori
        where id_autor = autor.id_autor;
        
        if nation = 'rusa' then
          ok_rus := 1;
        elsif nation ='romana' then
          ok_roman := 1;
        end if;
    end loop;
    
    if ok_rus = 1 and carte.id_domeniu = 1 then
      nr:=nr+1;
      insert into carte_promotie
      values(nr,carte.id_carte,1);
    end if;
    
    if ok_roman = 1 then
      nr:=nr+1;
      insert into carte_promotie
      values(nr,carte.id_carte,3);
    end if;
    
  end loop;
end;
/

-- update pret colectii (se va face in aceasta maniera numai la inceput, urmand ca acest lucru sa fie facut cu ajutorul unui trigger)

begin
  for carte in (select pret, id_colectie from carti) loop
  if carte.id_colectie is not null then
    update colectii
    set pret_colectie = pret_colectie + carte.pret
    where id_colectie = carte.id_colectie;
  end if;
  end loop;
end;
/
commit;

 -- cerinta 6:
  create or replace PROCEDURE lista_Autori_Carti ( v_nationalitate autori.nationalitate%TYPE:= 'international')
  as
    type tablou_imbricat_autori is table of varchar(80);
    autori tablou_imbricat_autori;
    type tablou_imbricat_id is table of int;
    id_autori tablou_imbricat_id;
    type tablou_imbricat_carti is table of varchar(50);
    carti tablou_imbricat_carti;
    verif number;
    i integer;
    j integer;
    no_author exception;

  begin
  
    if v_nationalitate = 'international' then
      
      select count(*)
      into verif
      from (select id_autor
      from autori join autor_carte using (id_autor)
      group by id_autor);
      
      if verif = 0 then
        raise no_author;
      end if;
      
      select id_autor, (prenume||' '||nume)
      bulk collect into id_autori, autori
      from ( select id_autor, prenume, nume, count(*) nr
      from autori join autor_carte using (id_autor)
      group by id_autor, prenume, nume
      order by nr desc,nume, prenume );
      
    else
      select count(*)
      into verif
      from (select id_autor
      from autori join autor_carte using (id_autor)
      where nationalitate = lower(v_nationalitate)
      group by id_autor);
      
      if verif = 0 then
        raise no_author;
      end if;
      
      select id_autor, (prenume||' '||nume)
      bulk collect into id_autori, autori
      from ( select id_autor, prenume, nume, count(*) nr
      from autori join autor_carte using (id_autor)
      where nationalitate = lower(v_nationalitate)
      group by id_autor, prenume, nume
      order by nr desc,nume, prenume );
      
    end if;
    
    i := autori.first;
    while i <= autori.last loop
      dbms_output.put_line('============================');
      dbms_output.put_line(autori(i));
      dbms_output.put_line('----------------------------');
      
      select count(*)
      into verif
      from autor_carte
      where id_autor = id_autori(i);
      
      if verif = 0 then
        dbms_output.put_line('Autorul nu are nicio carte');
        
      else
      
      
      select titlu
      bulk collect into carti
      from carti join autor_carte using (id_carte)
      where id_autor = id_autori(i);
      
      j:=carti.first;
      while j <= carti.last loop
        dbms_output.put_line(carti(j));
        j := carti.next(j);
      end loop;
      end if;
      i:=autori.next(i);
    end loop;
    exception
      when no_author then
        dbms_output.put_line('Nu s-a gasit niciun autor');
    
      
  end lista_Autori_Carti;
  /
  
  
set serveroutput on
begin
  lista_autori_carti();
  dbms_output.put_line('+++++++++++++++++++++++++++++++++++');
  lista_autori_carti('rusa');
  
end;
/
  
-- cerinta 7

create or replace procedure afisare_promotii( v_data promotii.data_start%type)
as
type refcursor is ref cursor;
cursor c_prom (v_prom promotii.nume_promotie%type) is
  select  nume_promotie , reducere , data_start, data_final,
  cursor (
  select  c.titlu, c.pret, a.nume, a.prenume
  from carti c join carte_promotie cp using (id_carte)
             join autor_carte ac using (id_carte)
             join autori a using (id_autor)
  where cp.id_promotie = p.id_promotie
  and c.disponibilitate = 'Disponibil'
  order by titlu)
  from promotii p 
  where p.data_start > v_data;
  
  c_carti refcursor;
  
  
  p_nume promotii.nume_promotie%type;
  red promotii.reducere%type;
  st promotii.data_start%type;
  fin promotii.data_final%type;
  
  titlu carti.titlu%type;
  pret carti.pret%type;
  nume  autori.nume%type;
  prenume autori.prenume%type;
  pret_red number;
  
  verif number;
  exc_promotie exception;
  
begin
  select count(*)
  into verif
  from promotii
  where data_start > v_data;
  
  if verif = 0 then
    raise exc_promotie;
  end if;
  
  open c_prom(v_data);
  
  loop
    fetch c_prom INTO p_nume , red , st ,fin , c_carti;
    exit when c_prom%NOTFOUND;
    dbms_output.put_line('===========================');
    dbms_output.put_line('Nume promotie: '||p_nume);
    dbms_output.put_line('Reducere '||red||'%');
    dbms_output.put_line('Incepand din: '||st||' pana in '||fin);
    dbms_output.put_line('Cartile incluse: ');
    verif:=0;
    loop
      fetch c_carti into titlu, pret, nume, prenume;
      exit when c_carti%NOTFOUND;
      verif := 1;
      pret_red := pret-pret*red/100;
      dbms_output.put_line('----- '||titlu||' de '||prenume||' '||nume||' pret fara reducere: '||pret||' pret redus: '||pret_red);
    end loop;
     if(verif = 0) then
      dbms_output.put_line('----- Acestei promotii nu ii este asociata nicio carte!');
    end if;
  end loop;
  
  exception
      when exc_promotie then
        dbms_output.put_line('Nu exista nicio promotie dupa data respectiva!');
  
  
  
  
end afisare_promotii;
/

begin
  afisare_promotii(sysdate);
  
  dbms_output.put_line(' ');
  dbms_output.put_line('Exemplu pentru exceptie:');
  
  afisare_promotii(to_date('01-01-2022','dd-mm-yyyy'));
end;
/
--cerinta 8


create or replace function reducere_colectie(v_colectie colectii.nume_colectie%TYPE)
return number is

suma number := 0;
verif_colectie number:=0;
no_colectie exception;
no_carte exception;


begin
  select count(*)
  into verif_colectie
  from colectii
  where lower(nume_colectie) = lower(v_colectie);
  
  if verif_colectie = 0 then
    raise no_colectie;
  elsif verif_colectie > 1 then
    raise too_many_rows;
  end if;
  
  
  select count(*)
  into verif_colectie
  from carti join colectii using(id_colectie)
  where lower(nume_colectie) = lower(v_colectie);
  
  if verif_colectie = 0 then
    raise no_carte;
  end if;
  
  for carte in (select id_carte, pret, max(reducere) red
                from carti join colectii using(id_colectie)
                           left outer join carte_promotie using (id_carte)
                           left outer join (select id_promotie, reducere from promotii where sysdate >= data_start and sysdate <=data_final) p using (id_promotie)
                where lower(nume_colectie) = lower(v_colectie)
                group by id_carte, pret)
  loop
    if carte.red is not null then
      suma := suma + carte.pret - (carte.pret*carte.red/100);
    else 
      suma := suma + carte.pret;
    end if;
    
  end loop;
  return suma;
exception
  when too_many_rows then
    return -1;
  when no_colectie then
    return -2;
  when no_carte then
    return -3;
  when others then
    return -4;
end reducere_colectie;
/
insert into colectii
values (5, 'Fara carti', 0, sysdate, null);

insert into colectii
values (6, 'Duplicat', 0, sysdate, null);

insert into colectii
values (7, 'Duplicat', 0, sysdate, null);

insert into colectii
values (8, 'Carti de desenat', 0, sysdate, null);

insert into carti
values(17, 'Animale', 35, 20, 'romana', sysdate,sysdate, 'Disponibil', 2, 8 );

insert into carti
values(18, 'Peisaje', 35, 29, 'romana', sysdate,sysdate, 'Disponibil', 2, 8 );

insert into carti
values(19, 'Planete', 40, 30, 'romana', sysdate,sysdate, 'Disponibil', 2, 8 );




insert into promotii
values(4, 'Promotie Planete', 30, to_date('01-01-2019','dd-mm-yyyy'), to_date('01-01-2022','dd-mm-yyyy'));

insert into carte_promotie
values(26,19,4);



begin
  dbms_output.put_line(reducere_colectie('Fara carti'));
  
  dbms_output.put_line(reducere_colectie('Aceasta colectie nu exista'));
  
  dbms_output.put_line(reducere_colectie('Duplicat'));
  
  dbms_output.put_line(reducere_colectie('Carti de desenat'));
  
  dbms_output.put_line(reducere_colectie('Serie de autor F. Dostoievski'));
  
end;
/


--cerinta 9

create or replace procedure afisare_carti(v_titlu carti.titlu%TYPE)
as
v_nr number:=0;
v_nr_autori number;
v_nr_promotii number;

begin
  
  for carte in (select c.id_carte, c.titlu, c.nr_pagini, c.pret, c.limba, c.data_editie, c.data_aparitie, c.disponibilitate, cl.nume_colectie, dp.nume_domeniu
                from carti c left outer join colectii cl using (id_colectie) 
                             join domenii_principale dp using (id_domeniu)
                where c.titlu = v_titlu) 
  loop
    v_nr:=v_nr + 1;
    dbms_output.put_line('------------------------------------------------------');
    dbms_output.put_line(v_nr||'. '||carte.titlu);
    v_nr_autori :=0;
    dbms_output.put_line('Autori:');
    for autor in (select nume, prenume from autori join autor_carte using (id_autor) where id_carte = carte.id_carte)
    loop
      v_nr_autori:=v_nr_autori + 1;
      dbms_output.put_line(autor.prenume||' '||autor.nume);
      
    end loop;
    
    if v_nr_autori = 0 then
      dbms_output.put_line('Acestei carti nu ii este asociat niciun autor');
    end if;
    dbms_output.put_line(' ');
    dbms_output.put_line('Pret: '|| carte.pret||' lei');
    dbms_output.put_line('Domeniu: '|| carte.nume_domeniu);
    dbms_output.put_line('Numar de pagini: '|| carte.nr_pagini);
    dbms_output.put_line('Limba: '|| carte.limba);
    dbms_output.put_line('An editie: '|| extract(year from carte.data_editie));
    dbms_output.put_line('An publicare: '|| extract(year from carte.data_aparitie));
    dbms_output.put_line('Disponibilitate: '|| carte.disponibilitate);
    if carte.nume_colectie is not null then
      dbms_output.put_line('Face parte din colectia: '|| carte.nume_colectie);
    end if;
    dbms_output.put_line(' ');
    
    v_nr_promotii := 0;
    dbms_output.put_line('Promotii: ');
    for promotie in (select nume_promotie, reducere, data_start, data_final from promotii join carte_promotie using (id_promotie) where id_carte = carte.id_carte)
    loop
      v_nr_promotii := v_nr_promotii + 1;
      dbms_output.put_line('  '||promotie.nume_promotie||' -- Reducere: '||promotie.reducere||'% -- Interval: '||promotie.data_start||' - '||promotie.data_final);
      
    end loop;
    if v_nr_promotii = 0 then
      dbms_output.put_line('Acestei carti nu ii este asociata nicio promotie');
    end if;
    
  end loop;
  if v_nr = 0 then
    raise no_data_found;
  end if;
  

exception
  when no_data_found then
    dbms_output.put_line('Nu a fost gasita nicio carte cu titlul: '||v_titlu);
  when others then
    dbms_output.put_line (SQLCODE || ' - ' || SQLERRM);


end afisare_carti;
/
insert into carti
values(16, 'Idiotul', 109, 30, 'romana', to_date('20/01/2020','dd/mm/yyyy'),to_date('20/01/2020','dd/mm/yyyy'), 'Indisponibil', 1, null );
set serveroutput on
begin
  dbms_output.put_line('Exemplul nr.1:');
  afisare_carti('Iditul');
  dbms_output.put_line('Exemplul nr.2:');
  afisare_carti('Idiotul');
  

end;
/


--cerinta 10 
  
create or replace trigger trig_domenii
  before insert or delete or update on domenii_principale
begin
  if (to_char(sysdate, 'D') = 1) or (to_char(sysdate, 'D') = 7)
  or (to_char(sysdate, 'HH24') not between 9 and 17) then
   if DELETING then
      RAISE_APPLICATION_ERROR(-20001, 'Nu se pot efectiua stergeri pe tabel in afara programului de lucru! ');
    
    elsif INSERTING then
      RAISE_APPLICATION_ERROR(-20002, 'Nu se pot efectiua inserari pe tabel in afara programului de lucru! ');
    
    elsif UPDATING then
      RAISE_APPLICATION_ERROR(-20003, 'Nu se pot efectiua modificari pe tabel in afara programului de lucru! ');
    end if;
  end if;
  
end;
/
insert into domenii_principale
values(9, 'Sport');

delete from domenii_principale
where id_domeniu = 8;

update domenii_principale
set nume_domeniu = 'Domeniu'
where id_domeniu = 4;



--cerinta 11
create or replace trigger trig_pret_colectii
  after insert or delete or update of pret on carti
  for each row
begin
  if DELETING then
    if :OLD.id_colectie is not null then
      update colectii
      set pret_colectie = pret_colectie - :OLD.pret
      where id_colectie = :OLD.id_colectie;
    end if;
  elsif UPDATING then
    update colectii
    set pret_colectie = pret_colectie - :OLD.pret + :NEW.pret
    where id_colectie = :OLD.id_colectie;
  else
    update colectii
    set pret_colectie = pret_colectie + :NEW.pret
    where id_colectie = :NEW.id_colectie;
  end if;

end;
 / 

insert into carti
values (20,'Adolescentul', 400 ,42.99, 'Romana',to_date('15-08-2018','dd-mm-yyyy'),to_date('15-01-1871','dd-mm-yyyy'), 'Disponibil',1, 1);
insert into autor_carte
values(17, 20, 1);

update carti
set pret = 30.00
where titlu = 'Adolescentul';

delete from carti
where titlu = 'Adolescentul';

--cerinta 12

create table info(
          username varchar(50),
          actiune varchar(30),
          nume_obiect varchar(30),
          data date
);

create or replace trigger trig_info
  after create or drop or alter on schema
begin 
  insert into info
  values (SYS.login_user, sys.sysevent, SYS.dictionary_obj_name, sysdate);
  
end;
  /
  
  create table test_tabel (
  col1 int,
  col2 varchar(45));
  
  alter table test_tabel
  drop column col2; 
  
  drop table test_tabel;
  
-- cerinta 13
create or replace package pachet_editura as 

  
  PROCEDURE lista_Autori_Carti ( v_nationalitate autori.nationalitate%TYPE:= 'international');
  
  procedure afisare_promotii( v_data promotii.data_start%type);
  
  function reducere_colectie(v_colectie colectii.nume_colectie%TYPE)
                                                    return number;
  
  procedure afisare_carti(v_titlu carti.titlu%TYPE);
  




end pachet_editura;
/

create or replace package body pachet_editura as

  
  PROCEDURE lista_Autori_Carti ( v_nationalitate autori.nationalitate%TYPE:= 'international')
  as
    type tablou_imbricat_autori is table of varchar(80);
    autori tablou_imbricat_autori;
    type tablou_imbricat_id is table of int;
    id_autori tablou_imbricat_id;
    type tablou_imbricat_carti is table of varchar(50);
    carti tablou_imbricat_carti;
    verif number;
    i integer;
    j integer;
    no_author exception;

  begin
  
    if v_nationalitate = 'international' then
      
      select count(*)
      into verif
      from (select id_autor
      from autori join autor_carte using (id_autor)
      group by id_autor);
      
      if verif = 0 then
        raise no_author;
      end if;
      
      select id_autor, (prenume||' '||nume)
      bulk collect into id_autori, autori
      from ( select id_autor, prenume, nume, count(*) nr
      from autori join autor_carte using (id_autor)
      group by id_autor, prenume, nume
      order by nr desc,nume, prenume );
      
    else
      select count(*)
      into verif
      from (select id_autor
      from autori join autor_carte using (id_autor)
      where nationalitate = lower(v_nationalitate)
      group by id_autor);
      
      if verif = 0 then
        raise no_author;
      end if;
      
      select id_autor, (prenume||' '||nume)
      bulk collect into id_autori, autori
      from ( select id_autor, prenume, nume, count(*) nr
      from autori join autor_carte using (id_autor)
      where nationalitate = lower(v_nationalitate)
      group by id_autor, prenume, nume
      order by nr desc,nume, prenume );
      
    end if;
    
    i := autori.first;
    while i <= autori.last loop
      dbms_output.put_line('============================');
      dbms_output.put_line(autori(i));
      dbms_output.put_line('----------------------------');
      
      select count(*)
      into verif
      from autor_carte
      where id_autor = id_autori(i);
      
      if verif = 0 then
        dbms_output.put_line('Autorul nu are nicio carte');
        
      else
      
      
      select titlu
      bulk collect into carti
      from carti join autor_carte using (id_carte)
      where id_autor = id_autori(i);
      
      j:=carti.first;
      while j <= carti.last loop
        dbms_output.put_line(carti(j));
        j := carti.next(j);
      end loop;
      end if;
      i:=autori.next(i);
    end loop;
    exception
      when no_author then
        dbms_output.put_line('Nu s-a gasit niciun autor');
    
      
  end lista_Autori_Carti;
  
   procedure afisare_promotii( v_data promotii.data_start%type)
  as
  type refcursor is ref cursor;
  cursor c_prom (v_prom promotii.nume_promotie%type) is
    select  nume_promotie , reducere , data_start, data_final,
    cursor (
    select  c.titlu, c.pret, a.nume, a.prenume
    from carti c join carte_promotie cp using (id_carte)
             join autor_carte ac using (id_carte)
             join autori a using (id_autor)
    where cp.id_promotie = p.id_promotie
    and c.disponibilitate = 'Disponibil'
    order by titlu)
    from promotii p 
    where p.data_start > v_data;
  
  c_carti refcursor;
  
  
  p_nume promotii.nume_promotie%type;
  red promotii.reducere%type;
  st promotii.data_start%type;
  fin promotii.data_final%type;
  
  titlu carti.titlu%type;
  pret carti.pret%type;
  nume  autori.nume%type;
  prenume autori.prenume%type;
  pret_red number;
  
  
  verif number;
  exc_promotie exception;
  
  begin
    select count(*)
    into verif
    from promotii
    where data_start > v_data;
  
    if verif = 0 then
     raise exc_promotie;
    end if;
  
    open c_prom(v_data);
  
    loop
     fetch c_prom INTO p_nume , red , st ,fin , c_carti;
     exit when c_prom%NOTFOUND;
     dbms_output.put_line('===========================');
     dbms_output.put_line('Nume promotie: '||p_nume);
     dbms_output.put_line('Reducere '||red||'%');
     dbms_output.put_line('Incepand din: '||st||' pana in '||fin);
      dbms_output.put_line('Cartile incluse: ');
      verif:=0;
      loop
        fetch c_carti into titlu, pret, nume, prenume;
       exit when c_carti%NOTFOUND;
       verif := 1;
       pret_red := pret-(pret*red/100);
        dbms_output.put_line('----- '||titlu||' de '||prenume||' '||nume||' pret fara reducere: '||pret||' pret redus: '||pret_red);
      end loop;
       if(verif = 0) then
        dbms_output.put_line('----- Acestei promotii nu ii este asociata nicio carte!');
     end if;
    end loop;
  
    exception
      when exc_promotie then
        dbms_output.put_line('Nu exista nicio promotie dupa data respectiva!');
  
  
  
  
  end afisare_promotii;
function reducere_colectie(v_colectie colectii.nume_colectie%TYPE)
return number is

suma number := 0;
verif_colectie number:=0;
no_colectie exception;
no_carte exception;


begin
  select count(*)
  into verif_colectie
  from colectii
  where lower(nume_colectie) = lower(v_colectie);
  
  if verif_colectie = 0 then
    raise no_colectie;
  elsif verif_colectie > 1 then
    raise too_many_rows;
  end if;
  
  
  select count(*)
  into verif_colectie
  from carti join colectii using(id_colectie)
  where lower(nume_colectie) = lower(v_colectie);
  
  if verif_colectie = 0 then
    raise no_carte;
  end if;
  
  for carte in (select id_carte, pret, max(reducere) red
                from carti join colectii using(id_colectie)
                           left outer join carte_promotie using (id_carte)
                           left outer join (select id_promotie, reducere from promotii where sysdate >= data_start and sysdate <=data_final) p using (id_promotie)
                where lower(nume_colectie) = lower(v_colectie)
                group by id_carte, pret)
  loop
    if carte.red is not null then
      suma := suma + carte.pret - (carte.pret*carte.red/100);
    else 
      suma := suma + carte.pret;
    end if;
    
  end loop;
  return suma;
exception
  when too_many_rows then
    return -1;
  when no_colectie then
    return -2;
  when no_carte then
    return -3;
  when others then
    return -4;
end reducere_colectie;

procedure afisare_carti(v_titlu carti.titlu%TYPE)
as
v_nr number:=0;
v_nr_autori number;
v_nr_promotii number;

begin
  
  for carte in (select c.id_carte, c.titlu, c.nr_pagini, c.pret, c.limba, c.data_editie, c.data_aparitie, c.disponibilitate, cl.nume_colectie, dp.nume_domeniu
                from carti c left outer join colectii cl using (id_colectie) 
                             join domenii_principale dp using (id_domeniu)
                where c.titlu = v_titlu) 
  loop
    v_nr:=v_nr + 1;
    dbms_output.put_line('------------------------------------------------------');
    dbms_output.put_line(v_nr||'. '||carte.titlu);
    v_nr_autori :=0;
    dbms_output.put_line('Autori:');
    for autor in (select nume, prenume from autori join autor_carte using (id_autor) where id_carte = carte.id_carte)
    loop
      v_nr_autori:=v_nr_autori + 1;
      dbms_output.put_line(autor.prenume||' '||autor.nume);
      
    end loop;
    
    if v_nr_autori = 0 then
      dbms_output.put_line('Acestei carti nu ii este asociat niciun autor');
    end if;
    dbms_output.put_line(' ');
    dbms_output.put_line('Pret: '|| carte.pret||' lei');
    dbms_output.put_line('Domeniu: '|| carte.nume_domeniu);
    dbms_output.put_line('Numar de pagini: '|| carte.nr_pagini);
    dbms_output.put_line('Limba: '|| carte.limba);
    dbms_output.put_line('An editie: '|| extract(year from carte.data_editie));
    dbms_output.put_line('An publicare: '|| extract(year from carte.data_aparitie));
    dbms_output.put_line('Disponibilitate: '|| carte.disponibilitate);
    if carte.nume_colectie is not null then
      dbms_output.put_line('Face parte din colectia: '|| carte.nume_colectie);
    end if;
    dbms_output.put_line(' ');
    
    v_nr_promotii := 0;
    dbms_output.put_line('Promotii: ');
    for promotie in (select nume_promotie, reducere, data_start, data_final from promotii join carte_promotie using (id_promotie) where id_carte = carte.id_carte)
    loop
      v_nr_promotii := v_nr_promotii + 1;
      dbms_output.put_line('  '||promotie.nume_promotie||' -- Reducere: '||promotie.reducere||'% -- Interval: '||promotie.data_start||' - '||promotie.data_final);
      
    end loop;
    if v_nr_promotii = 0 then
      dbms_output.put_line('Acestei carti nu ii este asociata nicio promotie');
    end if;
    
  end loop;
  if v_nr = 0 then
    raise no_data_found;
  end if;
  

exception
  when no_data_found then
    dbms_output.put_line('Nu a fost gasita nicio carte cu titlul: '||v_titlu);
  when others then
    dbms_output.put_line (SQLCODE || ' - ' || SQLERRM);


end afisare_carti;

end pachet_editura;
/
set serveroutput on

begin
  pachet_editura.lista_autori_carti();
  dbms_output.put_line('+++++++++++++++++++++++++++++++++++');
  pachet_editura.lista_autori_carti('rusa');
  
end;
/


begin
  pachet_editura.afisare_promotii(sysdate);
  
  dbms_output.put_line(' ');
  dbms_output.put_line('Exemplu pentru exceptie:');
  
  pachet_editura.afisare_promotii(to_date('01-01-2022','dd-mm-yyyy'));
end;
/

begin
  dbms_output.put_line(pachet_editura.reducere_colectie('Fara carti'));
  
  dbms_output.put_line(pachet_editura.reducere_colectie('Aceasta colectie nu exista'));
  
  dbms_output.put_line(pachet_editura.reducere_colectie('Duplicat'));
  
  dbms_output.put_line(pachet_editura.reducere_colectie('Carti de desenat'));
  
  dbms_output.put_line(pachet_editura.reducere_colectie('Serie de autor F. Dostoievski'));
  
end;
/

begin
  dbms_output.put_line('Exemplul nr.1:');
  pachet_editura.afisare_carti('Iditul');
  dbms_output.put_line('Exemplul nr.2:');
  pachet_editura.afisare_carti('Idiotul');
  

end;
/

