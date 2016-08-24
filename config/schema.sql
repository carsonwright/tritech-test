drop database tritech_development;
drop database tritech_testing;
create database tritech_development;
create database tritech_testing;
\connect tritech_testing;
create table organizations (
  id char(36), 
  name varchar(20), 
  private_key char(28), 
  public_key char(28),  
  created_at timestamp, 
  updated_at timestamp
);

create table users (
  id char(36), 
  first_name varchar(60), 
  last_name varchar(60), 
  email varchar(255),  
  created_at timestamp, 
  updated_at timestamp, 
  organization_id char(36)
);

create table products (
  id char(36), 
  name varchar(40), 
  user_id char(36), 
  category varchar(30), 
  created_at timestamp, 
  updated_at timestamp
);
\connect tritech_development;
create table organizations (
  id char(36), 
  name varchar(20), 
  private_key char(28), 
  public_key char(28),  
  created_at timestamp, 
  updated_at timestamp
);

create table users (
  id char(36), 
  first_name varchar(60), 
  last_name varchar(60), 
  email varchar(255),  
  created_at timestamp, 
  updated_at timestamp, 
  organization_id char(36)
);

create table products (
  id char(36), 
  name varchar(40), 
  user_id char(36), 
  category varchar(30), 
  created_at timestamp, 
  updated_at timestamp
);