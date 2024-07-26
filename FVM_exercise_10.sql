-- 10. Run the previous method that was created on 6. 
-- for all the stores from item_loc_soh to the history table. 
-- The entire migration should not take more than 10s to run (don't use parallel hint to solve it :)) 


DECLARE
  l_ret PLS_INTEGER;
BEGIN
   l_ret :=  pck_fvm_test.fnc_save_item_loc_soh(p_loc => NULL);
   DBMS_OUTPUT.put_line(CONCAT('l_ret ', l_ret)); 
END;
/