# Student Registration Database (SQL Server)

Laporan **Hands-On Lab 1**: membangun database relasional **StudentRegistrationDB** dengan SQL Server dan SSMS.

---

## 1. Deskripsi & Tujuan

Praktikum ini menyiapkan database untuk aplikasi *Student Registration* yang akan dihubungkan ke WPF + C# melalui ADO.NET pada lab berikutnya.

Tujuan:
- Menginstal SQL Server dan SSMS secara lokal.
- Membuat database dan tabel dengan T-SQL.
- Menerapkan **PRIMARY KEY**, **UNIQUE KEY**, dan **FOREIGN KEY**.
- Memahami relasi **One-to-Many (1:N)**.
- Menjalankan `INSERT`, `SELECT`, `JOIN`, `COUNT`, `WHERE`, dan `GROUP BY`.

Arsitektur:

```
WPF / C#  ──ADO.NET──►  SQL Server  ──►  StudentRegistrationDB
                                            ├── Programs (1)
                                            └── Students (N)
```

## 2. Rancangan Database

<img width="345" height="628" alt="Screenshot 2026-10-22 215937" src="https://github.com/user-attachments/assets/cbdbc8fb-ed83-4d63-81a0-d09b8534a796" />

---

## 3. Dokumentasi

### 3.1 Membuat Database 

```sql
CREATE DATABASE StudentRegistrationDB;
GO
USE StudentRegistrationDB;
GO
SELECT DB_NAME() AS CurrentDatabase;
```

<img width="421" height="298" alt="Screenshot 2026-10-22 214945" src="https://github.com/user-attachments/assets/c8903951-5fe5-44d6-b9a0-9cfa4334fe58" />

_Keterangan: `StudentRegistrationDB` muncul di Object Explorer dan `DB_NAME()` mengembalikan nama yang sama._

### 3.2 Tabel Programs 

<img width="610" height="152" alt="Screenshot 2026-10-22 215105" src="https://github.com/user-attachments/assets/6a088c24-1eaf-4be7-8ac0-c9704fa4b664" />

_Keterangan: hasil `SELECT * FROM Programs` berisi 5 program studi (TI, SI, MNJ, TE, DKV)._

### 3.3 Tabel Students 

<img width="990" height="155" alt="Screenshot 2026-10-22 215129" src="https://github.com/user-attachments/assets/9d1b7886-5b7c-46d3-bc9c-0cf504f254db" />

_Keterangan: hasil `SELECT * FROM Students` berisi data mahasiswa._

### 3.4 INNER JOIN

```sql
SELECT s.StudentId, s.NIM, s.Name, p.ProgramCode, p.ProgramName, s.BirthDate, s.PhoneNumber
FROM Students s
INNER JOIN Programs p ON s.ProgramId = p.ProgramId;
```

<img width="672" height="151" alt="Screenshot 2026-10-22 215157" src="https://github.com/user-attachments/assets/87833b5f-042c-40b8-83ad-8ce78e1fe651" />

_Keterangan: data mahasiswa tampil beserta nama program studinya._

### 3.5 Struktur Database & Relationship 

<img width="426" height="853" alt="image" src="https://github.com/user-attachments/assets/f3e67ddd-7dde-4991-9cef-dc10a358e3fc" />

_Keterangan: Tables → dbo.Programs dan dbo.Students, beserta kolom-kolomnya._

---

## 4. Pengujian Constraint

### 4.1 Foreign Key 

Insert mahasiswa dengan `ProgramId = 99` (tidak ada di `Programs`). SQL Server harus menolak.

<img width="1357" height="117" alt="Screenshot 2026-10-22 215418" src="https://github.com/user-attachments/assets/fbecd92e-f9a0-46b2-b571-8264b637f7bc" />

_Keterangan: pesan error `FOREIGN KEY constraint "FK_Students_Programs" conflict`. Terbukti integritas referensial terjaga._

### 4.2 Unique NIM 

Insert mahasiswa dengan NIM `20231001` yang sudah ada. SQL Server harus menolak.

<img width="1058" height="112" alt="Screenshot 2026-10-22 215507" src="https://github.com/user-attachments/assets/3c7479b9-00bb-4541-88bf-26e28cdaf1e7" />

