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

DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE status VARCHAR(255);
    SELECT COUNT(*) INTO status
    FROM littlelemondb.bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;
    IF status > 0 THEN
        SELECT CONCAT('Table ', table_number, ' is already booked') AS Result;
    ELSE
        SELECT CONCAT('Table ', table_number, ' is available on ', booking_date) AS Result;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE status INT;
    START TRANSACTION;
    SELECT COUNT(*) INTO status
    FROM littlelemondb.bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;
    IF status > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled') AS Result;
    ELSE
        INSERT INTO littlelemondb.bookings (BookingDate, TableNumber)
        VALUES (booking_date, table_number);
        COMMIT;
        SELECT CONCAT('Table ', table_number, ' has been successfully booked on ', booking_date) AS Result;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN table_number INT, IN booking_date DATE)
BEGIN
    INSERT INTO littlelemondb.bookings (BookingID, CustomerID, TableNumber, BookingDate)
    VALUES (booking_id, customer_id, table_number, booking_date);
    SELECT CONCAT('New booking added') AS Result;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
    UPDATE littlelemondb.bookings
    SET BookingDate = booking_date
    WHERE BookingID = booking_id;
    SELECT CONCAT('Booking ', booking_id, ' updated') AS Result;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    DELETE FROM littlelemondb.bookings
    WHERE BookingID = booking_id;
    SELECT CONCAT('Booking ', booking_id, ' cancelled') AS Result;
END //
DELIMITER ;