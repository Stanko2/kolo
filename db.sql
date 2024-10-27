PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "_prisma_migrations" (
    "id"                    TEXT PRIMARY KEY NOT NULL,
    "checksum"              TEXT NOT NULL,
    "finished_at"           DATETIME,
    "migration_name"        TEXT NOT NULL,
    "logs"                  TEXT,
    "rolled_back_at"        DATETIME,
    "started_at"            DATETIME NOT NULL DEFAULT current_timestamp,
    "applied_steps_count"   INTEGER UNSIGNED NOT NULL DEFAULT 0
);
INSERT INTO _prisma_migrations VALUES('d44ab5b0-8831-452f-89e5-dff42c4c4672','ef7338a32149a3d4eeb4465914350049f29d68d453f9de4c865a90b128a4af18',1729925000799,'20241024104344_init',NULL,NULL,1729925000780,1);
INSERT INTO _prisma_migrations VALUES('1be33617-c433-4811-84c8-f95c8b436f0f','b2b1528fa778712d1d6ce014ac7907d0ed0e4288783a61dd07b17198b6d43b82',1729925000822,'20241024110132_password',NULL,NULL,1729925000801,1);
INSERT INTO _prisma_migrations VALUES('85aa9bef-3f67-4054-b9bc-cc89efb85575','45eb01d376b5679b96667ddef29324fc881d11bd2e1c555e9e7321dbff021ee4',1729925000883,'20241026064206_initial',NULL,NULL,1729925000825,1);
INSERT INTO _prisma_migrations VALUES('516574f1-b54d-440b-972a-6c26edfe6b78','fd15b142aada45b1910cf1c33eaef9d92eb3f6ffef64ca64cd62d9e406540e5c',1729925005049,'20241026064325_initial',NULL,NULL,1729925005027,1);
INSERT INTO _prisma_migrations VALUES('ceec08bc-68b6-4dda-ad5b-2c91dde3caad','40a9b89327a167919a065d59f4b46b12f94f8d03c11a4a70fa96395a06d62f12',1729926881450,'20241026071441_dev',NULL,NULL,1729926881418,1);
INSERT INTO _prisma_migrations VALUES('7b5b156e-1d7c-4425-86c2-f374dca2455e','ac23b629c6f9a45851348b022f2fe80219f2552a12eb3541e2f1fa92141c6583',1729931045045,'20241026082405_add_email',NULL,NULL,1729931045028,1);
INSERT INTO _prisma_migrations VALUES('67d2985f-4603-4d88-83bb-83b7cba20a5c','b952837861f573dc87b335818adba39e326faa498b6afd360b0100f36d4ea22c',1729936889281,'20241026100129_add_invited',NULL,NULL,1729936889263,1);
INSERT INTO _prisma_migrations VALUES('88f4ff0d-3dfc-42d6-83f7-25367d9b4dbb','5b2aaab47e4bc3d1d25e2f861f23c0077e13f811897cf4f5444fca73e50e2097',1729961262836,'20241026164742_add_description',NULL,NULL,1729961262824,1);
INSERT INTO _prisma_migrations VALUES('6c532f60-6840-4789-bfe9-35da04b0e97c','f2e2eb3bb9ef6e0b1d4c6bd0e9e9c6428e4a4a8b50135c2652fcfcca02355304',1729971343050,'20241026193543_add_product',NULL,NULL,1729971343022,1);
INSERT INTO _prisma_migrations VALUES('165debfb-28aa-4429-89e4-0444eb5543a8','070d954223e45317379da7226a0ef76235ecde0908d00312882abe9fbb6a47a1',1729972135579,'20241026194855_contract_optional',NULL,NULL,1729972135538,1);
CREATE TABLE IF NOT EXISTS "WatchedProduct" (
    "organizationId" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,

    PRIMARY KEY ("organizationId", "productId"),
    CONSTRAINT "WatchedProduct_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "WatchedProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "InterestedProduct" (
    "organizationId" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,

    PRIMARY KEY ("organizationId", "productId"),
    CONSTRAINT "InterestedProduct_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "InterestedProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO InterestedProduct VALUES(2,1);
INSERT INTO InterestedProduct VALUES(2,7);
INSERT INTO InterestedProduct VALUES(2,11);
CREATE TABLE IF NOT EXISTS "Category" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);
INSERT INTO Category VALUES(1,'Furniture');
INSERT INTO Category VALUES(2,'Household Goods');
INSERT INTO Category VALUES(3,'Garden');
INSERT INTO Category VALUES(4,'Kids');
INSERT INTO Category VALUES(5,'Sports Equipment');
INSERT INTO Category VALUES(6,'Pet Supplies');
INSERT INTO Category VALUES(7,'Books, CDs, DVD''s, Records');
INSERT INTO Category VALUES(8,'Bags');
CREATE TABLE IF NOT EXISTS "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL DEFAULT 'password',
    "name" TEXT,
    "admin" BOOLEAN NOT NULL DEFAULT false,
    "organization_id" INTEGER
);
INSERT INTO User VALUES(18,'test@test.com','$2b$10$xj/flRFykRwnwXgSU5xVQOSPqLwEmlRwK8yL5Ixiz3X1d4M0q9qe.','admin',1,2);
CREATE TABLE IF NOT EXISTS "Organization" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "ICO" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "invited" BOOLEAN NOT NULL DEFAULT false,
    "userId" INTEGER,
    "emailToken" TEXT NOT NULL,
    "email" TEXT NOT NULL DEFAULT '',
    CONSTRAINT "Organization_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("organization_id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO Organization VALUES(2,'Test','5843095823908','fjaoig erihio','jfoiasjioreoi',0,0,2,'87cd56a6-21bf-4eb4-a58a-07f0fd27a189','test@test.com');
