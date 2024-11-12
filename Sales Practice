-- Inspecting data
/*
SELECT * from sales_data.sales_data_sample


-- Checking unique values
SELECT DISTINCT status from sales_data.sales_data_sample
SELECT DISTINCT YEAR_ID from sales_data.sales_data_sample
SELECT DISTINCT  PRODUCTLINE from sales_data.sales_data_sample
SELECT DISTINCT COUNTRY from sales_data.sales_data_sample
SELECT DISTINCT DEALSIZE from sales_data.sales_data_sample
SELECT DISTINCT TERRITORY from sales_data.sales_data_sample

SELECT DISTINCT MONTH_ID from sales_data.sales_data_sample
where YEAR_ID = 2005


-- Analysis
select PRODUCTLINE, sum(SALES) Revenue
from sales_data.sales_data_sample
group by PRODUCTLINE
order by 2 desc


select YEAR_ID, sum(SALES) Revenue
from sales_data.sales_data_sample
group by YEAR_ID
order by 2 desc


select DEALSIZE, sum(SALES) Revenue
from sales_data.sales_data_sample
group by DEALSIZE
order by 2 desc


-- Best sales month/how much was earned
select MONTH_ID, sum(SALES) Revenue, count(xORDERNUMBER) Frequency
from sales_data.sales_data_sample
where Year_ID = 2003
group by MONTH_ID
order by 2 desc


-- November is best month. what products sell best.
select MONTH_ID, PRODUCTLINE, sum(SALES) Revenue, count(xORDERNUMBER) OrderCount
from sales_data.sales_data_sample
where YEAR_ID = 2004 and MONTH_ID = 11
group by MONTH_ID, PRODUCTLINE
order by 3 desc


-- Who is the best customer
SET SQL_SAFE_UPDATES = 0;
UPDATE sales_data.sales_data_sample
SET ORDERDATE = STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i');
SET SQL_SAFE_UPDATES = 1;


DROP TEMPORARY TABLE IF EXISTS rfm_temp;
CREATE TEMPORARY TABLE rfm_temp AS
(
    SELECT 
        CUSTOMERNAME,
        SUM(SALES) AS MonetaryValue,
        AVG(SALES) AS avgMonetaryValue, 
        COUNT(xORDERNUMBER) AS Frequency,
        MAX(ORDERDATE) AS last_order_date,
        (SELECT MAX(ORDERDATE) FROM sales_data.sales_data_sample) AS max_order_date,
        DATEDIFF(
            (SELECT MAX(ORDERDATE) FROM sales_data.sales_data_sample),
            MAX(ORDERDATE)
        ) AS Recency
    FROM sales_data.sales_data_sample
    GROUP BY CUSTOMERNAME
);
DROP TEMPORARY TABLE IF EXISTS rfm_table;
CREATE TEMPORARY TABLE rfm_table AS
(
    SELECT rfm_temp.*, 
        NTILE(4) OVER (ORDER BY Recency DESC) AS rfm_recency,
        NTILE(4) OVER (ORDER BY Frequency) AS rfm_frequency,  
        NTILE(4) OVER (ORDER BY MonetaryValue) AS rfm_monetary,
        (NTILE(4) OVER (ORDER BY Recency DESC) + NTILE(4) OVER (ORDER BY Frequency) + NTILE(4) OVER (ORDER BY avgMonetaryValue)) AS rfm_cell,
        CONCAT(CAST(NTILE(4) OVER (ORDER BY Recency DESC) AS CHAR), 
               CAST(NTILE(4) OVER (ORDER BY Frequency) AS CHAR), 
               CAST(NTILE(4) OVER (ORDER BY avgMonetaryValue) AS CHAR)) AS rfm_cell_string
    FROM rfm_temp
);
select CUSTOMERNAME , rfm_recency, rfm_frequency, rfm_monetary,
	case 
		when rfm_cell_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) then 'lost_customers'  -- lost customers
		when rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'slipping away, cannot lose' -- (Big spenders who haven’t purchased lately) slipping away
		when rfm_cell_string in (311, 411, 331) then 'new customers'
		when rfm_cell_string in (222, 223, 233, 322) then 'potential churners'
		when rfm_cell_string in (323, 333,321, 422, 332, 432) then 'active' -- jj(Customers who buy often & recently, but at low price points)
		when rfm_cell_string in (433, 434, 443, 444) then 'loyal'
	end as rfm_segment

FROM rfm_table
*/

-- What products are most often sold together

SELECT DISTINCT s.xORDERNUMBER, 
    GROUP_CONCAT(p.PRODUCTCODE ORDER BY p.PRODUCTCODE SEPARATOR ',') AS ProductCodes
FROM sales_data.sales_data_sample s

JOIN sales_data.sales_data_sample p ON p.xORDERNUMBER = s.xORDERNUMBER
	WHERE s.xORDERNUMBER IN 
		(
			SELECT xORDERNUMBER
			FROM (
				SELECT xORDERNUMBER, COUNT(*) AS rn
				FROM sales_data.sales_data_sample
				WHERE STATUS = 'Shipped'
				GROUP BY xORDERNUMBER
			) m
			WHERE rn = 2
		)
GROUP BY s.xORDERNUMBER;
