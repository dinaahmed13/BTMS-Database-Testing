# Banking Transaction Management System (BTMS)
## QA & Database Testing Project

![Testing](https://img.shields.io/badge/Testing-Manual%20%7C%20Database-blue)
![Database](https://img.shields.io/badge/Database-MySQL-orange)
![Test Management](https://img.shields.io/badge/Test%20Management-Jira-green)
![Status](https://img.shields.io/badge/Project-Completed-success)

---

## 📌 Project Overview

The **Banking Transaction Management System (BTMS)** is a database-focused
banking system designed to manage customer accounts, financial transactions,
transaction categories, fees, branches, and employees.

The project focuses on validating **data integrity, business rules,
relational consistency, constraints, and database behavior**.

The testing scope covers **INSERT and UPDATE operations**, with SQL
validation queries used to verify the resulting database state.

---

## 🎯 Testing Objectives

The main objectives of this project were to:

- Validate database requirements and business rules.
- Verify data integrity and relational consistency.
- Validate primary key and foreign key relationships.
- Verify database constraints and valid data values.
- Validate account balance behavior.
- Verify transaction processing rules.
- Validate transaction fees and limits.
- Identify, document, and track defects.
- Execute UAT and report test results.

---

## 🔍 Testing Scope

### In Scope

- Customer Management
- Account Management
- Transaction Management
- Transaction Categories
- Fees & Charges
- Branch Management
- Employee Management
- Account Balance Management
- Database Constraints
- Business Rules
- Triggers

### Out of Scope

- Front-end UI Testing
- API Testing
- Reporting Dashboards

---

## 🧪 Testing Activities

The project covered the following QA activities:

1. **Requirements Analysis**
2. **Test Estimation & Sizing**
3. **Test Planning**
4. **Test Case Design**
5. **Test Data Preparation**
6. **Database Test Execution**
7. **SQL Data Validation**
8. **Defect Reporting & Tracking**
9. **User Acceptance Testing (UAT)**
10. **Test Status Reporting**



---

## 📊 Test Execution Summary

| Metric | Result |
|---|---:|
| Total Test Cases | **119** |
| Executed | **119** |
| Passed | **103** |
| Failed | **16** |
| Blocked | **0** |
| Not Executed | **0** |

### Execution Status

**119 / 119 test cases were executed.**

- Pass: **103**
- Fail: **16**
- Blocked: **0**
- Not Executed: **0**

---

## 🐞 Defect Summary

A total of **16 defects** were identified and tracked.

| Severity | Count |
|---|---:|
| High | **11** |
| Medium | **5** |
| Low | **0** |
| Total | **16** |

Defects were documented and tracked through **Jira**, including:

- Defect title
- Description
- Environment
- Preconditions
- Steps to reproduce
- Test data
- Expected result
- Actual result
- Impact
- Severity
- Priority


---

## 🗄️ Database Testing

Database testing was performed using SQL to validate:

- Data integrity
- Primary key constraints
- Foreign key relationships
- Mandatory fields
- Unique values
- Valid ENUM values
- Account balances
- Transaction amounts
- Transaction status
- Transaction types
- Transaction fees
- Daily transfer limits
- Failed transaction behavior
- Relational consistency

### SQL Validation

`SELECT` queries were used to validate:

- Account balances
- Transaction totals
- Fee calculations
- Failed transactions
- Daily transfer limits
- Referential integrity

---

## 💼 Key Business Rules Tested

The testing covered important banking business rules, including:

- Transactions cannot exceed the available balance.
- Transfers must correctly deduct and add account balances.
- Failed transactions should not affect balances.
- Daily transaction limits must be enforced.
- Fees should be applied according to defined rules.
- Customer email addresses must be unique.
- Account balances must remain non-negative.
- Transaction amounts must be greater than zero.
- Valid transaction types and statuses must be enforced.

---

## 🧩 Test Case Design

Test cases were designed using both:

### Positive Testing
- Valid customer creation
- Valid account creation
- Valid transactions
- Valid balance updates
- Valid fee processing

### Negative Testing
- Negative amounts
- Duplicate emails
- Invalid transaction types
- Invalid transaction statuses
- Insufficient balance
- Invalid foreign key values
- Transfers exceeding the daily limit
- Missing required data

---

## 📋 Test Management

**Jira** was used for:

- Test Case Management
- Test Execution
- Defect Reporting
- Defect Tracking
- Traceability


The project included **119 executed test cases** and **16 tracked defects**.

---

## 📑 Project Deliverables

```text
01-BRD-Requirements-Analysis/
    └── BRD-Requirements-Analysis.pdf

02-Test-Estimation/
    └── Test-Estimation.xlsx

03-Test-Plan/
    └── Test-Plan.pdf

04-Test-Cases/
    ├── Test-cases.pdf
    ├── test -cases.pdf
    ├── Jira (1).csv
    └── Jira (2).csv


05-SQL/
    ├── INSERT-Queries.sql
    ├── UPDATE-Queries.sql
    └── Validation-Queries.sql

06-Defects/
    ├── Bug-Report.pdf
    └── Bug-Reports.pdf




07-Test-Execution/
    └── Test-Execution-Results.xlsx

08-Test-Reports/
    ├── Test-Status-Report.pdf
    └── UAT-Document.pdf

09-UAT/
    └── UAT-Document.pdf

```
---
---

## 👩‍💻 Author

**Dina Ahmed**

Software Testing Engineer | Manual Testing | API Testing | Database Testing | Automation
