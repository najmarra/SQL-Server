IF DB_ID('StudentRegistrationDB') IS NULL
    CREATE DATABASE StudentRegistrationDB;
GO

USE StudentRegistrationDB;
GO

SELECT DB_NAME() AS CurrentDatabase;
GO

IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL DROP TABLE dbo.Students;   -- supaya script bisa diulang
IF OBJECT_ID('dbo.Programs', 'U') IS NOT NULL DROP TABLE dbo.Programs;
GO

CREATE TABLE Programs
(
    ProgramId INT IDENTITY(1,1)
        CONSTRAINT PK_Programs PRIMARY KEY,

    ProgramCode VARCHAR(20) NOT NULL
        CONSTRAINT UQ_Programs_ProgramCode UNIQUE,

    ProgramName VARCHAR(100) NOT NULL,

    IsActive BIT NOT NULL
        CONSTRAINT DF_Programs_IsActive DEFAULT 1,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Programs_CreatedAt
        DEFAULT SYSDATETIME()
);
GO

INSERT INTO Programs
(
    ProgramCode,
    ProgramName
)
VALUES
('TI',  'Teknik Informatika'),
('SI',  'Sistem Informasi'),
('MNJ', 'Manajemen'),
('TE',  'Teknik Elektro'),
('DKV', 'Desain Komunikasi Visual');
GO

SELECT *
FROM Programs;
GO

CREATE TABLE Students
(
    StudentId INT IDENTITY(1,1)
        CONSTRAINT PK_Students PRIMARY KEY,

    NIM VARCHAR(20) NOT NULL
        CONSTRAINT UQ_Students_NIM UNIQUE,

    Name VARCHAR(100) NOT NULL,

    ProgramId INT NOT NULL,

    BirthDate DATE NULL,

    Address VARCHAR(250) NULL,

    PhoneNumber VARCHAR(20) NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Students_CreatedAt
        DEFAULT SYSDATETIME(),

    UpdatedAt DATETIME2 NULL,

    CONSTRAINT FK_Students_Programs
        FOREIGN KEY (ProgramId)
        REFERENCES Programs(ProgramId)
);
GO

INSERT INTO Students
(
    NIM,
    Name,
    ProgramId,
    BirthDate,
    Address,
    PhoneNumber
)
VALUES
(
    '20231001',
    'Ahmad Rizki',
    1,
    '2003-03-12',
    'Jl. Merdeka No. 123, Surabaya',
    '081234567890'
),
(
    '20231002',
    'Siti Aisyah',
    2,
    '2004-07-21',
    'Jl. Diponegoro No. 45, Surabaya',
    '082233445566'
),
(
    '20231003',
    'Budi Santoso',
    1,
    '2003-11-05',
    'Jl. Ahmad Yani No. 10, Surabaya',
    '081355667788'
),
(
    '20231004',
    'Citra Lestari',
    3,
    '2004-01-18',
    'Jl. Darmo No. 20, Surabaya',
    '089900112233'
),
(
    '20231005',
    'Dimas Prayoga',
    4,
    '2003-09-27',
    'Jl. Raya ITS, Surabaya',
    '081288776655'
);
GO

SELECT *
FROM Students;
GO

SELECT
    s.StudentId,
    s.NIM,
    s.Name,
    p.ProgramCode,
    p.ProgramName,
    s.BirthDate,
    s.PhoneNumber
FROM Students s
INNER JOIN Programs p
    ON s.ProgramId = p.ProgramId;
GO

BEGIN TRY
    INSERT INTO Students
    (
        NIM,
        Name,
        ProgramId
    )
    VALUES
    (
        '20231099',
        'Test Student',
        99
    );
    PRINT 'PERINGATAN: data masuk, seharusnya ditolak!';
END TRY
BEGIN CATCH
    PRINT 'LAB 19 OK - ditolak: ' + ERROR_MESSAGE();
END CATCH;
GO

BEGIN TRY
    INSERT INTO Students
    (
        NIM,
        Name,
        ProgramId
    )
    VALUES
    (
        '20231001',
        'Mahasiswa Duplikat',
        1
    );
    PRINT 'PERINGATAN: data masuk, seharusnya ditolak!';
END TRY
BEGIN CATCH
    PRINT 'LAB 20 OK - ditolak: ' + ERROR_MESSAGE();
END CATCH;
GO

-- Challenge 1 - Tampilkan seluruh mahasiswa
SELECT *
FROM Students;
GO

-- Challenge 2 - Tampilkan mahasiswa Teknik Informatika
SELECT
    s.NIM,
    s.Name,
    p.ProgramName
FROM Students s
INNER JOIN Programs p
    ON s.ProgramId = p.ProgramId
WHERE p.ProgramCode = 'TI';
GO

-- Challenge 3 - Hitung jumlah mahasiswa
SELECT COUNT(*) AS TotalMahasiswa
FROM Students;
GO

-- Challenge 4 - Hitung mahasiswa berdasarkan program studi
SELECT
    p.ProgramName,
    COUNT(s.StudentId) AS JumlahMahasiswa
FROM Programs p
LEFT JOIN Students s
    ON p.ProgramId = s.ProgramId
GROUP BY
    p.ProgramId,
    p.ProgramName;
GO

INSERT INTO Students (NIM, Name, ProgramId, BirthDate, Address, PhoneNumber)
VALUES
(
    '20231006',
    'Eko Prasetyo',
    (SELECT ProgramId FROM Programs WHERE ProgramCode = 'TI'),
    '2003-05-14',
    'Jl. Kertajaya No. 7, Surabaya',
    '081377889900'
),
(
    '20231007',
    'Fitri Handayani',
    (SELECT ProgramId FROM Programs WHERE ProgramCode = 'SI'),
    '2004-02-09',
    'Jl. Raya Gubeng No. 15, Surabaya',
    '085611223344'
),
(
    '20231008',
    'Gilang Ramadhan',
    (SELECT ProgramId FROM Programs WHERE ProgramCode = 'TE'),
    '2003-12-30',
    'Jl. Mulyorejo No. 3, Surabaya',
    '087755443322'
);
GO

SELECT
    s.NIM,
    s.Name,
    p.ProgramName,
    s.BirthDate,
    s.PhoneNumber
FROM Students s
INNER JOIN Programs p
    ON s.ProgramId = p.ProgramId
ORDER BY s.Name;
GO