SELECT      Name, Parent_Object_ID, Create_Date, Modify_Date, Definition
FROM        sys.check_constraints
WHERE       Parent_Object_ID = OBJECT_ID('dbo.Titles');


--Index
SELECT  Tab.name  Table_Name 
			 ,IX.name  Index_Name
			 ,IX.type_desc Index_Type
			 ,Col.name  Index_Column_Name
			 ,IXC.is_included_column Is_Included_Column
			  
           FROM  sys.indexes IX 
           INNER JOIN sys.index_columns IXC  ON  IX.object_id   =   IXC.object_id AND  IX.index_id  =  IXC.index_id  
           INNER JOIN sys.columns Col   ON  IX.object_id   =   Col.object_id  AND IXC.column_id  =   Col.column_id     
           INNER JOIN sys.tables Tab      ON  IX.object_id = Tab.object_id