-- 1. Perancangan Database
-- - Tentukan objek dan entitas utama yang dibutuhkan (minimal 3 tabel).
-- - Buat desain relasi sederhana antar tabel (contoh: ERD atau tabel relasi).
-- - Pilih tipe data yang sesuai untuk setiap kolom.


-- 2. Scripting dengan DDL (Data Definition Language)
-- - Tulis skrip CREATE DATABASE dan CREATE TABLE sesuai kebutuhan.
CREATE DATABASE ayam_geprek;
USE ayam_geprek;

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
);

CREATE TABLE `foods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(10) UNSIGNED NOT NULL,
  `image` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
);

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `address` text NOT NULL,
  `food_id` bigint(20) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  `total` int(10) UNSIGNED NOT NULL,
  `payment_proof` text DEFAULT NULL,
  `status` enum('pending payment','waiting confirmation','confirmed','delivered','cancelled') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
);

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
);

-- - Tambahkan Primary Key dan Foreign Key.
-- - Gunakan ALTER TABLE untuk menambahkan kolom baru atau mengubah struktur tabel.
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_food_id_foreign` (`food_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_food_id_foreign` FOREIGN KEY (`food_id`) REFERENCES `foods` (`id`),
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `foods`
  ADD COLUMN `description` TEXT NULL AFTER `image`;

ALTER TABLE `foods`
  DROP COLUMN `description`;

ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `foods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

-- - Coba gunakan DROP, TRUNCATE, atau RENAME pada tabel uji coba.
CREATE TABLE `test_table` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100)
);

ALTER TABLE `test_table`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- RENAME
RENAME TABLE `test_table` TO `temp_table`;

-- TRUNCATE
TRUNCATE TABLE `temp_table`;

-- DROP
DROP TABLE `temp_table`;


-- 3. Scripting dengan DML (Data Manipulation Language)
-- - Isi tabel dengan data contoh menggunakan INSERT.
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Alice', 'alice@example.com', '$2y$12$QTkNX/BjuxWbNkoB/alLiOPPJnzeexM8JEYwavy0g6EvrCloHCoB.', '2025-10-23 12:18:44', '2025-10-23 12:18:44');

INSERT INTO `foods` (`id`, `name`, `price`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Ayam Geprek Bakar', 25000, 'menu1.jpeg', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(2, 'Ayam Geprek Kremes', 22000, 'menu2.png', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(3, 'Ayam Geprek Super', 30000, 'menu3.jpg', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(4, 'Ayam Geprek Krispi', 28000, 'menu4.png', '2025-10-23 12:18:43', '2025-10-23 12:18:43');

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'John', 'john@example.com', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '948 Hagenes Place\nWest Gerry, UT 06623', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(2, 'Mr. Pedro Nitzsche III', 'delaney91@example.net', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '31625 Halvorson Stream Suite 079\nMauriceberg, HI 20161-1563', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(3, 'Ferne Cruickshank', 'qhansen@example.com', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '3111 Schaden Vista\nPeytontown, OK 75007', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(4, 'Herminia Hintz', 'marlene66@example.org', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '72824 Mallie Avenue Apt. 358\nHaagville, PA 02642-2600', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(5, 'Toney Strosin', 'libbie.ziemann@example.com', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '5928 Jarred Turnpike Suite 678\nSouth Letitia, OH 84564', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(6, 'Itzel Funk', 'tromp.tara@example.net', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '55933 Esperanza Lodge\nRunolfssonburgh, TX 89330', '2025-10-23 12:18:43', '2025-10-23 12:18:43');

INSERT INTO `transactions` (`id`, `invoice_id`, `user_id`, `address`, `food_id`, `price`, `quantity`, `total`, `payment_proof`, `status`, `created_at`, `updated_at`) VALUES
(1, 'uu01761221923', 1, '239 Hilpert Pass Apt. 394\nAldatown, SC 89241', 1, 25000, 4, 100000, NULL, 'pending payment', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(2, 'y1b1761221923', 1, '79788 April Square\nNew Jaquelin, WI 26959-7411', 1, 25000, 4, 100000, 'dummy-txn.jpg', 'waiting confirmation', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(3, 'WcB1761221923', 1, '3044 Halle Place Suite 679\nStrackeside, WA 31342-4121', 1, 25000, 4, 100000, 'dummy-txn.jpg', 'confirmed', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(4, 'Qmx1761221923', 1, '61172 Juanita Mount Apt. 787\nPort Otho, AZ 55432-4083', 1, 25000, 4, 100000, 'dummy-txn.jpg', 'delivered', '2025-10-23 12:18:43', '2025-10-23 12:18:43'),
(5, 'QpX1761221923', 1, '6451 Harrison Cove\nEast Chanelview, SD 61719', 1, 25000, 4, 100000, NULL, 'cancelled', '2025-10-23 12:18:43', '2025-10-23 12:18:43');

-- - Ubah data tertentu dengan UPDATE.
UPDATE `foods`
SET `name` = 'Ayam Geprek Sambal Matah', `price` = 18000
WHERE `id` = 1;

-- - Hapus data tertentu dengan DELETE.
DELETE FROM `users`
WHERE `id` = '2';

-- - Ambil data menggunakan SELECT dengan variasi (WHERE, ORDER BY, LIMIT).
SELECT * FROM `foods`;

-- WHERE
SELECT * FROM `transactions`
WHERE `status` = 'delivered';

-- ORDER BY
SELECT * FROM `users`
ORDER BY `name` ASC;

-- LIMIT
SELECT * FROM `foods`
LIMIT 1;


-- 4. Scripting dengan DCL (Data Control Language)
-- - Buat user baru khusus untuk website.
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'halo1234';

-- - Atur hak akses dengan GRANT dan REVOKE.
-- GRANT
GRANT SELECT, INSERT, UPDATE, DELETE ON ayam_geprek.* TO 'bob'@'localhost';
FLUSH PRIVILEGES;

-- REVOKE
REVOKE DELETE ON ayam_geprek.* FROM 'bob'@'localhost';
FLUSH PRIVILEGES;


-- 5. Advanced SQL (Optional Challenge)
-- - Buat query dengan JOIN antar tabel.
SELECT 
    t.id AS transaction_id,
    t.invoice_id,
    u.name AS customer_name,
    f.name AS food_name,
    t.quantity,
    t.total,
    t.status,
    t.created_at
FROM transactions t
JOIN users u ON t.user_id = u.id
JOIN foods f ON t.food_id = f.id
ORDER BY t.created_at DESC;

-- - Buat Stored Procedure sederhana (misalnya menampilkan daftar data tertentu).
DELIMITER $$
CREATE PROCEDURE GetTransactionsByStatus(IN status_param VARCHAR(50))
BEGIN
    SELECT 
        t.id AS transaction_id,
        u.name AS customer_name,
        f.name AS food_name,
        t.quantity,
        t.total,
        t.status
    FROM transactions t
    JOIN users u ON t.user_id = u.id
    JOIN foods f ON t.food_id = f.id
    WHERE t.status = status_param;
END $$
DELIMITER;
-- CALL GetTransactionsByStatus('confirmed');

-- - Buat Stored Function (misalnya menghitung total harga, jumlah buku pinjaman, atau lama perawatan).
DELIMITER $$
CREATE FUNCTION CalculateTotal(price INT, quantity INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SET total = price * quantity;
    RETURN total;
END $$
DELIMITER ;
-- SELECT CalculateTotal(15000, 3) AS total_harga;

-- - Buat View untuk mempermudah pengambilan data.
CREATE VIEW v_transaction_report AS
SELECT 
    t.invoice_id,
    u.name AS customer_name,
    f.name AS food_name,
    t.quantity,
    t.total,
    t.status,
    t.created_at
FROM transactions t
JOIN users u ON t.user_id = u.id
JOIN foods f ON t.food_id = f.id;
-- SELECT * FROM v_transaction_report;

-- - Buat Trigger (misalnya menambahkan log saat data di-insert atau di-delete).
CREATE TABLE `transaction_logs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `transaction_id` BIGINT,
    `action` VARCHAR(50),
    `log_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_transaction_insert
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO `transaction_logs` (`transaction_id`, `action`)
    VALUES (NEW.id, 'INSERTED');
END $$
DELIMITER ;

INSERT INTO `transactions` (`id`, `invoice_id`, `user_id`, `address`, `food_id`, `price`, `quantity`, `total`, `payment_proof`, `status`, `created_at`, `updated_at`) VALUES
(6, 'pp01761221923', 1, '239 Hilpert Pass Apt. 394\nAldatown, SC 89241', 1, 25000, 4, 100000, NULL, 'pending payment', '2025-10-23 12:18:43', '2025-10-23 12:18:43');

SELECT * FROM transaction_logs;

-- 6. Dokumentasi & Integrasi ke Laravel (Transition Step)
-- - Simpan semua skrip SQL dalam 1 file (contoh: database_perpustakaan.sql).
-- - Buat dokumentasi singkat berisi:
-- a. Nama objek dan deskripsi database.
-- b. Struktur tabel (ERD / relasi tabel).
-- c. Contoh query yang sudah dibuat.
-- - Import database ini ke MySQL, lalu pastikan bisa diakses.
-- - Hasil database ini akan digunakan pada tugas berikutnya: menghubungkan Laravel dengan database dan menampilkan data ke halaman website.
