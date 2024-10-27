-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "organizationId" INTEGER NOT NULL,
    "state" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "pickupPlace" TEXT NOT NULL,
    "Contract_id" INTEGER,
    CONSTRAINT "Order_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Order" ("Contract_id", "date", "id", "organizationId", "pickupPlace", "state") SELECT "Contract_id", "date", "id", "organizationId", "pickupPlace", "state" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
CREATE UNIQUE INDEX "Order_Contract_id_key" ON "Order"("Contract_id");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
