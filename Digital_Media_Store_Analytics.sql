/*
  This file provides analytics for a database that represents a digital media store and includes tables for 
  artists, albums, media tracks, invoices, and customers, along with employee information.
*/


-- Show Customers who are not in the US.
SELECT (FirstName || ' ' || LastName) AS full_name,  Customerid AS customer_id,  Country
FROM customers
WHERE Country <> 'US';


-- Show only the Customers from Brazil.
SELECT (FirstName || ' ' || LastName) AS full_name
FROM customers
WHERE Country = 'Brazil';


-- Finds the Invoices of customers who are from Brazil.
SELECT (FirstName || ' ' || LastName) AS full_name,  invoiceid AS invoice_id,  invoiceDate AS date,  BillingCountry AS billing_country
FROM invoices i
JOIN customers c ON i.CustomerId = c.Customerid
WHERE Country = 'Brazil'
ORDER BY date;     

    
-- Shows Employees who are Sales Agents.
SELECT (FirstName || ' ' || LastName) AS Sales_Agents
FROM employees
WHERE Title = 'Sales Support Agent';


-- List of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry 
FROM Invoices ;


-- Shows the invoices associated with each sales agent.
SELECT (emp.FirstName || ' ' || emp.LastName) AS Sales_Agents, invoiceid AS invoice_id, BillingCountry AS  billing_country
FROM employees emp
JOIN customers custom ON emp.Employeeid = custom.SupportRepid
JOIN invoices invoice ON custom.Customerid = invoice.Customerid;


-- Shows the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers.
SELECT Total, (custom.FirstName || ' ' || custom.LastName) AS Customer, custom.Country, (emp.FirstName || ' ' || emp.LastName) AS Sales_Agent
FROM customers custom
JOIN invoices invoice ON invoice.Customerid = custom.Customerid
JOIN employees emp ON emp.Employeeid = custom.SupportRepid;


-- Invoices from 2009
SELECT COUNT(*) AS Total_Invoices_2009
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31';


-- Total sales for 2009?
SELECT SUM(Total)
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31';


-- Purchased track names with each invoice line ID.
SELECT track.name, invoice.InvoiceLineid
FROM tracks track
JOIN invoice_items invoice ON track.trackid = invoice.TrackId;


-- Includes the purchased track name and artist name with each invoice line ID.
SELECT ar.Name AS Artist, t.Name AS Track, i.invoiceLineid AS invoice
FROM tracks t
JOIN invoice_items i ON t.Trackid = i.Trackid 
JOIN albums a ON t.Albumid = a.Albumid
JOIN artists ar ON ar.Artistid = a.Artistid; 


-- Shows all the Tracks
SELECT t.Name AS Track_Name, a.Title AS Album_Name, m.Name AS Media_Type, g.Name AS Genre
FROM tracks t
JOIN albums a ON a.Albumid = t.Albumid
JOIN media_types m ON m.mediaTypeid = t.MediaTypeid
JOIN genres g  ON g.Genreid = t.Genreid;


-- Shows total sales made by each sales agent.
SELECT (e.FirstName || ' ' || e.LastName) AS Sales_Agents, ROUND(SUM(i.Total), 2) AS Total_Sales
FROM employees e
JOIN customers c ON c.SupportRepid = e.Employeeid
JOIN invoices i ON i.Customerid = c.Customerid
WHERE e.Title = 'Sales Support Agent' 
GROUP BY Sales_Agents;


-- Top performing sales agent in 2009?
SELECT (e.FirstName || ' ' || e.LastName) AS Top_Agent, ROUND(SUM(i.Total), 2) AS Total_Sales
FROM employees e
JOIN customers c ON c.SupportRepid = e.Employeeid
JOIN invoices i ON i.Customerid = c.Customerid
WHERE e.Title = 'Sales Support Agent' AND i.InvoiceDate LIKE '2009%'
GROUP BY Top_Agent
ORDER BY Total_Sales DESC LIMIT 1;


--Top 3 Genres
SELECT g.Name, COUNT(i.invoiceid) AS Total_Sales
FROM genres g
JOIN tracks t ON t.Genreid = g.Genreid
JOIN invoice_items ii ON t.Trackid = ii.Trackid
JOIN invoices i ON ii.invoiceid = i.invoiceid
GROUP BY g.Name
ORDER BY Total_Sales DESC LIMIT 3;


-- Top 10 Tracks Purchesed
SELECT t.Name AS Track, ar.Name AS Artist, Count(*) AS Total_Sales
FROM tracks t
JOIN albums a ON a.albumid = t.albumid
JOIN artists ar ON ar.artistid = a.artistid
JOIN invoice_items ii ON ii.trackid = t.trackid
JOIN invoices i ON i.invoiceid = ii.invoiceid
GROUP BY t.name
HAVING t.name <> 'Untitled'
ORDER BY Total_Sales DESC LIMIT 10;
