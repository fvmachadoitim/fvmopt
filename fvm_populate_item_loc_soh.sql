-- in average this will take less than 120s to be executed
delete item_loc_soh where 1=1;
-- in average this will take less than 120s to be executed
insert into item_loc_soh (item, loc, dept, unit_cost, stock_on_hand)
SELECT * FROM
(
select item, loc, dept, (DBMS_RANDOM.value(5000,50000)), round(DBMS_RANDOM.value(1000,100000))
from item, loc
) WHERE ROWNUM < 5001; 
-- reduced due to lack of space on tablespace

commit;