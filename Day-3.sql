
/* 
  Write a sql query the footer values from inout table, meaning all the last non-null values from each field as shown in expected output?
Stored Procedures  
*/

use sql_challenge;

DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;

-- 1st way

select * 
from (select car from footer where car is not null order by id desc limit 1) as car
cross join (select length from footer where length is not null order by id desc limit 1) as length
cross join (select width from footer where width is not null order by id desc limit 1) as width
cross join (select height from footer where height is not null order by id desc limit 1) as height;


-- 2nd way

with cte as
	(select *, 
    sum(case when car is null then 0 else 1 end) over(order by id) as car_segment,
    sum(case when length is null then 0 else 1 end) over(order by id) as length_segment,
    sum(case when width is null then 0 else 1 end) over(order by id) as width_segment,
    sum(case when height is null then 0 else 1 end) over(order by id) as height_segment
	from footer)
select 
  first_value(car) over(partition by car_segment order by id) as new_car,
  first_value(length) over(partition by length_segment order by id) as new_length ,
  first_value(width) over(partition by width_segment order by id) as new_width,
  first_value(height) over(partition by height_segment order by id) as new_height
from cte 
order by id desc
limit 1;

-- 3rd way

with cte as(
		select *,
		count(car) over(order by id) as car1,
		count(length) over(order by id) as length1,
		count(width) over(order by id) as width1,
		count(height) over(order by id) as height1
		from FOOTER)
SELECT 
		max(car) over(partition by car1) as car,
		max(length) over(partition by length1) as length,
		max(width) over(partition by width1) as width,
		max(height) over(partition by height1) as height
from cte order by id desc limit 1;