_Keterangan: pesan error `Violation of UNIQUE KEY constraint "UQ_Students_NIM"`. Terbukti NIM tidak boleh duplikat._

---

## 5. Query Challenge

| No | Tujuan | Konsep |
|---|---|---|
| 1 | Tampilkan seluruh mahasiswa | `SELECT *` |
| 2 | Tampilkan mahasiswa Teknik Informatika | `INNER JOIN` + `WHERE` |
| 3 | Hitung jumlah mahasiswa | `COUNT(*)` |
| 4 | Hitung mahasiswa per program studi | `LEFT JOIN` + `GROUP BY` |

<img width="988" height="151" alt="Screenshot 2026-10-22 220142" src="https://github.com/user-attachments/assets/14990489-f149-4656-8997-ec6452c2c2ac" />

_Keterangan: hasil Challenge 1._

<img width="325" height="92" alt="Screenshot 2026-10-22 220155" src="https://github.com/user-attachments/assets/6806afde-12ea-419e-b9a2-2238236dcfcf" />

_Keterangan: hasil Challenge 2._

<img width="183" height="75" alt="Screenshot 2026-10-22 220212" src="https://github.com/user-attachments/assets/beed94e7-3575-4b6f-9a07-93030dc25aa1" />

_Keterangan: hasil Challenge 3._

<img width="327" height="152" alt="Screenshot 2026-10-22 220222" src="https://github.com/user-attachments/assets/a33cc163-4cac-4eca-9173-c34b6b8199ad" />

_Keterangan: hasil Challenge 4._

---

## 6. Mini Assignment

Menambahkan 3 mahasiswa baru: 1 Teknik Informatika, 1 Sistem Informasi, 1 Teknik Elektro, lalu menjalankan:

```sql
SELECT s.NIM, s.Name, p.ProgramName, s.BirthDate, s.PhoneNumber
FROM Students s
INNER JOIN Programs p ON s.ProgramId = p.ProgramId
ORDER BY s.Name;
```

<img width="530" height="215" alt="Screenshot 2026-10-22 220419" src="https://github.com/user-attachments/assets/caa1346f-da06-4271-aa9c-a438975d9a76" />

_Keterangan: hasil JOIN akhir berisi 8 mahasiswa, terurut berdasarkan nama._

---

## 7. Kesimpulan

Database **StudentRegistrationDB** berhasil dibangun dengan dua tabel berelasi 1:N. Constraint PRIMARY KEY, UNIQUE, dan FOREIGN KEY terbukti menjaga integritas data: NIM duplikat dan `ProgramId` yang tidak valid ditolak oleh SQL Server. Query `JOIN`, `WHERE`, `COUNT`, dan `GROUP BY` berjalan sesuai harapan. Database ini siap dihubungkan ke aplikasi WPF + C# menggunakan ADO.NET pada Hands-On Lab berikutnya dengan connection string:

```csharp
string connectionString =
    @"Server=.\SQLEXPRESS;
      Database=StudentRegistrationDB;
      Trusted_Connection=True;
      TrustServerCertificate=True;";
```
---

# Student Registration — WPF + C# + ADO.NET + SQL Server

Laporan **Hands-On Lab 2**: aplikasi WPF yang terhubung ke SQL Server menggunakan ADO.NET dan menampilkan data mahasiswa pada DataGrid.

---

## 1. Deskripsi & Tujuan

Aplikasi membaca data tabel `Students` (digabung dengan `Programs`) dari SQL Server dan menampilkannya di `DataGrid`. Tombol **Refresh** mengambil ulang data dari database.

Tujuan praktikum:
- Membuat project WPF dengan C#.
- Menghubungkan WPF dengan SQL Server memakai ADO.NET.
- Membuat Model `Student` dan `Program`, serta `StudentRepository`.
- Menggunakan `SqlConnection`, `SqlCommand`, dan `SqlDataReader`.
- Menampilkan data pada DataGrid melalui data binding.

## 2. Arsitektur

```
WPF UI (MainWindow)
      │
      ▼
StudentRepository  (Data Access)
      │
      ▼
ADO.NET (SqlConnection → SqlCommand → SqlDataReader)
      │
      ▼
SQL Server → StudentRegistrationDB
               ├── Programs (1)
               └── Students (N)
```

Alur data:

```
SQL Server ─SELECT→ SqlDataReader → Student object → List<Student> → ItemsSource → DataGrid
```

