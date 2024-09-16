-- Data
INSERT INTO "users" ("id", "name", "username", "password")
VALUES
(1, 'The Cozy Corner Cafe', 'cozycorner99', '1ec38292dd0df5f59dc242269f06b068'),
(2, 'Little Italy Ristorante', 'little_italy', '5ca9f7254bea7618362e3c3f37311da7'),
(3, 'The Sports Bar', 'sportsbar88', 'da244d4efa4b43c46602340a861c7308'),
(4, 'Bean Scene Coffee Shop', 'beanscene', '9e796c5c0ef742384f01f67314ee634a'),
(5, 'The Tipsy Penguin Pub', 'tipsypenguin', 'e58a874e21b5e0f09c47911b8ae0e17f'),
(6, 'The French Quarter', 'frenchquarter', '425628672517242459aa5aede0bbf829')
;

INSERT INTO "categories" ("id", "category")
VALUES
("1", "Restaurant"),
("2", "Cafe"),
("3", "Bar")
;

INSERT INTO "type" ("user_id", "category_id")
VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 2),
(5, 3),
(6, 1)
;

INSERT INTO "locations" ("user_id", "door_no", "address_line", "level", "postcode", "lat", "long")
VALUES
(1, '23', "Brick Lane", "Ground Floor", "E1 6PU", "51.518322", "-0.083139"),
(2, '42', "Piccadilly St", "1st Floor","W1J 9HX", "51.509865", "-0.132381"),
(3, '11', "Greenwich Rd", "Basement", "SE10 8BF", "51.477778", "0.000235"),
(4, '7B', "Canary Wharf Rd", "Unit 7", "E14 5LH", "51.503328", "0.020253"),
(5, '10', "Camden High St", "Shop Front", "NW1 7JE", "51.534768", "-0.127758"),
(6, '32', "Soho Square", "2nd Floor", "W1F 9UB", "51.512240", "-0.127677")
;

.import --csv --skip 1 sample_transactions.csv transactions


INSERT INTO "info" ("user_id", "contact_no", "email")
VALUES
('1', '+44-123-4567-890', 'cozycorner99@cafe.com'),
('2', '+44-123-4567-890', 'little_italy@restaurant.com'),
('3', '+44-123-4567-890', 'sportsbar88@bar.com'),
('4', '+44-123-4567-890', 'beanscene@cafe.com'),
('5', '+44-123-4567-890', 'tipsypenguin@bar.com'),
('6', '+44-123-4567-890', 'frenchquarter@restaurant.com')
;

-- User queries

-- a. Find average by day and hour

SELECT "average serves" FROM "traffic"
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "name" = 'The Cozy Corner Cafe'
)
AND "hour" = '10'
AND "day" = 'Monday';

-- b. Find last hour's transactions

SELECT COUNT("transaction_id") FROM "transactions"
WHERE "date" = '22/04/2024'
AND "user_id" = '1'
AND "time" LIKE '10%';
