-------------------
-- Data Cleaning
-------------------

-- converting empty strings (customer IDs) to nulls
Update ecommerce_raw
set customerID = NULL
where customerID = '';

-- converting empty strings (Description) to nulls
Update ecommerce_raw
set description = NULL
where trim(description) = '';

-- Creating a cleaned dataset containing only valid revenue generating transactions
Create view ecommerce_clean 
As
	Select * from ecommerce_raw
	where quantity > 0 
	and UnitPrice > 0
	and invoiceNo not like 'C%'
	and description not like '%adjust%';

-- creating a further cleaned dataset with only identified customers
create view ecommerce_customers 
AS
	select * from ecommerce_clean
	where customerid is not null;
    

