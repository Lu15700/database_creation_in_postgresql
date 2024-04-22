-- Connect to Database
-- https://www.postgresqltutorial.com/postgresql-getting-started/connect-to-postgresql-database

-----
-- Create Database
CREATE DATABASE master_database;

-----
-- Create Schema
CREATE SCHEMA master_schema;

-----
-- Create Tables
CREATE TABLE master_schema.user (
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE CONSTRAINT pk_user PRIMARY KEY,
  password VARCHAR(100) NOT NULL
);

CREATE TABLE master_schema.review (
  review_id SERIAL CONSTRAINT pk_review_id PRIMARY KEY,
  product_id SMALLINT NOT NULL,
  comment VARCHAR(255)
);

CREATE TABLE master_schema.user_reviews (
  email VARCHAR(100) NOT NULL,
  review_id SERIAL,

CONSTRAINT fk_email
  FOREIGN KEY(email)
    REFERENCES master_schema.user(email),

CONSTRAINT fk_review_id
  FOREIGN KEY(review_id)
    REFERENCES master_schema.review(review_id)
);

CREATE TABLE master_schema.product (
  product_id SERIAL CONSTRAINT pk_product_id PRIMARY KEY,
  name  VARCHAR(100) NOT NULL,
  price SMALLINT NOT NULL,
  color VARCHAR(50) NOT NULL,
  width SMALLINT NOT NULL,
  length SMALLINT NOT NULL,
  height SMALLINT NOT NULL,
  weight SMALLINT NOT NULL
);

CREATE TABLE master_schema.product_reviews (
  review_id SERIAL,
  product_id SERIAL,

CONSTRAINT fk_review_id
  FOREIGN KEY(review_id)
    REFERENCES master_schema.review(review_id),

CONSTRAINT fk_product_id
  FOREIGN KEY(product_id)
    REFERENCES master_schema.product(product_id)
);

CREATE TABLE master_schema.order (
  order_id SERIAL CONSTRAINT pk_order_id PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  shipping_address VARCHAR(100) NOT NULL,
  billing_address VARCHAR(100) NOT NULL,
  status VARCHAR(100) NOT NULL,

CONSTRAINT fk_email
  FOREIGN KEY(email)
    REFERENCES master_schema.user(email)
);

CREATE TABLE master_schema.order_items (
  order_id SERIAL,
  product_id SERIAL,

CONSTRAINT fk_order_id
  FOREIGN KEY(order_id)
    REFERENCES master_schema.order(order_id),

CONSTRAINT fk_product_id
  FOREIGN KEY(product_id)
    REFERENCES master_schema.product(product_id)
);