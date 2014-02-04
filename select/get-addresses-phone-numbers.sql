-- This query gets all addresses and phone numbers associated with each
-- user (if it has either one of them) and aggregates them into a single
-- row associated with that user
USE sqltalk;

SELECT
  username,
  GROUP_CONCAT(DISTINCT CONCAT(adtName, ': ', addrName) SEPARATOR ', ') AS Addresses,
  GROUP_CONCAT(DISTINCT CONCAT(pntName, ': ', phoneNumber) SEPARATOR ', ') AS 'Phone Numbers'
FROM
  Users AS u
  CROSS JOIN AddressTypes AS adt
  CROSS JOIN PhoneNumberTypes AS pnt
  LEFT JOIN Addresses AS a ON (
    u.userID = a.userID
    AND adt.adtID = a.adtID
  )
  LEFT JOIN PhoneNumbers AS p ON (
    u.userID = p.userID
    AND pnt.pntID = p.pntID
  )
GROUP BY
  username
