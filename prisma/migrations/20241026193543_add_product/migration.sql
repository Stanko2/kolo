/*
  Warnings:

  - Added the required column `Contract_id` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `productId` to the `OrderProduct` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Contract" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "link" TEXT NOT NULL,
    "orderId" INTEGER NOT NULL,
    CONSTRAINT "Contract_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order" ("Contract_id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Contract" ("id", "link", "orderId") SELECT "id", "link", "orderId" FROM "Contract";
DROP TABLE "Contract";
ALTER TABLE "new_Contract" RENAME TO "Contract";
CREATE UNIQUE INDEX "Contract_orderId_key" ON "Contract"("orderId");
CREATE TABLE "new_Order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "organizationId" INTEGER NOT NULL,
    "state" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "pickupPlace" TEXT NOT NULL,
    "Contract_id" INTEGER NOT NULL,
    CONSTRAINT "Order_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Order" ("date", "id", "organizationId", "pickupPlace", "state") SELECT "date", "id", "organizationId", "pickupPlace", "state" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
CREATE UNIQUE INDEX "Order_Contract_id_key" ON "Order"("Contract_id");
CREATE TABLE "new_OrderProduct" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "productId" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "accepted" BOOLEAN NOT NULL,
    "orderId" INTEGER NOT NULL,
    CONSTRAINT "OrderProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "OrderProduct_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_OrderProduct" ("accepted", "count", "description", "id", "orderId") SELECT "accepted", "count", "description", "id", "orderId" FROM "OrderProduct";
DROP TABLE "OrderProduct";
ALTER TABLE "new_OrderProduct" RENAME TO "OrderProduct";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
