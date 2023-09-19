CREATE DATABASE AZBank;
GO

USE AZBank;
GO
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100)
);
GO

CREATE TABLE CustomerAccount (
    AccountNumber INT PRIMARY KEY,
    CustomerID INT,
    Phone VARCHAR(15),
    Email VARCHAR(50),
    Balance DECIMAL(18, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO

CREATE TABLE CustomerTransaction (
    TransactionID INT PRIMARY KEY,
    AccountNumber INT,
    TransactionDate DATE,
    Amount DECIMAL(18, 2),
    DepositorWithdraw VARCHAR(10),
    FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount(AccountNumber),
    CHECK (Amount > 0 AND Amount <= 1000000)
);
GO


INSERT INTO Customer (CustomerID, Name, Address)
VALUES (1, 'Ngoc Anh', 'Bacninh'),
       (2, 'Khanh NGoc', 'Hanoi'),
       (3, 'Thanh Hien', 'Hanoi');


INSERT INTO CustomerAccount (AccountNumber, CustomerID, Phone, Email, Balance)
VALUES (1001, 1, '0999999999', 'ngocanh@example.com', 4000.00),
       (1002, 2, '0111111111', 'khanhngoc@example.com', 20000.00),
       (1003, 3, '5555555555', 'thanhhien@example.com', 7000.00);


INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES (101, 1001, '2023-09-13', 2000.00, 'Deposit'),
       (102, 1002, '2023-09-12', 400.00, 'Withdraw'),
       (103, 1003, '2023-09-11', 5000.00, 'Deposit');

SELECT * FROM Customer WHERE Address LIKE 'Hanoi';

SELECT C.Name, CA.Phone, CA.Email, CA.AccountNumber, CA.Balance FROM CustomerAccount CA JOIN Customer C ON CA.CustomerID = C.CustomerID;

CREATE VIEW CustomerTransactions AS
SELECT C.Name, CT.AccountNumber, CT.TransactionDate, CT.Amount, CT.DepositorWithdraw
FROM CustomerTransaction CT
JOIN CustomerAccount CA ON CT.AccountNumber = CA.AccountNumber
JOIN Customer C ON CA.CustomerID = C.CustomerID;