--Se �ver
--F�r att enkelt lista alla Generes tex och skapa lite extra "S�kerhet n�r man skapar Generes osv"

DROP TABLE IF EXISTS dbo.Genres

CREATE TABLE Genres(
	Gener_nameID VARCHAR(255) NOT NULL,--PK och Namn i Genres b�r inte finnas n�gon Genere med Lika namn ;) 
);