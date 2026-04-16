------------------------------
-- Exploratory Data Analysis
------------------------------


-- number of customers, products, invoices, countries, 
select count(*), count(distinct(customerID)) noofcustomers, count(distinct(stockcode)) noofproducts, count(distinct(invoiceNo))noofinvoices, count(distinct(Country)) noofcountries 
from ecommerce_raw;

-- finding rows where customerID is null
select count(*) 
from ecommerce_raw 
where customerID is null;

-- finding customer IDs stored as empty strings
select count(*) from ecommerce_raw 
where customerID = '';

-- finding other null values
select count(*) from ecommerce_raw
where Invoiceno is null or trim(InvoiceNo) = '';

-- finding empty descriptions
select count(*) from ecommerce_raw
where trim(Description) = '';

-- number of transactions with negative quantities
select count(*) from ecommerce_raw
where Quantity < 0;

-- finding number of cancellations (invoices beginning with C)
select count(*) 
from ecommerce_raw
where invoiceno like 'C%';

-- classify return transactions into full cancellations vs partial refunds
select 
	case
		when invoiceno like 'C%' then 'Full Cancellation'
        else 'Partial Refund' 
	end as Cancellation_Type, 
    count(*)
from ecommerce_raw
where quantity < 0
group by Cancellation_Type;

-- Identify records with negative unit price 
select COUNT(*) 
from ecommerce_raw
where UnitPrice < 0;

-- understanding records with negative unit price
select distinct description 
from ecommerce_raw
where unitprice < 0;

-- finding adjustment transactions
select count(*)	 from ecommerce_raw
where Description like '%adjust%';

-- finding number of purchases and returns 
select 
	count(case when quantity > 0 then 1 end) as purchases,
	count(case when quantity < 0 then 1 end) as returns
from ecommerce_raw;




    








