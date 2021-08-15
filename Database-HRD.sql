CREATE TABLE department(
    id_department int NOT NULL,
    nama_department varchar(255) NOT NULL,
    CONSTRAINT dep_pk PRIMARY KEY (id_department)
);


CREATE TABLE status(
    id_status int NOT NULL,
    status varchar(255) NOT NULL,
    tgl_lolos date,
    CONSTRAINT status_pk PRIMARY KEY (id_status)
);

CREATE TABLE media (
  id_media int NOT NULL,
  nama_media varchar(255) NOT NULL,
  CONSTRAINT media_pk PRIMARY KEY (id_media)
);

CREATE TABLE tayang (
  id_tayang int NOT NULL,
  tgl_tayang date,
  biaya int,
  CONSTRAINT tayang_pk PRIMARY KEY (id_tayang)
);

CREATE TABLE adv(
  id_adv int NOT NULL,
  nama varchar(255) NOT NULL,
  id_tayang int NOT NULL REFERENCES tayang,
  id_media int NOT NULL REFERENCES media,
  CONSTRAINT adv_pk PRIMARY KEY (id_adv)
);

CREATE TABLE req (
  id_department int NOT NULL REFERENCES department,
  id_req int NOT NULL,
  jumlah_karyawan int NOT NULL,
  minPengalaman varchar(255) NOT NULL,
  minPendidikan varchar(255) NOT NULL,
  gaji int NOT NULL,
  posisi varchar(255) NOT NULL,
  id_adv int NOT NULL REFERENCES adv,
  CONSTRAINT req_pk PRIMARY KEY (id_req)
); 

CREATE TABLE cv (
  id_pelamar int NOT NULL,
  id_req int NOT NULL REFERENCES req,
  nama varchar(255) NOT NULL,
  usia int NOT NULL,
  pengalaman char(255) NOT NULL,
  pendidikan char(255) NOT NULL,
  posisi char(255) NOT NULL,
  id_status int NOT NULL REFERENCES status,
  tgl_lolos date,
  CONSTRAINT cv_pk PRIMARY KEY (id_pelamar)
);



INSERT INTO department(id_department,nama_department) VALUES (01, 'Sales')
INSERT INTO department(id_department,nama_department) VALUES (02, 'Marketing');
INSERT INTO department(id_department,nama_department) VALUES (03, 'Production');
INSERT INTO department(id_department,nama_department) VALUES (04, 'IT');

INSERT INTO status(id_status,status) VALUES(1, 'Screening')
INSERT INTO status(id_status,status) VALUES(2, 'Tahap Interview')
INSERT INTO status(id_status,status) VALUES(3, 'Tidak Lulus')
INSERT INTO status(id_status,status) VALUES(4, 'Lulus')
select * from status

INSERT INTO media(id_media,nama_media) VALUES(1, 'Koran Kompos')
INSERT INTO media(id_media,nama_media) VALUES(2, 'Koran Triban')
INSERT INTO media(id_media,nama_media) VALUES(3, 'menit.com')
select * from media

INSERT INTO tayang(id_tayang,tgl_tayang,biaya) values (1,'01-05-2021',10000)
INSERT INTO tayang(id_tayang,tgl_tayang,biaya) values (2,'01-06-2021',20000)
INSERT INTO tayang(id_tayang,tgl_tayang,biaya) values (3,'01-07-2021',30000)
select * from tayang

INSERT INTO adv(id_adv,nama,id_tayang,id_media) VALUES (1, 'Lowongan Kerja Sales',1,1)
INSERT INTO adv(id_adv,nama,id_tayang,id_media) VALUES (2, 'Lowongan Kerja Market',2,2)
INSERT INTO adv(id_adv,nama,id_tayang,id_media) VALUES (3, 'Lowongan Kerja Production',2,1)
INSERT INTO adv(id_adv,nama,id_tayang,id_media) VALUES (4, 'Lowongan Kerja IT',3,3)
select * from adv

INSERT INTO req(id_department,id_req,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi,id_adv) VALUES (01,01,1,'4thn', 'S1',5000000,'Manager',1);
INSERT INTO req(id_department,id_req,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi,id_adv) VALUES (04,02,4,'4thn', 'S2',5000000,'Executive',4);
INSERT INTO req(id_department,id_req,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi,id_adv) VALUES (01,03,20,'1thn', 'SMA/SMK Sederajat',2000000,'Salesman',1);
INSERT INTO req(id_department,id_req,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi,id_adv) VALUES (03,04,1,'2thn', 'S2',8000000,'Superviser',3);


INSERT INTO cv (id_pelamar,id_req,nama,usia,pengalaman,pendidikan,posisi,id_status) VALUES (00001,01,'Firman',21,'1Thn Nganggur','S1','Manager',1);
INSERT INTO cv(id_pelamar,id_req,nama,usia,pengalaman,pendidikan,posisi,id_status) VALUES (00002,02,'Samuel', 21,'2Thn Executive', 'S2','Executive',1);
INSERT INTO cv(id_pelamar,id_req,nama,usia,pengalaman,pendidikan,posisi,id_status) VALUES (00003,01,'Ferdinand', 20,'1thn sebagai manager', 'S1','Manager',1);
INSERT INTO cv(id_pelamar,id_req,nama,usia,pengalaman,pendidikan,posisi,id_status) VALUES (00004,04,'Leandra', 20,'1thn sebagai manager', 'S3','Superviser',1);
SELECT * from cv

DELETE FROM cv WHERE id_pelamar = 00004;
UPDATE cv SET usia = 21 WHERE id_pelamar = 00003

SELECT * from department;
SELECT * from status;
SELECT * from media;
SELECT * from tayang;
SELECT * from adv;
SELECT * from req;

//List Lowongan Department
SELECT id_req,id_department,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi FROM req 
    WHERE id_department=1
SELECT id_req,id_department,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi FROM req 
    WHERE id_department=2
SELECT id_req,id_department,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi FROM req 
    WHERE id_department=3
SELECT id_req,id_department,jumlah_karyawan,minPengalaman,minPendidikan,gaji,posisi FROM req 
    WHERE id_department=4


//LIST Pelamar setiap lowongan
SELECT id_pelamar,nama,usia,pendidikan,pengalaman,posisi FROM cv WHERE id_req=1
SELECT id_pelamar,nama,usia,pendidikan,pengalaman,posisi FROM cv WHERE id_req=2


//LIST iklan lowongan pada setiap media
select * from tayang
SELECT media.id_media, media.nama_media, tayang.tgl_tayang, adv.id_adv, adv.nama, adv.id_tayang, tayang.biaya
FROM adv
INNER JOIN tayang ON adv.id_tayang = tayang.id_tayang
LEFT JOIN media ON adv.id_media = media.id_media


//LIST pelamar yang lolos face interview
UPDATE cv SET id_status=2 WHERE id_pelamar=00002
SELECT id_pelamar,nama FROM cv WHERE id_status=2


//LIST pelamar yang lolos
UPDATE cv SET id_status=4, tgl_lolos=SYSDATE WHERE id_pelamar=00003
SELECT id_pelamar,nama,tgl_lolos FROM cv WHERE id_status=4