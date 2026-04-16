-------------------------------------------
-- Revenue Concentration - Pareto Analysis
-------------------------------------------

With CustomerSpendRanked As
	(select 
		customerID,
		sum(quantity*Unitprice) as totalspend,
		ntile(5) over (order by sum(quantity*Unitprice) desc) as groupnumber
	from ecommerce_customers
	group by customerID
	),
    
overalltotalspend As
	(
		select sum(unitprice*quantity) as FullSpend
		from ecommerce_customers
	)
    
select 
	sum(totalspend) as GroupSpend,
    count(*) as NumberOfCustomers,
    groupnumber,
    round((sum(totalspend)*100/o.FullSpend),2) as revenuepercentage
from CustomerSpendRanked
cross join overalltotalspend o
group by groupnumber, o.fullspend
order by groupnumber;

----------------------------
-- Revenue Leakage Analysis
----------------------------

-- Total Returns
select ABS(sum(Quantity*UnitPrice)) TotalReturns
from ecommerce_raw
where Quantity<0;

-- Percentage of revenue lost
SELECT 
   round(abs(sum(CASE WHEN Quantity < 0 then Quantity * UnitPrice else 0 end) )
    / SUM(CASE WHEN Quantity > 0 THEN Quantity * UnitPrice ELSE 0 END) * 100, 2)
FROM ecommerce_raw;
