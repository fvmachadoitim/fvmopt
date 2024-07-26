/*
# Context
Item loc stock on hand represents a snapshot table of stock 
in a specific moment for all items in all stores/warehouses for a retailer. 
In scenario where you have an Apex application that enables 

a view of stock per store/warehouse please consider the following:

 - this application has an very high user concurrency access during the entire day
 - the access to the application data is per store/warehouse
 - one of the attributes that most store/warehouse users search is by dept
*/

-- 2. Your suggestion for table data management and data access considering the application usage, for example, partition...

-- item_loc_soh particionar por loc (store/warehouse)
-- item_loc_soh sub-particionar por dept

begin
  null;
end;
/