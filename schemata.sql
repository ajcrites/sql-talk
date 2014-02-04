-- Remove the database completely and start from scratch
DROP SCHEMA IF EXISTS sqltalk;

-- Create the database
CREATE SCHEMA sqltalk;

-- Use the database so you don't have to specify `sqltalk.Users`, etc.
USE sqltalk;

-- Users are identified by a unique username
CREATE TABLE Users (
  userID int unsigned not null auto_increment primary key,
  username varchar(255),
  usercreated timestamp not null default current_timestamp,
  unique key (username)
);

-- Types of Addresses
CREATE TABLE AddressTypes (
  adtID int unsigned not null auto_increment primary key,
  adtName varchar(255),
  unique key (adtName)
);

-- Types of Phone Numbers
CREATE TABLE PhoneNumberTypes (
  pntID int unsigned not null auto_increment primary key,
  pntName varchar(255),
  unique key (pntName)
);

-- Each address is associated with a user (one-to-many relationship, one user to many addresses)
-- and has a type (from AddressTypes, also a one-to-many relationship)
-- `foreign key`s point to other tables
CREATE TABLE Addresses (
  addrID int unsigned not null auto_increment primary key,
  userID int unsigned not null,
  adtID int unsigned not null,
  addrName varchar(255),
  foreign key (userID) references Users (userID),
  foreign key (adtID) references AddressTypes (adtID)
);

-- Similar to addresses
CREATE TABLE PhoneNumbers (
  phnID int unsigned not null auto_increment primary key,
  userID int unsigned not null,
  pntID int unsigned not null,
  phoneNumber varchar(255),
  foreign key (userID) references Users (userID),
  foreign key (pntID) references PhoneNumberTypes (pntID)
);

-- Top level, named grouping of users
CREATE TABLE Organizations (
  orgID int unsigned not null auto_increment primary key,
  orgName varchar(255),
  unique key (orgName)
);

-- Many-to-many relationship table.  A User can belong to multiple
-- organizations (the same `userID` can appear in many rows of this table).
-- An organization can also contain many users.  The relationship is unique;
-- it wouldn't make sense for a user to be associated with the same
-- organization multiple times
CREATE TABLE UsersOrganizations (
  uoID int unsigned not null auto_increment primary key,
  userID int unsigned not null,
  orgID int unsigned not null,
  foreign key (userID) references Users (userID),
  foreign key (orgID) references Organizations (orgID),
  unique key (userID, orgID)
);
