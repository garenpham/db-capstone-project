CREATE VIEW OrdersView AS
SELECT OrderID, Quanity AS Quantity, TotalCost AS Cost
FROM littlelemondb.orders
WHERE Quanity > 2;

SELECT c.CustomerID, c.FullName, o.OrderID, o.TotalCost, m.MenuName, mi.CourseName, mi.StarterName
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN menus m ON o.MenuID = m.MenuID
JOIN menuitems mi ON m.MenuItemsID = mi.MenuItemsID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC;

SELECT m.MenuName
FROM menus m
WHERE m.MenuID = ANY (
    SELECT o.MenuID
    FROM orders o
    WHERE o.Quanity > 2
);

DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quanity) AS max_quantity
    FROM orders;
END //
DELIMITER ;

PREPARE GetOrderDetail FROM
    'SELECT OrderID, Quanity, TotalCost
    FROM orders
    WHERE CustomerID = ?';

DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM orders
    WHERE OrderID = order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS confirmation;
END //
DELIMITER ;