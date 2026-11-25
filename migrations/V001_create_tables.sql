-- Migration: V001_create_tables.sql
-- Deskripsi: Inisialisasi 5 tabel utama Sistem Inventori
-- Author: Agiel Ramadhan Putra (Database Designer)

CREATE DATABASE IF NOT EXISTS db_inventori;
USE db_inventori;

-- 1. Tabel Kategori
CREATE TABLE kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Tabel Pengguna (Admin, Petugas, Manajer)
CREATE TABLE pengguna (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    peran ENUM('admin', 'petugas', 'manajer') NOT NULL DEFAULT 'petugas',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Tabel Barang
CREATE TABLE barang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_barang VARCHAR(30) NOT NULL UNIQUE,
    nama_barang VARCHAR(150) NOT NULL,
    id_kategori INT NOT NULL,
    harga DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    stok INT NOT NULL DEFAULT 0,
    stok_minimum INT NOT NULL DEFAULT 5,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_barang_kategori
        FOREIGN KEY (id_kategori) REFERENCES kategori(id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 4. Tabel Transaksi (Header Penerimaan / Pengeluaran)
CREATE TABLE transaksi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nomor_transaksi VARCHAR(40) NOT NULL UNIQUE,
    tanggal_transaksi DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    jenis_transaksi ENUM('MASUK', 'KELUAR') NOT NULL,
    id_pengguna INT NOT NULL,
    keterangan TEXT NULL,
    CONSTRAINT fk_transaksi_pengguna
        FOREIGN KEY (id_pengguna) REFERENCES pengguna(id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 5. Tabel Detail Transaksi (Item per Transaksi)
CREATE TABLE detail_transaksi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT NOT NULL,
    id_barang INT NOT NULL,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_detail_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES transaksi(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detail_barang
        FOREIGN KEY (id_barang) REFERENCES barang(id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;