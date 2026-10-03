-- ============================================
-- Banking Transaction Management System (BTMS)
-- Database Schema
-- ============================================

CREATE DATABASE btms_db;

USE btms_db;


-- ============================================
-- 1. Customers
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,

    CONSTRAINT chk_customer_phone
    CHECK (phone REGEXP '^[0-9]+$')
);


-- ============================================
-- 2. Accounts
-- ============================================

CREATE TABLE accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_type ENUM('Savings', 'Current', 'Wallet') NOT NULL,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT chk_account_balance
    CHECK (balance >= 0),

    CONSTRAINT fk_account_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);


-- ============================================
-- 3. Transaction Categories
-- ============================================

CREATE TABLE transaction_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,

    category_name ENUM(
        'Utilities',
        'Shopping',
        'Salary',
        'Entertainment',
        'Other'
    ) NOT NULL UNIQUE
);


-- ============================================
-- 4. Branches
-- ============================================

CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) UNIQUE
);


-- ============================================
-- 5. Employees
-- ============================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL UNIQUE,
    branch_id INT NOT NULL,

    CONSTRAINT fk_employee_branch
    FOREIGN KEY (branch_id)
    REFERENCES branches(branch_id)
);


-- ============================================
-- 6. Transactions
-- ============================================

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,

    sender_account INT NOT NULL,

    receiver_account INT NULL,

    category_id INT NULL,

    transaction_type ENUM(
        'Deposit',
        'Withdrawal',
        'Transfer',
        'Bill Payment'
    ) NOT NULL,

    amount DECIMAL(15,2) NOT NULL,

    transaction_status ENUM(
        'Success',
        'Failed',
        'Pending'
    ) NOT NULL DEFAULT 'Pending',

    transaction_date DATE NOT NULL,

    approved_by INT NULL,

    CONSTRAINT chk_transaction_amount
    CHECK (amount > 0),

    CONSTRAINT fk_transaction_sender
    FOREIGN KEY (sender_account)
    REFERENCES accounts(account_number),

    CONSTRAINT fk_transaction_receiver
    FOREIGN KEY (receiver_account)
    REFERENCES accounts(account_number),

    CONSTRAINT fk_transaction_category
    FOREIGN KEY (category_id)
    REFERENCES transaction_categories(category_id),

    CONSTRAINT fk_transaction_approved_by
    FOREIGN KEY (approved_by)
    REFERENCES employees(employee_id)
);


-- ============================================
-- 7. Fees
-- ============================================

CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,

    transaction_id INT NOT NULL,

    fee_type ENUM(
        'Transfer Fee',
        'Failed Transaction Fee',
        'Over Limit Fee'
    ) NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    CONSTRAINT chk_fee_amount
    CHECK (amount > 0),

    CONSTRAINT fk_fee_transaction
    FOREIGN KEY (transaction_id)
    REFERENCES transactions(transaction_id)
);


-- ============================================
-- 8. Transfer Limits
-- ============================================

CREATE TABLE transfer_limits (
    limit_id INT PRIMARY KEY AUTO_INCREMENT,

    daily_limit DECIMAL(15,2) NOT NULL,

    CONSTRAINT chk_daily_limit
    CHECK (daily_limit > 0)
);


-- ============================================
-- Sample Daily Transfer Limit
-- ============================================

INSERT INTO transfer_limits (daily_limit)
VALUES (40000);

######========================================================================================================================================================================================================================================================================











USE btms_db;

-- ============================================
-- 1. Insert Customers
-- ============================================

INSERT INTO customers
(full_name, date_of_birth, email, phone)
VALUES
('Ahmed Ali', '1995-05-10', 'ahmed@test.com', '01012345678'),
('Mona Hassan', '1998-08-15', 'mona@test.com', '01123456789'),
('Omar Mohamed', '1992-03-20', 'omar@test.com', '01234567890'),
('Sara Ahmed', '1997-11-25', 'sara@test.com', '01555555555');


-- ============================================
-- 2. Insert Accounts
-- ============================================

INSERT INTO accounts
(customer_id, account_type, balance)
VALUES
(1, 'Savings', 10000.00),
(1, 'Current', 5000.00),
(2, 'Savings', 15000.00),
(2, 'Wallet', 3000.00),
(3, 'Current', 8000.00),
(4, 'Savings', 20000.00);


-- ============================================
-- 3. Insert Transaction Categories
-- ============================================

INSERT INTO transaction_categories
(category_name)
VALUES
('Utilities'),
('Shopping'),
('Salary'),
('Entertainment'),
('Other');


-- ============================================
-- 4. Insert Branches
-- ============================================

INSERT INTO branches
(name, location)
VALUES
('Maadi Branch', 'Maadi'),
('Nasr City Branch', 'Nasr City'),
('Heliopolis Branch', 'Heliopolis');


-- ============================================
-- 5. Insert Employees
-- ============================================

INSERT INTO employees
(full_name, branch_id)
VALUES
('Mohamed Hassan', 1),
('Ahmed Samir', 1),
('Sara Mahmoud', 2),
('Omar Ali', 3);


-- ============================================
-- 6. Insert Transactions
-- ============================================

INSERT INTO transactions
(sender_account, receiver_account, category_id,
 transaction_type, amount, transaction_status, transaction_date, approved_by)
VALUES
(1, 2, 2, 'Transfer', 500.00, 'Success', '2026-08-31', 1),

(2, NULL, 1, 'Withdrawal', 200.00, 'Success', '2026-08-31', 1),

(3, 1, 3, 'Transfer', 1000.00, 'Success', '2026-08-31', 2),

(4, NULL, 2, 'Bill Payment', 300.00, 'Success', '2026-08-31', 3),

(5, NULL, 3, 'Withdrawal', 500.00, 'Failed', '2026-08-31', 4);


-- ============================================
-- 7. Insert Fees
-- ============================================

INSERT INTO fees
(transaction_id, fee_type, amount)
VALUES
(1, 'Transfer Fee', 25.00),

(5, 'Failed Transaction Fee', 10.00);


-- ============================================
-- 8. Insert Transfer Limit
-- ============================================

INSERT INTO transfer_limits
(daily_limit)
VALUES
(10000.00);

UPDATE transfer_limits
SET daily_limit = 40000.00
WHERE limit_id = 1;


SELECT * FROM transfer_limits;