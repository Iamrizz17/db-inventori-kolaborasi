-- Seed Data: seed_data.sql
-- Deskripsi: Data uji awal untuk master data dan transaksi inventori
-- Author: Muhamad Yusuf (Backend / SQL Developer)

USE db_inventori;

-- 1. Seed Kategori
INSERT INTO kategori (nama_kategori, deskripsi) VALUES
('Elektronik & Komputer', 'Perangkat keras, laptop, monitor, dan aksesoris IT'),
('Alat Tulis Kantor (ATK)', 'Kertas, pena, map, dan perlengkapan administrasi'),
('Jaringan & Infrastruktur', 'Router, switch, kabel LAN, dan perangkat konektivitas');

-- 2. Seed Pengguna (Admin, Petugas, Manajer)
INSERT INTO pengguna (nama, email, password_hash, peran) VALUES
('Muhamad Rizki Saputra', 'rizki@inventori.local', '$2y$10$dummyhashadmin123456', 'admin'),
('Muhamad Yusuf', 'yusuf@inventori.local', '$2y$10$dummyhashpetugas12345', 'petugas'),
('Agiel Ramadhan Putra', 'agiel@inventori.local', '$2y$10$dummyhashmanajer12345', 'manajer');

-- 3. Seed Barang (Stok awal 0 sebelum transaksi masuk dicatat)
INSERT INTO barang (kode_barang, nama_barang, id_kategori, harga, stok, stok_minimum) VALUES
('BRG-001', 'Laptop Lenovo ThinkPad E14', 1, 12500000.00, 0, 3),
('BRG-002', 'Monitor Dell 24 Inch IPS', 1, 2400000.00, 0, 5),
('BRG-003', 'Kertas HVS A4 80gsm (Rim)', 2, 55000.00, 0, 10),
('BRG-004', 'MikroTik RouterBoard RB750Gr3', 3, 950000.00, 0, 4),
('BRG-005', 'Kabel UTP Cat6 Belden (Box)', 3, 1650000.00, 0, 2);

-- 4. Seed Transaksi Header (Penerimaan & Pengeluaran)
INSERT INTO transaksi (nomor_transaksi, tanggal_transaksi, jenis_transaksi, id_pengguna, keterangan) VALUES
('TRX-IN-20261101', '2026-11-20 09:00:00', 'MASUK', 2, 'Penerimaan stok awal pengadaan bulan November'),
('TRX-OUT-20261102', '2026-11-22 14:30:00', 'KELUAR', 2, 'Distribusi perangkat untuk divisi IT & Operasional'),
('TRX-OUT-20261103', '2026-11-24 10:15:00', 'KELUAR', 2, 'Permintaan ATK dan kabel jaringan ruang server');

-- 5. Seed Detail Transaksi
-- Transaksi 1 (MASUK)
INSERT INTO detail_transaksi (id_transaksi, id_barang, jumlah, harga_satuan) VALUES
(1, 1, 10, 12500000.00), -- Laptop +10
(1, 2, 12, 2400000.00),  -- Monitor +12
(1, 3, 30, 55000.00),    -- Kertas HVS +30
(1, 4, 6, 950000.00),    -- MikroTik +6
(1, 5, 5, 1650000.00);   -- Kabel UTP +5

-- Transaksi 2 (KELUAR)
INSERT INTO detail_transaksi (id_transaksi, id_barang, jumlah, harga_satuan) VALUES
(2, 1, 4, 12500000.00),  -- Laptop -4 (Sisa: 6)
(2, 2, 8, 2400000.00),   -- Monitor -8 (Sisa: 4 -> di bawah stok_minimum 5!)
(2, 4, 3, 950000.00);    -- MikroTik -3 (Sisa: 3 -> di bawah stok_minimum 4!)

-- Transaksi 3 (KELUAR)
INSERT INTO detail_transaksi (id_transaksi, id_barang, jumlah, harga_satuan) VALUES
(3, 3, 15, 55000.00),    -- Kertas HVS -15 (Sisa: 15)
(3, 5, 3, 1650000.00);   -- Kabel UTP -3 (Sisa: 2 -> pas di batas stok_minimum 2!)

-- 6. Sinkronisasi Stok Akhir Barang
UPDATE barang SET stok = 6  WHERE kode_barang = 'BRG-001';
UPDATE barang SET stok = 4  WHERE kode_barang = 'BRG-002';
UPDATE barang SET stok = 15 WHERE kode_barang = 'BRG-003';
UPDATE barang SET stok = 3  WHERE kode_barang = 'BRG-004';
UPDATE barang SET stok = 2  WHERE kode_barang = 'BRG-005';