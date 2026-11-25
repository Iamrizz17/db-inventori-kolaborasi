# Laporan Hasil Pengujian QA — `db-inventori-kolaborasi`

- **Repository:** `Iamrizz17/db-inventori-kolaborasi`
- **Branch Uji:** `test/qa-and-handover`
- **Role / QA Tester:** Muhammad Faiz Hanifah (`Hanifah146`, NPM `11523066`)
- **Anggota Tim:** Rizki (`Iamrizz17` — Lead), Agiel (`agielramdp` — Tables/Migration), Yusuf (`Ysfmhmmmd12` — Seeds/Queries), Faiz (`Hanifah146` — QA/Documentation)
- **Tanggal Pengujian:** 25 November 2026
- **Lingkungan Uji:** MySQL / phpMyAdmin (`localhost/phpmyadmin`), VS Code

---

## Ringkasan Skenario Pengujian

| Kode Uji | Skenario Pengujian | Langkah & Verifikasi Utama | Hasil | Bukti Screenshot |
| :--- | :--- | :--- | :---: | :--- |
| **TC-01** | Migration dari Database Kosong | Eksekusi `migrations/V001_create_tables.sql` dan verifikasi terbentuknya 5 tabel (`kategori`, `pengguna`, `barang`, `transaksi`, `detail_transaksi`) | **PASS** | `02_tc01_migration_sukses.png` |
| **TC-02** | Seed Data & Sinkronisasi Stok | Eksekusi `seeds/seed_data.sql` dan verifikasi stok akhir pada tabel `barang` (`BRG-001`: 6, `BRG-002`: 4, `BRG-003`: 15, `BRG-004`: 3, `BRG-005`: 2) | **PASS** | `03_tc02_seed_dan_stok_barang.png` |
| **TC-03** | Query Laporan & Stok Minimum | Eksekusi `queries/laporan_inventori.sql` dan verifikasi rekap barang keluar serta status `KRITIS` (`BRG-002`, `BRG-004`) dan `WASPADA` (`BRG-005`) | **PASS** | `04_tc03_laporan_stok_minimum.png` |
| **TC-04** | Integritas Foreign Key | Uji insert data `barang` dengan `id_kategori = 999` yang tidak ada di tabel `kategori` | **PASS** | `05_tc04_foreign_key_ditolak.png` |

---

## Catatan Temuan & Kesimpulan

- **TC-01:** Seluruh tabel utama berhasil dibuat di `db_inventori`. Pada eksekusi gabungan di phpMyAdmin muncul catatan peringatan `Error #1046` sebelum konteks database aktif, namun perintah `USE db_inventori;` tetap berjalan dan seluruh tabel tercipta di database target.
- **TC-02 & TC-03:** Data awal masuk lengkap dan skrip `laporan_inventori.sql` berjalan lancar tanpa error sintaks.
- **TC-04:** Constraint `fk_barang_kategori` bekerja sesuai rancangan dengan menolak input `id_kategori` yang tidak valid (`#1452`).
- **Kesimpulan:** Skema migrasi, seed data, query laporan, dan constraint relasi pada cabang `main` dinyatakan **layak** untuk diserahterimakan.