INSERT INTO Organization VALUES(3,'user1','a','','',1,0,NULL,'5345ad67-45e2-444e-9e40-4a6e7420dd55','webnodesk3@gmail.com');
INSERT INTO Organization VALUES(4,'user2','b','','',1,0,NULL,'d97eacc1-8011-4cfb-b0ba-77e86b442625','pritrskypatrik@gmail.com');
CREATE TABLE IF NOT EXISTS "Product" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "count" INTEGER NOT NULL,
    "weight" REAL NOT NULL,
    "categoryId" INTEGER NOT NULL,
    CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO Product VALUES(1,'Big Table','Dining or office table.',3,0.0,1);
INSERT INTO Product VALUES(2,'Chair','Seating furniture without upholstery. ',25,0.0,1);
INSERT INTO Product VALUES(3,'Bookshelf','Storage unit for books or decorative items.',1,0.0,1);
INSERT INTO Product VALUES(4,'Dresser','A chest with drawers for storing clothes.',4,0.0,1);
INSERT INTO Product VALUES(5,'Small Table','Small table for living room or bedside use. ',30,0.0,1);
INSERT INTO Product VALUES(6,'Armchair','Comfortable, upholstered chair.',10,0.0,1);
INSERT INTO Product VALUES(7,'Large Bed','Bed for adults. ',2,0.0,1);
INSERT INTO Product VALUES(8,'Sofa Set','Complete set for seating.',1,0.0,1);
INSERT INTO Product VALUES(9,'Other Furniture','Miscellaneous furniture items. Example: Storage ottoman or TV stand.',50,0.0,1);
INSERT INTO Product VALUES(10,'Small Bed','Bed for kids.',5,0.0,1);
INSERT INTO Product VALUES(11,'Wardrobe','Large cabinet for clothes storage. ',3,0.0,1);
INSERT INTO Product VALUES(12,'Small Glass','Glass containers or drinkware. Example: Small drinking glasses.',2990,0.0,2);
INSERT INTO Product VALUES(13,'Large Glass','Large glass items or containers. Example: Glass vases or serving bowls.',412,0.0,2);
INSERT INTO Product VALUES(14,'Small Plastic','	Plastic containers or tools. Example: Small food storage containers.',751,0.0,2);
INSERT INTO Product VALUES(15,'Large Plastic','Larger plastic items for household use. Example: Laundry basket.',158,0.0,2);
INSERT INTO Product VALUES(16,'Small Wood','Small wooden household items. Example: Spattula.',154,0.0,2);
INSERT INTO Product VALUES(17,'Large Wood','Larger wooden household items. Example: Wooden storage box.',42,0.0,2);
INSERT INTO Product VALUES(18,'Small Stainless Steel','Small metal items or tools. Example: Stainless steel cutlery.',1005,0.0,2);
INSERT INTO Product VALUES(19,'Large Stainless Steel','Large stainless steel items. Example: Stainless steel pots or trays.',451,0.0,2);
INSERT INTO Product VALUES(20,'Small Ceramic','	Small ceramic items. Example: Coffee mugs or small plates.',1845,0.0,2);
INSERT INTO Product VALUES(21,'Large Ceramic','Large ceramic items. Example: Serving platters or decorative bowls.',201,0.0,2);
INSERT INTO Product VALUES(22,'Small Decorations','	Small decorative items. Example: Candle holders or figurines.',1691,0.0,2);
INSERT INTO Product VALUES(23,'Large Decorations','Larger decorative items. Example: Wall art or sculptures.',199,0.0,2);
INSERT INTO Product VALUES(24,'Small Garden Appliances','Small gardening tools or accessories. Example: Hand trowels or pruners.',61,0.0,3);
INSERT INTO Product VALUES(25,'Large Garden Appliances','Larger items for gardening. Example: Lawn mower or large planters.',20,0.0,3);
INSERT INTO Product VALUES(26,'Car Seat','Safety seats for children in cars. Example: Infant car seat or booster seat.',27,0.0,4);
INSERT INTO Product VALUES(27,'Stroller','Portable seating for transporting children. Example: Foldable stroller.',13,0.0,4);
INSERT INTO Product VALUES(28,'Small Toys','Small play items for children. Example: Building blocks or dolls.',1475,0.0,4);
INSERT INTO Product VALUES(29,'Large Toys','Large play items. Example: Toy trucks or play kitchens.',256,0.0,4);
INSERT INTO Product VALUES(30,'Other Children''s Items','Miscellaneous children’s products. Example: Baby play mats or high chairs.',199,0.0,4);
INSERT INTO Product VALUES(31,'Small Bicycle','Bicycles for children. Example: Balance bike or kids'' bicycle.',12,0.0,5);
INSERT INTO Product VALUES(32,'Large Bicycle','Bicycles for adults. Example: Mountain bike or road bike.',1,0.0,5);
INSERT INTO Product VALUES(33,'Child Balance Bike','Pedal-free bike for young children. Example: Wooden balance bike.',5,0.0,5);
INSERT INTO Product VALUES(34,'Skis/Cross-Country Skis','Ski equipment for winter sports. Example: Adult cross-country skis.',36,0.0,5);
INSERT INTO Product VALUES(35,'Ski Boots','Boots compatible with skis. Example: Alpine ski boots.',25,0.0,5);
INSERT INTO Product VALUES(36,'Skates','Skating equipment. Example: Inline skates or ice skates.',64,0.0,5);
INSERT INTO Product VALUES(37,'Other Sports Equipment','Various sports items. Example: Basketball or yoga mat.',197,0.0,5);
INSERT INTO Product VALUES(38,'Animal Carrier','Transport carriers for pets. Example: Small pet travel carrier.',2,0.0,6);
INSERT INTO Product VALUES(39,'Aquarium','Glass tanks for fish or reptiles. Example: 20-gallon glass aquarium.',3,0.0,6);
INSERT INTO Product VALUES(40,'Other Pet Supplies','Miscellaneous pet products. Example: Pet beds or scratching posts.',44,0.0,6);
INSERT INTO Product VALUES(41,'Book','Various types of books. Example: Fiction novels or children''s books.',10454,0.0,7);
INSERT INTO Product VALUES(42,'CD','Compact discs for music or media. Example: Music album CDs.',2075,0.0,7);
INSERT INTO Product VALUES(43,'DVD','DVDs for movies or media. Example: Popular movie DVDs.',1079,0.0,7);
INSERT INTO Product VALUES(44,'Vinyl Record','Vinyl records for music playback. Example: Classic rock vinyl records.',483,0.0,7);
INSERT INTO Product VALUES(45,'Bag, Backpack, Handbag','Bags and similar items. Example: Leather handbag or travel backpack.',418,0.0,8);
INSERT INTO Product VALUES(46,'Suitcase','Luggage for travel. Example: Large hard-shell suitcase.',11,0.0,8);
CREATE TABLE IF NOT EXISTS "Contract" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "link" TEXT NOT NULL,
    "orderId" INTEGER NOT NULL,
    CONSTRAINT "Contract_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order" ("Contract_id") ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "OrderProduct" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "productId" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "accepted" BOOLEAN NOT NULL,
    "orderId" INTEGER NOT NULL,
    CONSTRAINT "OrderProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "OrderProduct_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "Order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "organizationId" INTEGER NOT NULL,
    "state" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "pickupPlace" TEXT NOT NULL,
    "Contract_id" INTEGER,
    CONSTRAINT "Order_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('User',18);
INSERT INTO sqlite_sequence VALUES('Category',8);
INSERT INTO sqlite_sequence VALUES('Organization',4);
INSERT INTO sqlite_sequence VALUES('Product',46);
INSERT INTO sqlite_sequence VALUES('Contract',0);
INSERT INTO sqlite_sequence VALUES('OrderProduct',2);
INSERT INTO sqlite_sequence VALUES('Order',1);
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_organization_id_key" ON "User"("organization_id");
CREATE UNIQUE INDEX "Organization_ICO_key" ON "Organization"("ICO");
CREATE UNIQUE INDEX "Organization_userId_key" ON "Organization"("userId");
CREATE UNIQUE INDEX "Organization_emailToken_key" ON "Organization"("emailToken");
CREATE UNIQUE INDEX "Contract_orderId_key" ON "Contract"("orderId");
CREATE UNIQUE INDEX "Order_Contract_id_key" ON "Order"("Contract_id");
COMMIT;
