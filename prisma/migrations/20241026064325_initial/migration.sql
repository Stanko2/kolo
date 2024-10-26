-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL DEFAULT 'password',
    "name" TEXT,
    "admin" BOOLEAN NOT NULL DEFAULT false,
    "organization_id" INTEGER
);
INSERT INTO "new_User" ("admin", "email", "id", "name", "organization_id", "password") SELECT "admin", "email", "id", "name", "organization_id", "password" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_organization_id_key" ON "User"("organization_id");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
