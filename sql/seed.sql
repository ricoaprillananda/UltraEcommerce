-- ============================================
-- UltraEcommerce • Sample Data
-- ============================================

-- Customers
INSERT INTO Customers (customer_id, full_name, email) VALUES (1, 'Alice Johnson', 'alice@example.com');
INSERT INTO Customers (customer_id, full_name, email) VALUES (2, 'Brian Lee', 'brian@example.com');

-- Orders
INSERT INTO Orders (order_id, customer_id) VALUES (1001, 1);
INSERT INTO Orders (order_id, customer_id) VALUES (1002, 2);

-- Payments
INSERT INTO Payments (payment_id, order_id, amount) VALUES (5001, 1001, 150);
INSERT INTO Payments (payment_id, order_id, amount) VALUES (5002, 1002, 300);

COMMIT;
