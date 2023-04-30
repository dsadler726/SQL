/*
  In this file, I'm querying a database with several tables to quantify statistics about customer and order data. 
*/

-- Total orders placed in January
Select COUNT(orderID)
FROM DB.JanSales
WHERE length(orderid) = 6 
AND orderid <> 'Order ID';


-- Total Iphone orders in the month of January
SELECT COUNT(orderID)
FROM DB.JanSales
WHERE Product = 'iPhone'
AND length(orderid) = 6 
AND orderid <> 'Order ID';


-- Customer Account Numbers for all orders placed in February
SELECT distinct acctnum
FROM DB.customers custom
INNER JOIN DB.FebSales feb_orders
ON custom.order_id = feb_orders.orderID
WHERE length(orderid) = 6 AND orderid <> 'Order ID';


-- Cheapest product and it's price sold in January
SELECT distinct Product, price
FROM DB.JanSales
WHERE price IN (SELECT MIN(price) FROM DB.JanSales);


-- Total Revenue for each product in January
SELECT Product, SUM(quantity) AS count, ROUND(SUM(Quantity) * price) AS revenue
FROM DB.JanSales
WHERE Product <> 'Product' AND Product <> ''
GROUP BY Product;


-- Products sold in February at 548 Lincoln St, Seattle, WA 98101, total of each sold, and the total revenue
SELECT Product, SUM(quantity) AS count, SUM(Quantity) * price AS revenue
FROM DB.FebSales
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY Product;


-- Total customers who ordered more than 2 products at a time in Feb, and the average amount spent for those customers
SELECT COUNT(distinct acctnum), AVG(feb.quantity * price) AS average
FROM DB.customers custom
LEFT JOIN DB.FebSales feb
ON custom.order_id = feb.orderID
WHERE feb.quantity > 2 AND length(orderID) = 6 AND orderid <> 'Order ID';


-- Listing all the products sold in Los Angeles in February, includes how many of each were sold. 
SELECT product, SUM(Feb.quantity) AS total_sold
FROM DB.FebSales Feb
WHERE location LIKE '%Los Angeles%'
GROUP BY Feb.Product;


-- Locations in New York that recieved at least 3 orders in January, total for each customer
SELECT distinct location, COUNT(orderID) AS total_orders
FROM DB.JanSales
WHERE location LIKE '%NY%' AND length(orderID) = 6 AND orderid <> 'Order ID'
GROUP BY location
HAVING count(orderID)>2;


-- Total of each headphone type sold in February
SELECT Product, SUM(quantity) AS total_sold
FROM DB.FebSales
WHERE Product Like '%Headphone%' AND length(orderID) = 6 AND orderid <> 'Order ID'
GROUP BY Product;


-- Average amount spent per account in February
SELECT sum(quantity*price) / COUNT(custom.acctnum) AS average
FROM DB.FebSales feb
LEFT JOIN DB.customers custom
ON feb.orderID = custom.order_id
WHERE length(orderid) = 6 
AND orderid <> 'Order ID';


-- Average Quantity of products purchased per account in February
SELECT AVG(quantity) AS average_quantity
FROM DB.FebSales feb
LEFT JOIN DB.customers custom
ON feb.orderID = custom.order_id
WHERE length(orderid) = 6 AND orderid <> 'Order ID';


-- Product that brought in the most revenue in January and how much revenue it brought in total
SELECT Product, SUM(quantity * price) AS revenue
FROM DB.JanSales jan
WHERE length(orderid) = 6 AND orderid <> 'Order ID'
GROUP BY Product
ORDER BY revenue DESC
LIMIT 1;


