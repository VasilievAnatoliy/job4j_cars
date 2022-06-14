CREATE TABLE IF NOT EXISTS engines (
     id         SERIAL PRIMARY KEY,
     name       TEXT
);

CREATE TABLE IF NOT EXISTS models (
     id         SERIAL PRIMARY KEY,
     name       TEXT
);

CREATE TABLE IF NOT EXISTS users (
     id         SERIAL PRIMARY KEY,
     name       TEXT,
     email      VARCHAR UNIQUE,
     password   TEXT
);

CREATE TABLE IF NOT EXISTS bodys (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR UNIQUE
);

CREATE TABLE IF NOT EXISTS cars (
     id          SERIAL PRIMARY KEY,
     brand        TEXT,
     model_id INT NOT NULL REFERENCES models(id),
     body_id INT NOT NULL REFERENCES bodys(id),
     engine_id INT NOT NULL UNIQUE REFERENCES engines(id)
);

CREATE TABLE IF NOT EXISTS history_owner (
    id serial primary key,
    user_id INT NOT NULL REFERENCES users(id),
    car_id INT NOT NULL REFERENCES cars(id)
);

CREATE TABLE IF NOT EXISTS posts (
      id          SERIAL PRIMARY KEY,
      description TEXT,
      photo       BYTEA,
      created     TIMESTAMP,
      sold        BOOLEAN,
      car_id INT NOT NULL REFERENCES cars(id),
      user_id INT NOT NULL REFERENCES users(id)
    );







