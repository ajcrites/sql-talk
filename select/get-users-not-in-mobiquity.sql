-- SELECT all users who are not associated with the 'Mobiquity' organization
-- This means that they should have no UsersOrganizations column that matches
-- their userID if the orgID matches Mobiquity's

-- This uses the technique of `WHERE LEFT-JOINed table IS NULL` to print all
-- results that do *not* match
USE sqltalk;

SELECT
  username
FROM
  Users AS u
  LEFT JOIN (
    UsersOrganizations AS uo
    JOIN Organizations AS o USING (orgID)
  ) ON (
    u.userID = uo.userID
    AND orgName = 'Mobiquity'
  )
WHERE o.orgID IS NULL
