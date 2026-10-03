-- ============================================
-- Banking Transaction Management System (BTMS)
-- UPDATE Queries for Database Testing
-- ============================================

USE btms_db;

-- 1. Update customer information - Positive
UPDATE customers
SET full_name = 'Ahmed Ali Updated',
    phone = '01099999999'
WHERE customer_id = 1;

-- 2. Update account balance - Positive
UPDATE accounts
SET balance = 12000.00
WHERE account_number = 1;

-- 3. Update transaction status - Positive
UPDATE transactions
SET transaction_status = 'Success'
WHERE transaction_id = 1;

-- 4. Update transaction category - Positive
UPDATE transaction_categories
SET category_name = 'Shopping'
WHERE category_id = 2;

-- 5. Update branch location - Positive
UPDATE branches
SET location = 'New Cairo'
WHERE branch_id = 1;

-- 6. Update employee branch - Positive
UPDATE employees
SET branch_id = 2
WHERE employee_id = 1;

-- 7. Update transaction amount - Positive
UPDATE transactions
SET amount = 600.00
WHERE transaction_id = 1;

-- 8. Update transfer limit - Positive
UPDATE transfer_limits
SET daily_limit = 40000.00
WHERE limit_id = 1;


-- ============================================
-- Negative / Constraint-Oriented UPDATE Tests
-- Execute individually when testing constraints.
-- ============================================

-- 9. Negative: Account balance below zero
-- Expected: UPDATE rejected because balance >= 0.
UPDATE accounts
SET balance = -100.00
WHERE account_number = 1;

-- 10. Negative: Transaction amount equal to zero
-- Expected: UPDATE rejected because amount > 0.
UPDATE transactions
SET amount = 0.00
WHERE transaction_id = 1;

-- 11. Negative: Transaction amount below zero
-- Expected: UPDATE rejected because amount > 0.
UPDATE transactions
SET amount = -500.00
WHERE transaction_id = 1;

-- 12. Negative: Fee amount below zero
-- Expected: UPDATE rejected because fee amount > 0.
UPDATE fees
SET amount = -10.00
WHERE fee_id = 1;

-- 13. Negative: Daily transfer limit below zero
-- Expected: UPDATE rejected because daily_limit > 0.
UPDATE transfer_limits
SET daily_limit = 0.00
WHERE limit_id = 1;

-- 14. Negative: Invalid transaction status
-- Expected: UPDATE rejected because transaction_status is ENUM.
UPDATE transactions
SET transaction_status = 'Invalid'
WHERE transaction_id = 1;

-- 15. Negative: Invalid transaction type
-- Expected: UPDATE rejected because transaction_type is ENUM.
UPDATE transactions
SET transaction_type = 'Invalid'
WHERE transaction_id = 1;

-- 16. Negative: Invalid account type
-- Expected: UPDATE rejected because account_type is ENUM.
UPDATE accounts
SET account_type = 'Invalid'
WHERE account_number = 1;

-- 17. Negative: Invalid category
-- Expected: UPDATE rejected because category_name is ENUM.
UPDATE transaction_categories
SET category_name = 'Invalid'
WHERE category_id = 1;

-- 18. Negative: Invalid sender account
-- Expected: UPDATE rejected because sender_account is a foreign key.
UPDATE transactions
SET sender_account = 99999
WHERE transaction_id = 1;

-- 19. Negative: Invalid receiver account
-- Expected: UPDATE rejected because receiver_account is a foreign key.
UPDATE transactions
SET receiver_account = 99999
WHERE transaction_id = 1;

-- 20. Negative: Invalid approved employee
-- Expected: UPDATE rejected because approved_by is a foreign key.
UPDATE transactions
SET approved_by = 99999
WHERE transaction_id = 1;
