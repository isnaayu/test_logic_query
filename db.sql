--insert into table_1 (id,nama_depan,nama_belakang) values('10001','Lorem', 'Ipsum');
--insert into table_1 (id,nama_depan,nama_belakang) values('10002','Dolor', 'Slamet');
--insert into table_1 (id,nama_depan,nama_belakang) values('10003','Bagus', 'Sekali');
--insert into table_1 (id,nama_depan,nama_belakang) values('10004','Keren', 'Madura');
--insert into table_1 (id,nama_depan,nama_belakang) values('10005','Jitu', 'Situmorang');
--insert into table_1 (id,nama_depan,nama_belakang) values('10006','Jitu', 'Simorangkir');
--
--insert into table_2 (id,nomor_utama,deskripsi) values('10001','+62812882', 'Nomor Kantor');
--insert into table_2 (id,nomor_utama,deskripsi) values('10002','+62812883', 'Nomor Rumah');
--insert into table_2 (id,nomor_utama,deskripsi) values('10004','+62812884', 'Nomor Kantor');
--
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10001','Mobil', 'Toyota', 'Alphard');
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10001','Motor', 'Yamaha', 'Majesty');
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10003','Mobil', 'Honda', 'CRV');
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10004','Mobil', 'Mitshubishi', 'Pajero');
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10005','Mobil', 'Daihatsu', 'Agya');
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10005','Mobil', 'Toyota', 'Rush');
--insert into table_3 (id,jenis_kendaraan,merk_kendaraan,tipe_kendaraan) values('10006','Motor', 'Honda', 'Scoopy');

--ALTER TABLE table_1 ADD CONSTRAINT fk_table_2 FOREIGN KEY(id) REFERENCES table_2(id) ON DELETE CASCADE ON UPDATE CASCADE;
--ALTER TABLE table_3 ADD CONSTRAINT fk_table_3 FOREIGN KEY(id) REFERENCES table_2(id) ON DELETE CASCADE ON UPDATE CASCADE;

WITH justT3 AS (
  SELECT
    id,
    jenis_kendaraan,
    merk_kendaraan,
    tipe_kendaraan,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY jenis_kendaraan) AS rn
  FROM
    table_3
)
SELECT
  T1.ID,
  T1.nama_depan,
  T1.nama_belakang,
  T2.nomor_utama,
  T2.deskripsi,
  MAX(CASE WHEN T3_rn.rn = 1 THEN T3_rn.jenis_kendaraan END) AS jenis_kendaraan_pertama,
  MAX(CASE WHEN T3_rn.rn = 1 THEN T3_rn.merk_kendaraan END) AS merk_kendaraan_pertama,
  MAX(CASE WHEN T3_rn.rn = 1 THEN T3_rn.tipe_kendaraan END) AS tipe_kendaraan_pertama,
  MAX(CASE WHEN T3_rn.rn = 2 THEN T3_rn.jenis_kendaraan END) AS jenis_kendaraan_kedua,
  MAX(CASE WHEN T3_rn.rn = 2 THEN T3_rn.merk_kendaraan END) AS merk_kendaraan_kedua,
  MAX(CASE WHEN T3_rn.rn = 2 THEN T3_rn.tipe_kendaraan END) AS tipe_kendaraan_kedua
FROM
  table_1 T1
  INNER JOIN justT3 T3_rn ON T1.id = T3_rn.id
  LEFT JOIN table_2 T2 ON T1.id = T2.id
GROUP BY
  T1.ID,
  T1.nama_depan,
  T1.nama_belakang,
  T2.nomor_utama,
  T2.deskripsi
 ORDER BY T1.id;

