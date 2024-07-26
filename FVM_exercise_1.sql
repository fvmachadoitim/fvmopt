-- 1. Primary key definition and any other constraint or index suggestion

-- PK's
begin
  execute immediate 'ALTER TABLE  item DROP CONSTRAINT item_pk';
 exception when others then null;
end;
/

begin
  execute immediate 'ALTER TABLE  loc DROP CONSTRAINT loc_pk';
 exception when others then null;
end;
/

begin
  execute immediate 'ALTER TABLE  item_loc_soh  DROP CONSTRAINT item_loc_soh_pk';
 exception when others then null;
end;
/

ALTER TABLE  item ADD CONSTRAINT item_pk PRIMARY KEY(item);
 
ALTER TABLE  loc  ADD CONSTRAINT loc_pk PRIMARY KEY(loc);

ALTER TABLE  item_loc_soh  ADD CONSTRAINT item_loc_soh_pk PRIMARY KEY(item, loc, dept);



begin
  execute immediate 'ALTER TABLE  item DROP CONSTRAINT item_dept_uk';
 exception when others then null;
end;
/

-- UK's
ALTER TABLE  item ADD CONSTRAINT item_dept_uk UNIQUE (item, dept);


begin
  execute immediate 'DROP INDEX item__dept_idx';
 exception when others then null;
end;
/

begin
  execute immediate 'DROP INDEX item_loc_soh__loc_idx';
 exception when others then null;
end;
/

begin
  execute immediate 'DROP INDEX item_loc_soh__dept_idx';
 exception when others then null;
end;
/

begin
  execute immediate 'DROP INDEX item_loc_soh__loc_dept_idx';
 exception when others then null;
end;
/

-- IDX's 
CREATE INDEX item__dept_idx ON item(dept) PARALLEL 1 NOLOGGING;

CREATE INDEX item_loc_soh__loc_idx ON item_loc_soh(loc) PARALLEL 1 NOLOGGING;

-- CREATE INDEX item_loc_soh__dept_idx ON item_loc_soh(dept) PARALLEL 1 NOLOGGING; -- commented due to lack of space on tablespace

-- CREATE INDEX item_loc_soh__loc_dept_idx ON item_loc_soh(loc, dept) PARALLEL 1 NOLOGGING; -- commented due to lack of space on tablespace

