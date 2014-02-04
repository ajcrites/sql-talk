-- SELECT all users.  If they have addresses, also SELECT their addresses.
-- Address is not mandatory to SELECT the user.
-- This is specified by the LEFT JOIN
USE sqltalk;
SELECT
  username, addrName
FROM
  Users
  LEFT JOIN Addresses USING (userID)
