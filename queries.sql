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

