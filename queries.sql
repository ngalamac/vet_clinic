/*Queries that display all animals whose name ends with "mon .*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*Queries that display the names of all animals born between 2016 and 2019.*/
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

/*Queries that display all animals that are neutered and have less than 3 escape attempts:*/
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

/*Queries that display the date of birth of all animals named either "Agumon" or "Pikachu": */
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/*Queries that display the name and escape attempts of animals that weigh more than 10.5kg:*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Queries that display all animals that are neutered:*/
SELECT * FROM animals WHERE neutered = TRUE;

/*Queries that display all animals not named Gabumon:*/
SELECT * FROM animals WHERE name <> 'Gabumon';

/*Queries that display all animals with a weight between 10.4kg and 17.3kg (including the animals with weights that equal precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*THE FOLLOWING QUERRY WAS DONE IN THE QUERRY-UPDATE MILESTONE: */
/* query to set the species column to unspecified and verifying the change*/
BEGIN;
UPDATE animals SET species = 'unspecified'; SELECT * FROM animals; 
ROLLBACK;
SELECT * FROM animals;

/* query to set the species column to "digimon" for animals with names ending in "mon" and set it to "pokemon" for animals without a species:*/

BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/* querry to delete all records in the animals table and then roll back the transaction:*/

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
/*query to delete all animals born after Jan 1st, 2022. Create a savepoint, update all animals' weight to be their weight multiplied by -1, and then rollback to the savepoint:*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
SELECT * FROM animals;

/*Uerry to update the weights of all animals that are negative to be their weight multiplied by -1, and then commit the transaction:*/

BEGIN;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* How many animals are there? */
SELECT COUNT(*) AS total_number_of_animals FROM animals;

/*How many animals have never tried to escape?*/
SELECT COUNT(*) AS number_not_escaped FROM animals WHERE escape_attempts = 0;

/*What is the average weight of animals?*/
SELECT AVG(weight_kg) AS average_weight FROM animals;

/*Who escapes the most, neutered or not neutered animals?*/
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts FROM animals GROUP BY neutered ORDER BY total_escape_attempts DESC LIMIT 1;

/*What is the minimum and maximum weight of each type of animal?*/
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
