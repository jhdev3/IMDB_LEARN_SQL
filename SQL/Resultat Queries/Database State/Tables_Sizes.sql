
--STORLEK PÅ RESPEKTIVE Tabell
SELECT 
    t.NAME AS TableName,
    p.rows,
    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB
FROM sys.tables t
INNER JOIN      
    sys.indexes i 
	ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p 
	ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a 
	ON p.partition_id = a.container_id
WHERE t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY t.Name, p.Rows
ORDER BY TotalSpaceMB DESC, t.Name

/* 
TableName		rows			TotalSpaceMB
InvolvedIn		48 460 118		4 635.02
Titles			8 527 053		1 028.82
TitlesGenres	13 670 417		772.20
People			11 512 537		620.07
KnownFor		17 770 097		571.95
Professions		12 510 887		541.07
Writers			10 316 463		333.20
Episodes		6 429 733		247.88
Directors		6 509 101		210.32
TitleRatings	1 207 727		40.20

*/