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

/* THE FOLLOWING GOES FOR THE JOIN-TABLE MILESTONE*/
/* Insert data into vets table*/
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Vet William Tatcher', 45, '2000-04-23'),('Vet Maisy Smith', 26, '2019-01-17'),
('Vet Stephanie Mendez', 64, '1981-05-04'),
  ('Vet Jack Harkness', 38, '2008-06-08');

/*Insert data into the specializations table*/
INSERT INTO specializations (vet_id, species)
VALUES (1, 'Pokemon'), (3, 'Digimon'), (3, 'Pokemon'), (4, 'Digimon');
/* Insert data into the visits table */
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
  (1, 1, '2020-05-24'),(1, 3, '2020-07-22'),(2, 4, '2021-02-02'),(3, 2, '2020-01-05'),(3, 2, '2020-03-08'),(3, 2, '2020-05-14'),
  (4, 3, '2021-05-04'),(5, 4, '2021-02-24'),(6, 2, '2019-12-21'),(6, 1, '2020-08-10'),(6, 2, '2021-04-07'),(7, 3, '2019-09-29'),
  (8, 4, '2020-10-03'),(8, 4, '2020-11-04'),(9, 4, '2019-01-24'),(9, 4, '2019-05-15'),(9, 4, '2020-02-27'),(9, 4, '2020-08-03'),
  (10, 3, '2020-05-24'),(10, 1, '2021-01-11');

/*THE FOLLOWING DATA GOES FOR THE PERFORMANCE AUDIT MILESTONE*/
/*Populate more data into the visits table */
INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT *
FROM (
  SELECT id FROM animals
) animal_ids,
(
  SELECT id FROM vets
) vet_ids,
generate_series('1980-01-01'::timestamp, '9999-01-01', '4 hours') visit_timestamp
ON CONFLICT DO NOTHING;
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
