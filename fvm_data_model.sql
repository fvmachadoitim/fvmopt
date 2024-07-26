create table item(
    item varchar2(25) not null,
    dept number(4) not null,
    item_desc varchar2(25) not null
);

create table loc(
    loc number(10) not null,
    loc_desc varchar2(25) not null
);

create table item_loc_soh(
item varchar2(25) not null,
loc number(10) not null,
dept number(4) not null,
unit_cost number(20,4) not null,
stock_on_hand number(12,4) not null
);