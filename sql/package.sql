-- ============================================
-- UltraEcommerce • Package: Payment + Shipment
-- ============================================

-- Drop if present
BEGIN EXECUTE IMMEDIATE 'DROP PACKAGE pkg_ecommerce'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -4043 THEN RAISE; END IF; END;
/

-- Package specification
CREATE OR REPLACE PACKAGE pkg_ecommerce AS
  FUNCTION Validate_Payment(p_order_id IN NUMBER, p_amount IN NUMBER) RETURN VARCHAR2;
  PROCEDURE Generate_Shipment(p_order_id IN NUMBER);
END pkg_ecommerce;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY pkg_ecommerce AS

  -- Function to validate payment against order total (simple demo: check amount > 0)
  FUNCTION Validate_Payment(p_order_id IN NUMBER, p_amount IN NUMBER) RETURN VARCHAR2 IS
    v_exists NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_exists FROM Orders WHERE order_id = p_order_id;
    IF v_exists = 0 THEN
      RETURN 'FAILED: Order not found';
    END IF;

    IF p_amount <= 0 THEN
      RETURN 'FAILED: Invalid amount';
    END IF;

    -- Mark payment as success
    UPDATE Payments
       SET status = 'SUCCESS', payment_date = SYSDATE
     WHERE order_id = p_order_id AND amount = p_amount;

    RETURN 'SUCCESS';
  END Validate_Payment;

  -- Procedure to generate shipment tracking and update status
  PROCEDURE Generate_Shipment(p_order_id IN NUMBER) IS
    v_count NUMBER;
    v_ship_id NUMBER;
  BEGIN
    -- Ensure order exists and is paid
    SELECT COUNT(*) INTO v_count FROM Orders WHERE order_id = p_order_id AND status = 'PAID';
    IF v_count = 0 THEN
      RAISE_APPLICATION_ERROR(-20100, 'Order not found or not paid');
    END IF;

    v_ship_id := NVL((SELECT MAX(shipment_id) FROM Shipments),0)+1;
    INSERT INTO Shipments (shipment_id, order_id, tracking_no, shipped_date, status)
    VALUES (v_ship_id, p_order_id, 'TRK-' || TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS'), SYSDATE, 'IN_TRANSIT');

    -- Update order status
    UPDATE Orders SET status = 'SHIPPED' WHERE order_id = p_order_id;

    COMMIT;
  END Generate_Shipment;

END pkg_ecommerce;
/
SHOW ERRORS;
