-- 4. Create a view that can be used at screen level to show only the required fields

CREATE OR REPLACE VIEW v_items AS
SELECT 
  i.item || ' - ' || i.item_desc AS item_de, i.item FROM item i;


CREATE OR REPLACE VIEW v_locs AS
select loc || ' - ' || loc_desc AS loc_desc, loc from loc;
