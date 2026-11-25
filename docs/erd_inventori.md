# ERD & Rancangan Schema Database Inventori

## Relasi Antar Tabel (5 Tabel Inti)
1. **kategori (1) $\rightarrow$ barang (N):** Satu kategori dapat memiliki banyak barang (`barang.id_kategori` $\rightarrow$ `kategori.id`).
2. **pengguna (1) $\rightarrow$ transaksi (N):** Satu pengguna/petugas dapat mencatat banyak transaksi (`transaksi.id_pengguna` $\rightarrow$ `pengguna.id`).
3. **transaksi (1) $\rightarrow$ detail_transaksi (N):** Satu header transaksi memuat banyak item barang (`detail_transaksi.id_transaksi` $\rightarrow$ `transaksi.id`).
4. **barang (1) $\rightarrow$ detail_transaksi (N):** Satu barang dapat tercatat di banyak riwayat detail transaksi (`detail_transaksi.id_barang` $\rightarrow$ `barang.id`).

## Aturan Integritas & Constraint
- **Primary Key:** Seluruh tabel menggunakan `INT AUTO_INCREMENT PRIMARY KEY`.
- **Unique Key:** `barang.kode_barang`, `pengguna.email`, dan `transaksi.nomor_transaksi` wajib unik (`UNIQUE`).
- **Validasi Angka:** Harga menggunakan `DECIMAL(12,2)`, sedangkan `stok`, `stok_minimum`, dan `jumlah` menggunakan `INT` dengan nilai default/batas non-negatif.
- **Storage Engine:** Wajib `ENGINE=InnoDB` untuk mendukung relasi *Foreign Key*.