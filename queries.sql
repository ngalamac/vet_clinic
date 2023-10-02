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

/*THE FOLLOWING QUERY WAS DONE FOR THE QUERRY-MULTIPLE-TABLE MILESTONE*/
/* What animals belong to Melody Pond?*/
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
/* List of all animals that are pokemon (their type is Pokemon).*/
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;
/*How many animals are there per species?*/
SELECT s.name, COUNT(*) AS animal_count FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;
/*List all Digimon owned by Jennifer Orwell.*/
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id JOIN owners o ON a.owner_id = o.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';
/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;
/*Who owns the most animals?*/
SELECT o.full_name, COUNT(*) AS animal_count FROM owners o JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

/*THE FOLLOWING GOES FOR THE JOIN-TABLE MILESTONE */
/*1. Who was the last animal seen by William Tatcher?*/
SELECT a.name AS last_animal_seen FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Vet William Tatcher'
ORDER BY v.visit_date DESC LIMIT 1;
/*2. How many different animals did Stephanie Mendez see?*/
SELECT COUNT(DISTINCT v.animal_id) AS animal_count FROM visits v JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Vet Stephanie Mendez';
/*3. List all vets and their specialties, including vets with no specialties.*/
SELECT vt.name, COALESCE(s.species, 'No Specialization') AS specialization FROM vets vt LEFT JOIN specializations s ON vt.id = s.vet_id
ORDER BY vt.name;
/*4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Vet Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
/*5. What animal has the most visits to vets?*/
SELECT a.name, COUNT(*) AS visit_count FROM animals a JOIN visits v ON a.id = v.animal_id
GROUP BY a.name ORDER BY visit_count DESC LIMIT 1;
/* Who was Maisy Smith's first visit?*/
SELECT vt.name AS first_vet_visit FROM vets vt JOIN visits v ON vt.id = v.vet_id JOIN animals a ON v.animal_id = a.id
WHERE a.name = 'Maisy Smith' ORDER BY v.visit_date LIMIT 1;
/* Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date AS last_visit_date FROM visits v JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id WHERE v.visit_date = ( SELECT MAX(visit_date) FROM visits );

/* How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(*) AS mismatched_specializations FROM visits v JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations s ON vt.id = s.vet_id AND a.species = s.species WHERE s.vet_id IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT s.species AS recommended_specialty, COUNT(*) AS visit_count FROM visits v JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id JOIN specializations s ON vt.id = s.vet_id WHERE a.name = 'Maisy Smith'
GROUP BY s.species ORDER BY visit_count DESC LIMIT 1;
