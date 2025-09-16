-- ============================================
-- UltraEcommerce • Schema Definition
-- ============================================

-- Drop in dependency order for clean re-runs
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Shipments PURGE';    EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Payments PURGE';     EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Orders PURGE';       EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Customers PURGE';    EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

-- Customers: registered buyers
CREATE TABLE Customers (
  customer_id   NUMBER         PRIMARY KEY,
  full_name     VARCHAR2(120)  NOT NULL,
  email         VARCHAR2(160)  UNIQUE,
  joined_at     DATE           DEFAULT SYSDATE
);

-- Orders: master table
CREATE TABLE Orders (
  order_id      NUMBER         PRIMARY KEY,
  customer_id   NUMBER         NOT NULL REFERENCES Customers(customer_id),
  order_date    DATE           DEFAULT SYSDATE,
  status        VARCHAR2(20)   DEFAULT 'PENDING' CHECK (status IN ('PENDING','PAID','SHIPPED'))
);

-- Payments: records linked to orders
CREATE TABLE Payments (
  payment_id    NUMBER         PRIMARY KEY,
  order_id      NUMBER         NOT NULL REFERENCES Orders(order_id),
  amount        NUMBER(12,2)   NOT NULL CHECK (amount > 0),
  payment_date  DATE           DEFAULT SYSDATE,
  status        VARCHAR2(20)   DEFAULT 'INITIATED' CHECK (status IN ('INITIATED','SUCCESS','FAILED'))
);

-- Shipments: delivery details
CREATE TABLE Shipments (
  shipment_id   NUMBER         PRIMARY KEY,
  order_id      NUMBER         NOT NULL REFERENCES Orders(order_id),
  tracking_no   VARCHAR2(50),
  shipped_date  DATE,
  status        VARCHAR2(20)   DEFAULT 'PENDING' CHECK (status IN ('PENDING','IN_TRANSIT','DELIVERED'))
);
