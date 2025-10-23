# Dokumentasi Database Ayam Geprek

## a. Nama Objek dan Deskripsi Database

- **Nama Database:** ayam_geprek
- **Deskripsi:** Database untuk menyimpan data pada sistem pemesanan makanan ayam geprek yang berisi tabel `admins`, `users`, `foods`, dan `transactions`.

## b. Struktur Tabel dan Relasi

- **Tabel `admins`**  
  Menyimpan data admin yang mengelola sistem.  
  Kolom utama: `id`, `name`, `email`, `password`, `created_at`, `updated_at`

- **Tabel `foods`**  
  Menyimpan data menu makanan yang tersedia.  
  Kolom utama: `id`, `name`, `price`, `image`, `created_at`, `updated_at`

- **Tabel `transactions`**  
  Menyimpan data transaksi pemesanan.  
  Kolom utama: `id`, `invoice_id`, `user_id`, `address`, `food_id`, `price`, `quantity`, `total`, `payment_proof`, `status`, `created_at`, `updated_at` <br>
  Relasi:

  - `transactions.user_id` -> `users.id` (Foreign Key)
  - `transactions.food_id` -> `foods.id` (Foreign Key)

- **Tabel `users`**  
  Menyimpan data pelanggan yang memesan makanan.  
  Kolom utama: `id`, `name`, `email`, `password`, `phone`, `address`, `created_at`, `updated_at`

- **Tabel `transaction_logs`**  
  Menyimpan log otomatis setiap kali ada transaksi baru.  
  Dibuat melalui trigger.

## c. Contoh Query yang Sudah Dibuat

### DDL (Data Definition Language)

- ```sql
  CREATE DATABASE ayam_geprek;
  ```
- ```sql
  CREATE TABLE users (...);
  ```
- ```sql
  ALTER TABLE foods ADD PRIMARY KEY ('id');
  ```

### DML (Data Manipulation Language)

- ```sql
  INSERT INTO users (id, name, email, password, phone, address, created_at, updated_at)
  VALUES (1, 'John', 'john@example.com', '$2y$12$mLz/2ckQOLIzlugjoTtWo.5NkZ3ABKip0VVImEfRQqxw/hPCmS3TW', '0812345678', '948 Hagenes Place\nWest Gerry, UT 06623', '2025-10-23 12:18:43', '2025-10-23 12:18:43');
  ```
- ```sql
  UPDATE foods
  SET name = 'Ayam Geprek Sambal Matah', price = 18000
  WHERE id = 1;
  ```
- ```sql
  DELETE FROM users WHERE id = 2;
  ```
- ```sql
  SELECT * FROM transactions WHERE status = 'delivered';
  ```

### DCL (Data Control Language)

- ```sql
  CREATE USER 'bob'@'localhost' IDENTIFIED BY 'halo1234';
  ```
- ```sql
  GRANT ALL PRIVILEGES ON ayam_geprek.* TO 'bob'@'localhost';
  ```
- ```sql
  REVOKE DELETE ON ayam_geprek.* FROM 'bob'@'localhost';
  ```

### Advanced SQL

- **JOIN:**

  ```sql
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
  ```

- **STORED PROCEDURE:**

  ```sql
  CALL GetTransactionsByStatus('confirmed');
  ```

- **STORED FUNCTION:**

  ```sql
  SELECT CalculateTotal(15000, 3) AS total_harga;
  ```

- **VIEW:**

  ```sql
  SELECT * FROM v_transaction_report;
  ```

- **TRIGGER:** <br>
  Mencatat log otomatis ke tabel `transaction_logs` setiap kali data baru di-insert ke tabel `transactions`.
