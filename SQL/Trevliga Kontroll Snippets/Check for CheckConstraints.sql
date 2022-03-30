SELECT      Name, Parent_Object_ID, Create_Date, Modify_Date, Definition
FROM        sys.check_constraints
WHERE       Parent_Object_ID = OBJECT_ID('dbo.Titles');