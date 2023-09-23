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
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) AS animal_count FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name AS animal_name
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS num_animals_seen
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vt.name AS vet_name, COALESCE(s.name, 'No Specialty') AS specialty
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'Stephanie Mendez'
    AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name AS animal_name
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

-- Details for the most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN specializations s ON vt.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS recommended_specialty
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
JOIN specializations sp ON vt.id = sp.vet_id
JOIN species s ON sp.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;
