
drop table if exists Q4_data;
create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);
insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);

select * from Q4_data;

-- 1st expected output

SELECT 
    MIN(id) Id, MIN(`name`) `Name`, MIN(location) Location
FROM
    q4_data;

-- 2nd Expected output

SELECT 
    MAX(id) Id, MAX(`name`) `Name`, MAX(location) Location
FROM
    q4_data;

