/*
## Should Have
### Performance
9. Looking into the following explain plan what should be your 
recommendation and implementation to improve the existing data model. 
Please share your solution in sql 
and the corresponding explain plan of that solution. 
Please take in consideration the way that user will use the app.
```sql

 Plan Hash Value  : 1697218418 

------------------------------------------------------------------------------
| Id  | Operation           | Name         | Rows | Bytes | Cost  | Time       |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |              | 100019 | 40760 | 10840 | 00:00:03 |
| * 1 |   TABLE ACCESS FULL | ITEM_LOC_SOH | 100019 | 40760 | 10840 | 00:00:03 |
------------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 1 - filter("LOC"=652 AND "DEPT"=68)


Notes
-----
- Dynamic sampling used for this statement ( level = 2 )
*/

--EXPLAIN PLAN INTO plan_table for 
--SELECT * FROM ITEM_LOC_SOH
--WHERE "LOC"=652 AND "DEPT"=68;

-- select * from table(dbms_xplan.display('PLAN_TABLE',NULL,'ADVANCED'));

--EXPLAIN PLAN  for 
--SET AUTOTRACE ON
SELECT * FROM ITEM_LOC_SOH
WHERE "LOC"=652 AND "DEPT"=68;
/

SELECT * FROM  TABLE(DBMS_XPLAN.DISPLAY_CURSOR());


 


-- Resposta: criar o index por LOC, DEPT  para evitar o table access full                                  


/*
Plan hash value: 2163009346
 
-------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                       |  1034 | 68244 |     5   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID BATCHED| ITEM_LOC_SOH          |  1034 | 68244 |     5   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | ITEM_LOC_SOH__LOC_IDX |   437 |       |     3   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$1 / ITEM_LOC_SOH@SEL$1
   2 - SEL$1 / ITEM_LOC_SOH@SEL$1
 
Outline Data
-------------
 
  /*+
      BEGIN_OUTLINE_DATA
      BATCH_TABLE_ACCESS_BY_ROWID(@"SEL$1" "ITEM_LOC_SOH"@"SEL$1")
      INDEX_RS_ASC(@"SEL$1" "ITEM_LOC_SOH"@"SEL$1" ("ITEM_LOC_SOH"."LOC"))
      OUTLINE_LEAF(@"SEL$1")
      ALL_ROWS
      OPT_PARAM('_fix_control' '31143146:1')
      DB_VERSION('19.1.0')
      OPTIMIZER_FEATURES_ENABLE('19.1.0')
      IGNORE_OPTIM_EMBEDDED_HINTS
      END_OUTLINE_DATA
  */
/*
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("DEPT"=68)
   2 - access("LOC"=652)
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - "ITEM_LOC_SOH"."ITEM"[VARCHAR2,25], "LOC"[NUMBER,22], "DEPT"[NUMBER,22], 
       "ITEM_LOC_SOH"."UNIT_COST"[NUMBER,22], "ITEM_LOC_SOH"."STOCK_ON_HAND"[NUMBER,22]
   2 - "ITEM_LOC_SOH".ROWID[ROWID,10], "LOC"[NUMBER,22]
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
 
Query Block Registry:
---------------------
 
  <q o="2" f="y"><n><![CDATA[SEL$1]]></n><f><h><t><![CDATA[ITEM_LOC_SOH]]></t><s><![CDATA[SEL$1]]></s><
        /h></f></q>
 

*/