## 3. Struktur Project

```
StudentRegistration
├── Models
│   ├── Student.cs               # model data mahasiswa
│   └── Program.cs               # model program studi
├── Repositories
│   └── StudentRepository.cs     # akses data ke SQL Server
├── MainWindow.xaml              # UI WPF
├── MainWindow.xaml.cs           # event dan UI logic
├── App.xaml
├── App.xaml.cs
└── StudentRegistration.csproj
```

| File | Tanggung jawab |
|---|---|
| `Student.cs` | Model data mahasiswa |
| `Program.cs` | Model program studi (bukan entry point) |
| `StudentRepository.cs` | Data access ke SQL Server |
| `MainWindow.xaml` | User Interface WPF |
| `MainWindow.xaml.cs` | Event dan UI logic |

## 4. Penjelasan Implementasi

### 4.1 Connection String

```csharp
private readonly string _connectionString =
    @"Server=.\SQLEXPRESS;
      Database=StudentRegistrationDB;
      Trusted_Connection=True;
      TrustServerCertificate=True;";
```

### 4.2 Query dan Pembacaan Data

```sql
SELECT s.StudentId, s.NIM, s.Name, s.ProgramId, p.ProgramName,
       s.BirthDate, s.Address, s.PhoneNumber, s.CreatedAt, s.UpdatedAt
FROM Students s
INNER JOIN Programs p ON s.ProgramId = p.ProgramId
ORDER BY s.StudentId;
```

```csharp
using var connection = new SqlConnection(_connectionString);
using var command    = new SqlCommand(sql, connection);
connection.Open();
using var reader = command.ExecuteReader();
while (reader.Read()) { students.Add(new Student { /* mapping kolom */ }); }
```

Kolom yang boleh `NULL` (`BirthDate`, `Address`, `PhoneNumber`, `UpdatedAt`) dicek dengan `reader.IsDBNull(...)` sebelum dibaca.

### 4.3 Data Binding

```xml
<DataGridTextColumn Header="NIM" Binding="{Binding NIM}" Width="100"/>
```

Binding menghubungkan property `Student.NIM` dengan kolom **NIM** pada DataGrid.

### 4.4 Penanganan Error

`LoadStudents()` dibungkus `try/catch`. Jika koneksi atau query gagal, aplikasi menampilkan `MessageBox` **Database Error**.

### 4.5 Mini Challenge

| Challenge | Implementasi |
|---|---|
| 1 — Alamat | Kolom `Alamat` pada DataGrid |
| 2 — CreatedAt | Kolom `Dibuat` pada DataGrid |
| 3 — Total Mahasiswa | `GetTotalCount()` dengan `SELECT COUNT(*) FROM Students` dan label total di bawah DataGrid |

---

## 5. Dokumentasi 

### 5.1 Verifikasi Prasyarat di SSMS

<img width="1017" height="213" alt="image" src="https://github.com/user-attachments/assets/09f613f4-8e32-4831-8dcf-a691b8796dcd" />

_Keterangan: `SELECT * FROM Students` menghasilkan data di SSMS._

### 5.2 Struktur Project di Solution Explorer

<img width="387" height="505" alt="image" src="https://github.com/user-attachments/assets/50d83076-716a-4a83-b5be-9af96c8aa8b9" />

_Keterangan: folder Models, Repositories, dan file utama project._

### 5.3 Aplikasi Berjalan — Data Tampil di DataGrid

<img width="1540" height="611" alt="Screenshot 2026-10-25 212338" src="https://github.com/user-attachments/assets/dd450c85-1016-4bfd-849d-bacb25cf0e0f" />

_Keterangan: DataGrid menampilkan data mahasiswa dari SQL Server._

---

## 6. Kesimpulan

Aplikasi WPF berhasil terhubung ke SQL Server melalui ADO.NET. Pemisahan tanggung jawab antara Model, Repository, dan UI membuat kode lebih rapi: Repository mengambil data dengan `SqlConnection`, `SqlCommand`, dan `SqlDataReader`, memetakannya ke `List<Student>`, lalu `DataGrid` menampilkannya melalui data binding. Fondasi ini dilanjutkan pada Lab 3 (CRUD: tambah, edit, hapus, cari), lalu MVVM pada lab berikutnya.
