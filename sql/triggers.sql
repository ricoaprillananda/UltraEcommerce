-- ============================================
-- UltraEcommerce • Triggers
-- ============================================

-- Drop if present
BEGIN EXECUTE IMMEDIATE 'DROP TRIGGER trg_payment_success'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -4080 THEN RAISE; END IF; END;
/

-- After payment success, update order status to PAID
CREATE OR REPLACE TRIGGER trg_payment_success
AFTER UPDATE OF status ON Payments
FOR EACH ROW
WHEN (NEW.status = 'SUCCESS')
BEGIN
  UPDATE Orders
     SET status = 'PAID'
   WHERE order_id = :NEW.order_id;
END;
/
SHOW ERRORS;
