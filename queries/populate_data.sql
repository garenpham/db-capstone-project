INSERT INTO menuitems (CourseName,StarterName,DessertName,DrinkName) 
VALUES 
('Greek salad','Olives','Greek yogurt','Athens White wine'),
('Bean soup','Flat bread','Ice cream','Corfu Red Wine'),
('Pizza','Minestrone','Cheesecake','Italian Coffee'),
('Carbonara','Tomato bread','Affogato','Roma Red wine');

INSERT INTO menus (MenuItemsID,Cuisine,MenuName)
VALUES
(1,'Greek','Ganja'),
(2,'Italian','Ganja2'),
(3,'Italian','Ganja3'),
(4,'Turkish','Ganja4');

INSERT INTO customers (FullName,ContactDetail)
VALUES
('Laney Fadden','993-0031'),
('Giacopo Bramich','216282'),
('Lia Bonar','663246'),
('Merrill Baudon','987-0352');

INSERT INTO orders (MenuID,CustomerID,OrderDate,Quanity,TotalCost)
VALUES
(1,1,'2020-06-15',2,187.500),
(2,2,'2020-08-25',1,352.500),
(3,3,'2021-08-17',3,112.500),
(4,4,'2021-08-14',3,330.000);

INSERT INTO bookings (BookingID,BookingDate,TableNumber,CustomerID)
VALUES
(1,'2022-10-10',5,1),
(2,'2022-11-12',3,3),
(3,'2022-10-11',2,2),
(4,'2022-10-13',2,1);