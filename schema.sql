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
