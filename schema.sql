/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY ,
    name varchar(50) NOT NULL,
    date_of_birth date,
    escape_attempts INTEGER,
    neutered boolean,
    weight_kg decimal(4,2),
    species varchar(50)
);

-- Make id autoincremented primary key
ALTER TABLE animals ADD PRIMARY KEY (id);

-- Remove the "species" column
ALTER TABLE animals DROP COLUMN species;

-- Add the "species_id" and "owner_id" columns as foreign keys
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id), ADD COLUMN owner_id INTEGER REFERENCES owners(id);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the "vets" table
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);

-- Create the "specializations" join table
CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

-- Create the "visits" join table
CREATE TABLE visits (
    vet_id INTEGER REFERENCES vets(id),
    animal_id INTEGER REFERENCES animals(id),
    visit_date DATE,
    PRIMARY KEY (vet_id, animal_id, visit_date)
);
