# Implement a Python function: If b > a, print 'Busier Than Usual'; If b < a, print 'Less Busy than Usual'; If b = a, print 'As Busy as it Gets'

from cs50 import SQL

db = SQL("sqlite:///breadcrumbs.db")

date = input("Date: ") # "22/04/2024"
day = input("Day: ") # "Monday"
hour = input("Hour: ") + '%' # "10"
place = input("Place: ") # "The Cozy Corner Cafe"


# a. Find average by day and hour
a = db.execute(
    """
    SELECT "average serves" FROM "traffic"
    WHERE "user_id" = (
        SELECT "id" FROM "users"
        WHERE "name" = ?
    )
    AND "hour" LIKE ?
    AND "day" = ?;
    """,
    place, hour, day
)


# b. Find last hour's transactions
b = db.execute(
    """
    SELECT COUNT("transaction_id") FROM "transactions"
    WHERE "date" = ?
    AND "user_id" = (
        SELECT "id" FROM "users"
        WHERE "name" = ?
    )
    AND "time" LIKE ?;
    """,
    date, place, hour
    )


# Convert outputs to int
a = int(a[0]["average serves"])
b = int(b[0]['COUNT("transaction_id")'])


# Print results
if b > a:
    print("Busier Than Usual")
elif b < a:
    print("Less Busy than Usual")
else:
    print("As Busy as it Gets")
