/* Database schema to keep the structure of entire database. */

/* SQL command to create the animals table. */
CREATE TABLE animals(id INT NOT NULL primary key,
                     name VARCHAR(250),
                     date_of_birth DATE, 
                     escape_attempts INT, 
                     neutered BOOLEAN, 
                     weight_kg FLOAT);

/* Alter animals table to add species column*/
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

/*THE FOLLOWING SCHEMA GOES FOR THE QUERRY OF MULTIPLE TABLE MILESTONE*/
/* create the owners table*/
CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR(250),age INT);
/* create the species table*/
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(100));
/*Alter the "id" column to set it as an auto-incremented primary key*/
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
/* Remove the "species" column*/
ALTER TABLE animals DROP COLUMN IF EXISTS species;
/* Add the "species_id" column as a foreign key referencing the "id" column in the "species" table */
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
/*Add the "owner_id" column as a foreign key referencing the "id" column in the "owners" table*/
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

/* THE FOLLOWING ACHEMA GOES FOR THE JOIN-TABLE MILESTONE*/
/*creating vets table*/
CREATE TABLE vets ( id SERIAL PRIMARY KEY, name VARCHAR(100), age INTEGER, date_of_graduation DATE );
/*Create the specializations table*/
CREATE TABLE specializations ( vet_id INTEGER REFERENCES vets(id), species VARCHAR(100), PRIMARY KEY (vet_id, species));
/*Add unique constraint to the id column of the animals table to avoid errors*/
ALTER TABLE animals ADD CONSTRAINT animals_id_unique UNIQUE (id);
/*Create the visits table*/
CREATE TABLE visits (animal_id INTEGER REFERENCES animals(id),vet_id INTEGER REFERENCES vets(id),visit_date DATE,PRIMARY KEY (animal_id, vet_id, visit_date));
