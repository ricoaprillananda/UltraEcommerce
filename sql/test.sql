-- ============================================
-- UltraEcommerce • End-to-End Test
-- ============================================

SET SERVEROUTPUT ON;

-- 1) Show initial states
SELECT * FROM Orders;
SELECT * FROM Payments;

-- 2) Validate payment for order 1001
DECLARE
  v_result VARCHAR2(50);
BEGIN
  v_result := pkg_ecommerce.Validate_Payment(1001, 150);
  DBMS_OUTPUT.PUT_LINE('Payment validation result for order 1001: ' || v_result);
END;
/

-- 3) Verify order status updated via trigger
SELECT * FROM Orders WHERE order_id = 1001;

-- 4) Generate shipment for order 1001
BEGIN
  pkg_ecommerce.Generate_Shipment(1001);
  DBMS_OUTPUT.PUT_LINE('Shipment generated for order 1001');
END;
/

-- 5) Show shipment
SELECT * FROM Shipments WHERE order_id = 1001;

-- 6) Attempt invalid payment
DECLARE
  v_result VARCHAR2(50);
BEGIN
  v_result := pkg_ecommerce.Validate_Payment(9999, 200);
  DBMS_OUTPUT.PUT_LINE('Invalid payment test: ' || v_result);
END;
/
