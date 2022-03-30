SELECT
    fk.NAME,
    OBJECT_NAME(parent_object_id) 'TitlesGenres',
    OBJECT_NAME(referenced_object_id) 'Titles',
    fk.*
FROM sys.foreign_keys fk