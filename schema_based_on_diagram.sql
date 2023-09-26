CREATE DATABASE clinic;

CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    date_of_birth DATE,
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(255),
    PRIMARY KEY(id)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id),
    PRIMARY KEY(id)
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(255),
    name VARCHAR(255),
    PRIMARY KEY(id)
)

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY(id)
);

CREATE TABLE medical_join_treatments (
    medical_history_id integer,
    treatment_id integer,
    CONSTRAINT fk_medical_history FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_treatment FOREIGN KEY(treatment_id) REFERENCES treatments(id) 
);
