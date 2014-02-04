-- Test data for the sqltalk database
USE sqltalk;

-- Column list can be left off and it is derived from the table definition
-- If auto_increment columns are specified as `0` or `null` (or omitted),
-- column value is derived from the table's auto increment value
INSERT IGNORE INTO AddressTypes
VALUES
  (0, "Shipping"),
  (0, "Billing")
;

INSERT IGNORE INTO PhoneNumberTypes
VALUES
  (0, "Day"),
  (0, "Evening")
;

INSERT INTO Users
VALUES
  (0, "foo", null),
  (0, "bar", null),
  (0, "baz", null),
  (0, "ban", null),
  (0, "din", null),
  (0, "don", null)
;

-- INSERT/SELECT allows you to insert data by querying other tables
INSERT INTO Addresses
SELECT
  0, userID, adtID, CONCAT(username, "-shipaddr")
FROM
  Users
  CROSS JOIN AddressTypes
WHERE
  username IN ("foo", "baz", "din")
  AND adtName = "Shipping"
;

INSERT INTO Addresses
VALUES
  (0, 1, 2, "foo-billaddr"),
  (0, 2, 2, "bar-billaddr")
;

INSERT INTO PhoneNumbers
SELECT
  0, userID, pntID, CONCAT(username, "-dayphone")
FROM
  Users
  CROSS JOIN PhoneNumberTypes
WHERE
  username IN ("bar", "ban", "don")
  AND pntName = "Day"
;

INSERT INTO PhoneNumbers
  (userID, pntID, phoneNumber)
VALUES
  (2, 2, "baz-evephone"),
  (5, 2, "din-evephone")
;

INSERT INTO Organizations
VALUES
  (0, "Mobiquity"),
  (0, "Wawa"),
  (0, "MPM"),
  (0, "Panera")
;
