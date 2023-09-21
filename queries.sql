/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

DELETE FROM animals;
ROLLBACK;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon'; 
UPDATE animals SET species = 'pokemon' WHERE species IS NULL; 

SELECT species from animals;
COMMIT;
SELECT species from animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint1;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO my_savepoint1;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
SELECT AVG(weight_kg) AS average_weight FROM animals;  
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- Make id autoincremented primary key
ALTER TABLE animals ADD PRIMARY KEY (id);

-- Remove the "species" column
ALTER TABLE animals DROP COLUMN species;


-- Add the "species_id" and "owner_id" columns as foreign keys
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id), ADD COLUMN owner_id INTEGER REFERENCES owners(id);

-- Queries to answer questions

-- What animals belong to Melody Pond?
SELECT name FROM animals WHERE owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond');

-- List of all animals that are Pokemon 
SELECT name FROM animals WHERE species_id = (SELECT id FROM species WHERE name = 'Pokemon');

-- List all owners and their animals, including those who don't own any animal.
SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name AS species, COUNT(*) AS count FROM animals a INNER JOIN species s ON a.species_id = s.id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name FROM animals a INNER JOIN species s ON a.species_id = s.id INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) AS animal_count FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

