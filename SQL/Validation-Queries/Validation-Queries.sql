-- ============================================
-- Banking Transaction Management System (BTMS)
-- Validation Queries for Database Testing
-- ============================================

USE btms_db;

-- ============================================
-- 1. Basic Data Validation
-- ============================================

SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM transaction_categories;
SELECT * FROM branches;
SELECT * FROM employees;
SELECT * FROM transactions;
SELECT * FROM fees;
SELECT * FROM transfer_limits;


-- ============================================
-- 2. Customer Validation
-- ============================================

-- Check duplicate emails
SELECT email, COUNT(*) AS email_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- Check duplicate phone numbers
SELECT phone, COUNT(*) AS phone_count
FROM customers
GROUP BY phone
HAVING COUNT(*) > 1;

-- Check invalid phone format
SELECT *
FROM customers
WHERE phone NOT REGEXP '^[0-9]+$';

-- Check missing mandatory customer data
SELECT *
FROM customers
WHERE full_name IS NULL
   OR date_of_birth IS NULL
   OR email IS NULL
   OR phone IS NULL;


-- ============================================
-- 3. Account Validation
-- ============================================

-- Check negative balances
SELECT *
FROM accounts
WHERE balance < 0;

-- Check accounts without a valid customer
SELECT a.*
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Check supported account types
SELECT *
FROM accounts
WHERE account_type NOT IN ('Savings', 'Current', 'Wallet');


-- ============================================
-- 4. Transaction Validation
-- ============================================

-- Check invalid transaction amounts
SELECT *
FROM transactions
WHERE amount <= 0;

-- Check invalid transaction types
SELECT *
FROM transactions
WHERE transaction_type NOT IN
('Deposit', 'Withdrawal', 'Transfer', 'Bill Payment');

-- Check invalid transaction statuses
SELECT *
FROM transactions
WHERE transaction_status NOT IN
('Success', 'Failed', 'Pending');

-- Check transactions with invalid sender accounts
SELECT t.*
FROM transactions t
LEFT JOIN accounts a
    ON t.sender_account = a.account_number
WHERE a.account_number IS NULL;

-- Check transactions with invalid receiver accounts
SELECT t.*
FROM transactions t
LEFT JOIN accounts a
    ON t.receiver_account = a.account_number
WHERE t.receiver_account IS NOT NULL
  AND a.account_number IS NULL;


-- ============================================
-- 5. Transaction Business Rule Validation
-- ============================================

-- Check withdrawals/transfers that exceed available balance
SELECT
    t.transaction_id,
    t.sender_account,
    t.transaction_type,
    t.amount,
    a.balance
FROM transactions t
JOIN accounts a
    ON t.sender_account = a.account_number
WHERE t.transaction_type IN ('Withdrawal', 'Transfer')
  AND t.amount > a.balance;

-- Check failed transactions
SELECT *
FROM transactions
WHERE transaction_status = 'Failed';

-- Check whether failed transactions have affected
-- the related account balance by reviewing transaction
-- and account records.
SELECT
    t.transaction_id,
    t.sender_account,
    t.amount,
    t.transaction_status,
    a.balance
FROM transactions t
JOIN accounts a
    ON t.sender_account = a.account_number
WHERE t.transaction_status = 'Failed';


-- ============================================
-- 6. Transfer Limit Validation
-- ============================================

-- Current configured daily transfer limit
SELECT *
FROM transfer_limits;

-- Calculate total successful transfers per day
SELECT
    transaction_date,
    SUM(amount) AS total_transfer_amount
FROM transactions
WHERE transaction_type = 'Transfer'
  AND transaction_status = 'Success'
GROUP BY transaction_date;

-- Compare each day's transfer total with the configured limit
SELECT
    t.transaction_date,
    SUM(t.amount) AS total_transfer_amount,
    tl.daily_limit,
    CASE
        WHEN SUM(t.amount) > tl.daily_limit THEN 'EXCEEDS LIMIT'
        ELSE 'WITHIN LIMIT'
    END AS limit_status
FROM transactions t
CROSS JOIN transfer_limits tl
WHERE t.transaction_type = 'Transfer'
  AND t.transaction_status = 'Success'
GROUP BY t.transaction_date, tl.daily_limit;


-- ============================================
-- 7. Fee Validation
-- ============================================

-- Check invalid fee amounts
SELECT *
FROM fees
WHERE amount <= 0;

-- Check fees linked to non-existing transactions
SELECT f.*
FROM fees f
LEFT JOIN transactions t
    ON f.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;

-- Check transfer fees
SELECT *
FROM fees
WHERE fee_type = 'Transfer Fee';

-- Check failed transaction fees
SELECT *
FROM fees
WHERE fee_type = 'Failed Transaction Fee';


-- ============================================
-- 8. Referential Integrity Validation
-- ============================================

-- Accounts -> Customers
SELECT a.*
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Employees -> Branches
SELECT e.*
FROM employees e
LEFT JOIN branches b
    ON e.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- Transactions -> Categories
SELECT t.*
FROM transactions t
LEFT JOIN transaction_categories c
    ON t.category_id = c.category_id
WHERE t.category_id IS NOT NULL
  AND c.category_id IS NULL;

-- Transactions -> Approved Employees
SELECT t.*
FROM transactions t
LEFT JOIN employees e
    ON t.approved_by = e.employee_id
WHERE t.approved_by IS NOT NULL
  AND e.employee_id IS NULL;


-- ============================================
-- 9. Balance / Transaction Review
-- ============================================

-- Review account balances
SELECT
    account_number,
    customer_id,
    account_type,
    balance
FROM accounts
ORDER BY account_number;

-- Review successful transactions
SELECT
    transaction_id,
    sender_account,
    receiver_account,
    transaction_type,
    amount,
    transaction_status,
    transaction_date
FROM transactions
WHERE transaction_status = 'Success'
ORDER BY transaction_date, transaction_id;


-- ============================================
-- 10. Test Evidence Queries
-- ============================================

-- Count total test data records
SELECT
    (SELECT COUNT(*) FROM customers) AS customers_count,
    (SELECT COUNT(*) FROM accounts) AS accounts_count,
    (SELECT COUNT(*) FROM transactions) AS transactions_count,
    (SELECT COUNT(*) FROM fees) AS fees_count,
    (SELECT COUNT(*) FROM branches) AS branches_count,
    (SELECT COUNT(*) FROM employees) AS employees_count;
