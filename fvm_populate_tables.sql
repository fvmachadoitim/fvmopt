--- in average this will take 1s to be executed
delete item where 1=1;
delete loc where 1=1;
delete item_loc_soh where 1=1;

insert into item(item,dept,item_desc)
select level, round(DBMS_RANDOM.value(1,100)), translate(dbms_random.string('a', 20), 'abcXYZ', level) from dual connect by level <= 1000;
-- before 10000

--- in average this will take 1s to be executed
insert into loc(loc,loc_desc)
select level+100, translate(dbms_random.string('a', 20), 'abcXYZ', level) from dual connect by level <= 100;
-- before

-- in average this will take less than 120s to be executed
--insert into item_loc_soh (item, loc, dept, unit_cost, stock_on_hand)
--select item, loc, dept, (DBMS_RANDOM.value(5000,50000)), round(DBMS_RANDOM.value(1000,100000))
--from item, loc;

commit;