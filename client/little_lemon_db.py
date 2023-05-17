# Import MySQL Connector/Python
import mysql.connector as connector

connection = connector.connect(
    user="phamminhtan", password="password", db="littlelemondb"
)

cursor = connection.cursor()

show_tables_query = "SHOW tables"
cursor.execute(show_tables_query)

results = result = cursor.fetchall()
print(results)

# Query with table JOIN
query = """
SELECT customers.FullName, customers.ContactDetail, orders.TotalCost
FROM customers
JOIN orders ON customers.CustomerID = orders.CustomerID
WHERE orders.TotalCost > 60;
"""

cursor.execute(query)
results = cursor.fetchall()
for row in results:
    print(row)

connection.close()
