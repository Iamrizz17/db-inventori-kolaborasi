-- Query Laporan: laporan_inventori.sql
-- Deskripsi: Kumpulan query laporan manajerial untuk Sistem Inventori
-- Author: Muhamad Yusuf (Backend / SQL Developer)

USE db_inventori;

-- 1. Laporan Total Barang Keluar per Item
SELECT 
    b.kode_barang,
    b.nama_barang,
    SUM(dt.jumlah) AS total_keluar,
    SUM(dt.jumlah * dt.harga_satuan) AS total_nilai_keluar
FROM detail_transaksi dt
JOIN barang b ON dt.id_barang = b.id
JOIN transaksi t ON dt.id_transaksi = t.id
WHERE t.jenis_transaksi = 'KELUAR'
GROUP BY b.id, b.kode_barang, b.nama_barang
ORDER BY total_keluar DESC;

-- 2. Laporan Peringatan Stok Minimum (Barang yang Perlu Restock)
SELECT 
    b.kode_barang,
    b.nama_barang,
    k.nama_kategori,
    b.stok AS stok_saat_ini,
    b.stok_minimum,
    CASE 
        WHEN b.stok < b.stok_minimum THEN 'KRITIS (Di bawah minimum)'
        WHEN b.stok = b.stok_minimum THEN 'WASPADA (Batas minimum)'
        ELSE 'AMAN'
    END AS status_stok
FROM barang b
JOIN kategori k ON b.id_kategori = k.id
WHERE b.stok <= b.stok_minimum
ORDER BY b.stok ASC;

-- 3. Laporan Riwayat Detail Transaksi Lengkap (Audit Trail)
SELECT 
    t.nomor_transaksi,
    t.tanggal_transaksi,
    t.jenis_transaksi,
    p.nama AS dicatat_oleh,
    b.kode_barang,
    b.nama_barang,
    dt.jumlah,
    dt.harga_satuan,
    (dt.jumlah * dt.harga_satuan) AS subtotal
FROM detail_transaksi dt
JOIN transaksi t ON dt.id_transaksi = t.id
JOIN barang b ON dt.id_barang = b.id
JOIN pengguna p ON t.id_pengguna = p.id
ORDER BY t.tanggal_transaksi DESC, t.nomor_transaksi ASC;