SELECT
    fk.NAME,
    OBJECT_NAME(parent_object_id) 'FK_Table',
    OBJECT_NAME(referenced_object_id) 'Linked Table',
    fk.*
FROM sys.foreign_keys fk




