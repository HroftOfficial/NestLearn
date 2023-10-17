-- CreateEnum
CREATE TYPE "BlockItemType" AS ENUM ('website', 'keyWord');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "salt" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" SERIAL NOT NULL,
    "ownerId" INTEGER NOT NULL,
    "isBlockingEnabled" BOOLEAN NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Blocklist" (
    "id" SERIAL NOT NULL,
    "ownerId" INTEGER NOT NULL,

    CONSTRAINT "Blocklist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BlockItem" (
    "id" SERIAL NOT NULL,
    "blockListId" INTEGER NOT NULL,
    "type" "BlockItemType" NOT NULL,
    "data" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BlockItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Account_ownerId_key" ON "Account"("ownerId");

-- CreateIndex
CREATE UNIQUE INDEX "Blocklist_ownerId_key" ON "Blocklist"("ownerId");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Blocklist" ADD CONSTRAINT "Blocklist_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlockItem" ADD CONSTRAINT "BlockItem_blockListId_fkey" FOREIGN KEY ("blockListId") REFERENCES "Blocklist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
