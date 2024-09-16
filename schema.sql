-- Tables
CREATE TABLE users (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE categories (
    "id" INTEGER,
    "category" TEXT NOT NULL CHECK("category" IN ('Restaurant', 'Cafe', 'Bar')),
    PRIMARY KEY("id")
);

CREATE TABLE type (
    "user_id" INTEGER,
    "category_id" INTEGER,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id"),
    FOREIGN KEY ("category_id") REFERENCES "categories" ("id")
);

CREATE TABLE locations (
    "user_id" INTEGER,
    "door_no" TEXT,
    "address_line" TEXT,
    "level" TEXT,
    "postcode" TEXT,
    "lat" REAL NOT NULL,
    "long" REAL NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

CREATE TABLE transactions (
    "user_id" INTEGER,
    "transaction_id" INTEGER,
    "day" TEXT,
    "date" DATE,
    "time" TIME,
    PRIMARY KEY ("transaction_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

CREATE TABLE info (
    "user_id" INTEGER,
    "contact_no" TEXT,
    "email" TEXT,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);


-- Views
    -- Profiles view
CREATE VIEW profiles AS
SELECT "name", "category", "door_no", "address_line", "level", "postcode", "contact_no", "email" FROM "users"
JOIN "type" ON "type"."user_id" = "users"."id"
JOIN "categories" ON "type"."category_id" = "categories"."id"
JOIN "locations" ON "locations"."user_id" = "users"."id"
JOIN "info" ON "info"."user_id" = "users"."id";

    -- Average Serves by Days and Hours
CREATE VIEW traffic AS
SELECT "user_id", "day", STRFTIME('%H',"time") AS "hour", COUNT("transaction_id") / COUNT(DISTINCT("date")) AS "average serves" FROM "transactions"
GROUP BY "user_id", "day", STRFTIME('%H',"time")
ORDER BY "user_id",
    CASE
        WHEN Day = 'Monday' THEN 1
        WHEN Day = 'Tuesday' THEN 2
        WHEN Day = 'Wednesday' THEN 3
        WHEN Day = 'Thursday' THEN 4
        WHEN Day = 'Friday' THEN 5
        WHEN Day = 'Saturday' THEN 6
        WHEN Day = 'Sunday' THEN 7
    END ASC;

-- Indeces
CREATE INDEX "user_names" ON "users" ("name");
CREATE INDEX "transaction_days" ON "transactions" ("day");
CREATE INDEX "transaction_dates" ON "transactions" ("date");
