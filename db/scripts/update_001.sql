CREATE TABLE IF NOT EXISTS engines (
     id         SERIAL PRIMARY KEY,
     name       TEXT
);

CREATE TABLE IF NOT EXISTS cars (
     id          SERIAL PRIMARY KEY,
     name        TEXT,
     engine_id INT NOT NULL UNIQUE REFERENCES engines(id)
);

CREATE TABLE IF NOT EXISTS drivers (
    id          SERIAL PRIMARY KEY,
    name        TEXT
);

CREATE TABLE IF NOT EXISTS history_owner (
    id serial primary key,
    driver_id INT NOT NULL REFERENCES drivers(id),
    car_id INT NOT NULL REFERENCES cars(id)
);







