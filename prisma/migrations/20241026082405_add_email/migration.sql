-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Organization" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "ICO" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "userId" INTEGER,
    "emailToken" TEXT NOT NULL,
    "email" TEXT NOT NULL DEFAULT '',
    CONSTRAINT "Organization_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("organization_id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Organization" ("ICO", "active", "address", "description", "emailToken", "id", "name", "userId") SELECT "ICO", "active", "address", "description", "emailToken", "id", "name", "userId" FROM "Organization";
DROP TABLE "Organization";
ALTER TABLE "new_Organization" RENAME TO "Organization";
CREATE UNIQUE INDEX "Organization_ICO_key" ON "Organization"("ICO");
CREATE UNIQUE INDEX "Organization_userId_key" ON "Organization"("userId");
CREATE UNIQUE INDEX "Organization_emailToken_key" ON "Organization"("emailToken");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
