DROP VIEW IF EXISTS "LatestBuildPerProject" CASCADE;
DROP VIEW IF EXISTS "LatestBuildPerProjectDomain" CASCADE;
DROP VIEW IF EXISTS  "LatestStaticBuildPerProject" CASCADE;
DROP VIEW IF EXISTS "DashboardProject";
DROP VIEW IF EXISTS "ProjectWithDomain";

-- AlterTable
ALTER TABLE "AuthorizationToken" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "Build" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "ClientReferences" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "Domain" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3),
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "File" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3),
ALTER COLUMN "updatedAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "Project" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "ProjectDomain" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "TransactionLog" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "createdAt" SET DATA TYPE TIMESTAMPTZ(3);


CREATE OR REPLACE VIEW "LatestStaticBuildPerProject" AS
SELECT DISTINCT ON ("projectId")
  bld.id AS "buildId",
  bld."projectId",
  bld."updatedAt",
  bld."publishStatus"
FROM
  "Build" bld
WHERE
  bld.deployment IS NOT NULL
  AND bld.deployment::jsonb ->> 'destination'::text = 'static'
ORDER BY
  bld."projectId",
  bld."createdAt" DESC,
  "buildId";


CREATE VIEW "DashboardProject" AS
SELECT
  *,
  EXISTS (
    SELECT
      1
    from
      "Build"
    WHERE
      "Build"."projectId" = "Project".id
      AND "Build"."deployment" IS NOT NULL
  ) AS "isPublished"
FROM
  "Project";

