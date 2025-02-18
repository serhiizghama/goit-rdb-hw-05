
-- p1.png
SELECT *,(SELECT customer_id FROM orders WHERE orders.id = order_id) as customer_id FROM order_details

-- p2.png
SELECT * FROM order_details WHERE order_id IN  (SELECT id from orders WHERE shipper_id = 3)

-- p3.png
SELECT order_id, AVG(quantity) FROM ( SELECT * FROM order_details WHERE quantity > 10) AS tmp GROUP BY order_id

-- p4.png
WITH temp AS (
SELECT * 
FROM order_details 
WHERE quantity > 10
)
SELECT order_id, AVG(quantity) as avg_quantity
FROM temp
GROUP BY order_id

-- p5.png
DROP FUNCTION IF EXISTS FuncCalculateResult;
DELIMITER //
CREATE FUNCTION FuncCalculateResult(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC 
BEGIN
    DECLARE result FLOAT;    
      IF b = 0 THEN 
          RETURN NULL;
      END IF;        
    SET result = a / b;
    RETURN result;
END //
DELIMITER ;

SELECT order_id, quantity, FuncCalculateResult(quantity, 2) as calc_quantity from order_details

-----------------------------
-- thanks for your attention
-----------------------------