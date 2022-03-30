--Se Över
--För att enkelt lista alla Generes tex och skapa lite extra "Säkerhet när man skapar Generes osv"

DROP TABLE IF EXISTS dbo.Genres

CREATE TABLE Genres(
	Gener_nameID VARCHAR(255) NOT NULL,--PK och Namn i Genres bör inte finnas någon Genere med Lika namn ;) 
);