

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountType ENUM('Savings', 'Checking') NOT NULL,
    Balance DECIMAL(15, 2) DEFAULT 0.00,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    Type ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    Amount DECIMAL(15, 2) NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Description TEXT,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID) ON DELETE CASCADE
);

INSERT INTO Customers (FullName, Email, Phone, Address) VALUES
('Sourav Pradhan', 'sourav@example.com', '9876543210', '123 Main St, west Bengal'),
('Satya Pradhan', 'satya@example.com', '8765432109', '456 Elm St, Delhi'),
('Som Pradhan', 'som@example.com', '7654321098', '789 Oak St, kolkata');

INSERT INTO Accounts (CustomerID, AccountType, Balance) VALUES
(1, 'Savings', 1500.00),
(2, 'Checking', 2500.00),
(3, 'Savings', 3000.00);

INSERT INTO Transactions (AccountID, Type, Amount, Description) VALUES
(1, 'Deposit', 500.00, 'Initial deposit'),
(1, 'Withdrawal', 200.00, 'ATM withdrawal'),
(2, 'Deposit', 1000.00, 'Salary credited'),
(3, 'Withdrawal', 500.00, 'Online purchase'),
(2, 'Transfer', 300.00, 'Transfer to another account');

SELECT * FROM Customers;

SELECT a.AccountID, c.FullName, a.AccountType, a.Balance, a.CreatedAt
FROM Accounts a
JOIN Customers c ON a.CustomerID = c.CustomerID;

SELECT t.*
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
WHERE a.CustomerID = 1;

UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountID = 1;
INSERT INTO Transactions (AccountID, Type, Amount, Description)
VALUES (1, 'Deposit', 1000, 'Manual deposit');

UPDATE Accounts SET Balance = Balance - 500 WHERE AccountID = 2 AND Balance >= 500;
INSERT INTO Transactions (AccountID, Type, Amount, Description)
VALUES (2, 'Withdrawal', 500, 'Manual withdrawal');

SELECT SUM(Balance) AS TotalBankBalance FROM Accounts;
