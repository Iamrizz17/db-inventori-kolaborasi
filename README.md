# db-inventori-kolaborasi
Tugas Kelompok 1 untuk pemenuhan tugas Mata Kuliah Collaborative Computing

# Database Collaboration – Sistem Inventori

Proyek praktikum mata kuliah **Collaborative Computing (Pertemuan 9)** – Program Studi Sistem Informasi, FINKOM Universitas Binaniaga Indonesia.

## Anggota Tim & Peran
1. **Muhamad Rizki Saputra** (11523051) – *Lead Repo & Analis*
2. **Agiel Ramadhan Putra** (11523001) – *Database Designer*
3. **Muhamad Yusuf** (11523009) – *Backend / SQL Developer*
4. **Muhammad Faiz Hanifah** (11523066) – *QA / Tester*

## Standar Teknis
- **DBMS:** MySQL (Engine: `InnoDB`)
- **Naming Convention:** `snake_case` huruf kecil untuk semua nama tabel dan kolom (contoh: `detail_transaksi`, `kode_barang`).
- **Format Migration:** `V001_deskripsi_singkat.sql`, `V002_deskripsi_singkat.sql`, dst.

## Struktur Folder
- `docs/` : Dokumentasi ERD dan aturan bisnis.
- `migrations/` : Skrip DDL pembuatan dan perubahan struktur tabel secara terurut.
- `seeds/` : Skrip DML pengisian data uji (*dummy data*).
- `queries/` : Kumpulan *query* laporan stok/transaksi dan skrip pengujian.

## Alur Kerja Git (Workflow)
`Issue` -> `Branch` -> `Migrate` -> `Review (Pull Request)` -> `Merge`
> **Catatan:** Dilarang mengubah struktur tabel produksi secara manual tanpa file *migration* dan *review* tim.
