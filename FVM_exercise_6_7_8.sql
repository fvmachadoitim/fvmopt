/*
### PLSQL Development
6. Create a package with procedure or function that can be invoked by store 
or all stores to save the item_loc_soh to a new table that will contain the same information 
plus the stock value per item/loc (unit_cost*stock_on_hand)

7. Create a data filter mechanism that can be used at screen level to filter out the data that 
-- user can see accordingly to dept association (created previously)

8. Create a pipeline function to be used in the location list of values (drop down)
*/

CREATE OR REPLACE PACKAGE pck_fvm_test IS

  TYPE t_get_loc_rcd IS RECORD(
     loc_desc VARCHAR2(200),
     loc      VARCHAR2(200));

  TYPE t_get_loc_rcd_tbl IS TABLE OF t_get_loc_rcd;

  FUNCTION fnc_save_item_loc_soh(p_loc IN loc.loc%TYPE DEFAULT NULL) RETURN PLS_INTEGER;

  FUNCTION get_locs RETURN t_get_loc_rcd_tbl
  PIPELINED;

END;
/

CREATE OR REPLACE PACKAGE BODY pck_fvm_test IS
  FUNCTION fnc_save_item_loc_soh(p_loc IN loc.loc%TYPE DEFAULT NULL) RETURN PLS_INTEGER AS
  
    l_ret PLS_INTEGER;
  BEGIN
  
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE NEW_item_loc_soh';
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    -- EXECUTE IMMEDIATE q'[CREATE TABLE NEW_item_loc_soh NOLOGGING parallel(degree 4)
    EXECUTE IMMEDIATE q'[CREATE TABLE NEW_item_loc_soh NOLOGGING 
                       AS
                       select inn2.*
                       from
                       (
                         SELECT inn.*, inn.unit_cost*inn.stock_on_hand as Stock_on_hand_value
                         from  item_loc_soh inn
                         where ]' || CASE
                        WHEN p_loc IS NULL THEN
                         ' 1 = 1 '
                        ELSE
                         ' inn.loc = ''' || p_loc || ''''
                      END || ') inn2
                      where rownum < 2'; -- due to lack of space
  
    EXECUTE IMMEDIATE q'[select count(1) as total from  NEW_item_loc_soh]'
      INTO l_ret;

    RETURN l_ret;
  
    /*EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;*/
  END fnc_save_item_loc_soh;

  
  FUNCTION get_locs RETURN t_get_loc_rcd_tbl
    PIPELINED IS
  
    l_c_to_export   SYS_REFCURSOR;
    l_to_export_row t_get_loc_rcd;
  
  BEGIN
  
    OPEN l_c_to_export FOR q'[select concat(concat(loc, ' - '), loc_desc) as loc_desc, loc from loc ]';
    LOOP
      FETCH l_c_to_export
        INTO l_to_export_row;
      EXIT WHEN l_c_to_export%NOTFOUND;
      PIPE ROW(l_to_export_row);
    END LOOP;
  
  END get_locs;

END pck_fvm_test;
/
