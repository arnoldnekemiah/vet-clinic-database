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



INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');
-- Update animals with species_id based on name
UPDATE animals SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon') ELSE (SELECT id FROM species WHERE name = 'Pokemon') END);
-- Update animals with owner_id based on owner information
UPDATE animals SET owner_id = (CASE WHEN name IN ('Agumon') THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob') WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')END);
