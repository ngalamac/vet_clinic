/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

/* Populate more data after adding the species column. */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (5, 'Charmander', '2020-02-08', 0, FALSE, -11, NULL);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7, NULL);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13, NULL);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (8, 'Angemon', '2005-06-12', 1, TRUE, -45, NULL);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4, NULL);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17, NULL);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES (11, 'Ditto', '2022-05-14', 4, TRUE, 22, NULL);

/*THE FOLLOWING GOES FOR THE QUERRY-MULTIPLE-TABLE MILESTONE*/
/* populate data in the owners table*/
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),('Jennifer Orwell', 19),('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14),('Jodie Whittaker', 38);
/* populate data in the species table*/
INSERT INTO species (name)
VALUES ('Pokemon'),('Digimon');
/* Update the animals table to have the right suffix for species*/
UPDATE animals SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
  END;
/*Update owner_id for Agumon*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
/*Update owner_id for Gabumon*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon';
/*Update owner_id for Pikachu*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Pikachu';
/*Update owner_id for Devimon*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon';
/*Update owner_id for Plantmon*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Plantmon';
/*Update owner_id for Charmander*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander';
/*Update owner_id for Squirtle*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Squirtle';
/*Update owner_id for Blossom*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Blossom';
/*Update owner_id for Angemon*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon';
/*Update owner_id for Boarmon*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Boarmon';
