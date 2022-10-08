CREATE DATABASE Delivery;

USE Delivery;

CREATE TABLE Partners (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);


CREATE TABLE Positions (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES Partners(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
	
);

CREATE TABLE Clients (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	phone char(12),
	fullname varchar(255)
	
);

CREATE TABLE Orders (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("new","adopted","delivered","completed"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES Clients(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
	
);

CREATE TABLE Positions_Orders (
	position_id int UNSIGNED NOT NULL,
	orders_id int UNSIGNED NOT NULL,
	PRIMARY KEY (position_id,orders_id),
	FOREIGN KEY (position_id) REFERENCES Positions(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (orders_id) REFERENCES Orders(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
	
);

#add partners

INSERT INTO Partners (title,description,address) 
VALUES ("Okadzaki", "Popular chain of sushi bars", "Кунаева, 14Б"),
("Ocean Basket", " You will find people who share our love for delicious seafood, delicate creamy lemon sauce, soft ciabatta buns, those who appreciate our generosity and care when serving seafood.","Mega SilkWay"),
("Darejani"," Darejani is a restaurant inspired by travels to the Caucasus"," Kabanbay batyra, 34");
	

#add positions
#Okadzaki	
INSERT INTO Positions (title,description,price,partner_id)
VALUES ("Burger", "Is a dish usually consisting of a patty of minced meat, usually beef, placed inside a sliced bun.", 3000,(SELECT id FROM Partners WHERE title="Okadzaki")),
("Udon"," Udon is one of the types of wheat flour noodles that are typical for Japanese cuisine, like soba.",2500,(SELECT id FROM Partners WHERE title="Okadzaki")),
("Fettuccine with chicken and mushrooms", "an Italian dish that is usually prepared from thick pasta with the addition of various sauces", 2800,(SELECT id FROM Partners WHERE title="Okadzaki"));

#OceanBasket
INSERT INTO Positions (title,description,price,partner_id)
VALUES ("Shrimp and squid", "two popular seafood used in all sorts of dishes and also as a main ingredient.", 5990,(SELECT id FROM Partners WHERE title="Ocean Basket")),
("Teriyaki Rolls", "Roll with several types of fillings", 2690,(SELECT id FROM Partners WHERE title="Ocean Basket")),
("Salmon platter", "4 california rolls, 6 maki, 6 nigiri, 6 sashimi", 16790,(SELECT id FROM Partners WHERE title="Ocean Basket"));

#Darejani
INSERT INTO Positions (title,description,price,partner_id)
VALUES ("pkhali", "mix of Georgian phali", 2599,(SELECT id FROM Partners WHERE title="Ocean Basket")),
("GREEN PLATE"," fresh herbs, radishes, tomatoes, cucumbers and spicy green chili pepper", 1899,(SELECT id FROM Partners WHERE title="Ocean Basket")),
("CHARKHALI TKEMALSHI"," boiled beetroot, cilantro, garlic and onion,seasoned with homemade tkemali sauce and Georgian spices", 1499,(SELECT id FROM Partners WHERE title="Ocean Basket"));

#add clients
INSERT INTO Clients (phone, fullname) VALUES (87755351045, "Нургалиева Асель");
INSERT INTO Clients (phone, fullname) VALUES (87476568168, "Омирли Гаухар");
INSERT INTO Clients (phone, fullname) VALUES (87021914244, "Нурлыбекова Аида");

#add orders

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-07 20:05:00",
	"Тищенко 3",
	82.734,
	64.416,
	"new",
	1
);

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-06 20:55:00",
	"Республики 63/2",
	111.74,
	88.96,
	"completed",
	1
);


INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-06 21:00:21",
	"Рыскулбекова 16/3, 21кв",
	62.567,
	103.86,
	"delivered",
	2
);

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-17 19:58:19",
	"Мустафина 15",
	62.47,
	93.71,
	"new",
	2
);


INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-17 20:20:20",
	"Мустафина 15",
	62.47,
	93.71,
	"adopted",
	2
);

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-14 22:39:49",
	"Пушкина 11/1",
	175.14,
	78.145,
	"completed",
	3
);


#add positions_orders
INSERT INTO Positions_Orders (orders_id, position_id) SELECT 1, id FROM Positions WHERE title="Shrimp and squid";
INSERT INTO Positions_Orders  (orders_id, position_id) SELECT 1, id FROM Positions WHERE title="pkhali";

INSERT INTO Positions_Orders  (orders_id, position_id) SELECT 2, id FROM Positions WHERE title="GREEN PLATE";

INSERT INTO Positions_Orders (orders_id, position_id) SELECT 3, id FROM Positions WHERE title="CHARKHALI TKEMALSHI”";
INSERT INTO Positions_Orders (orders_id, position_id) SELECT 3, id FROM Positions WHERE title="Fettuccine with chicken and mushrooms";
INSERT INTO Positions_Orders (orders_id, position_id) SELECT 3, id FROM Positions WHERE title="Udon";


INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="new" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Udon")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="delivered" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Teriyaki Rolls")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="adopted" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Burger")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="new" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="pkhali")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="completed" AND client_id=3), 
	(SELECT id FROM Positions WHERE title="Fettuccine with chicken and mushrooms")
);

# 2

SELECT Orders.id, Clients.phone, Partners.title FROM Orders 
JOIN Clients ON Orders.client_id = Clients.id 
JOIN Positions_Orders ON Orders.id = Positions_Orders.orders_id  
JOIN Positions ON Positions_Orders.position_id = Positions.id 
JOIN Partners ON Positions.partner_id = Partners.id;

# 3
INSERT INTO Partners (title, address) VALUES ("Hardees", "Mega SilkWay");

INSERT INTO Positions (title, price, partner_id) VALUES ("Куриные крылышки", 3500, 
	(SELECT id FROM Partners artners WHERE title="Hardees")
);

SELECT * FROM Partners WHERE id NOT IN (
	SELECT partner_id FROM Positions_Orders JOIN Positions ON Positions.id = Positions_Orders.position_id 
);

# 4
SELECT Positions.title 
FROM Orders, Positions_Orders, Positions 
WHERE Orders.client_id = 1 AND Orders.id = 1 AND Positions_Orders.orders_id  = Orders.id AND Positions_Orders.position_id = Positions.id;


















