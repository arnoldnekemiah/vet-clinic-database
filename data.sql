/* Populate database with sample data. */
INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ( 'Agumon', '2020-02-03',0,true,10.23);

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ( 'Gabumon', '2018-11-15',2,true,8);

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ( 'Pikachu', '2021-01-07',1,false,15.04);

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ( 'Devimon', ' 2017-05-12',5,true,11);

 INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Charmander', '2020-02-08', -11.0, false, 0, 'Fire');

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Plantmon', '2021-11-15', -5.7, true, 2, 'Plant');

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Squirtle', '1993-04-02', -12.13, false, 3, 'Water');

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Angemon', '2005-06-12', -45.0, true, 1, 'Angel');

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Boarmon', '2005-06-07', 20.4, true, 7, 'Mammal');

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Blossom', '1998-10-13', 17.0, true, 3, 'Plant');

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Ditto', '2022-05-14', 22.0, true, 4, 'Unknown');

-- Insert data into the "owners" table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),('Jennifer Orwell', 19),('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14)

INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');
-- Update animals with species_id based on name
UPDATE animals SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon') ELSE (SELECT id FROM species WHERE name = 'Pokemon') END);
-- Update animals with owner_id based on owner information
UPDATE animals SET owner_id = (CASE WHEN name IN ('Agumon') THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob') WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')END);

-- Insert data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert data for specializations
-- Find the vet_id for each vet
INSERT INTO specializations (vet_id, species_id)
VALUES
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

-- Insert data for visits
-- Find the vet_id and animal_id for each visit
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');
