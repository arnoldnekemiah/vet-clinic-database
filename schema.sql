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
