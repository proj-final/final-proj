/*
  Warnings:

  - You are about to drop the column `createdAt` on the `DeliveryBoy` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `DeliveryBoy` table. All the data in the column will be lost.
  - You are about to drop the column `rating` on the `DeliveryBoy` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `DeliveryBoy` table. All the data in the column will be lost.
  - You are about to drop the `Chef` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DeliveryBoyReservation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Reservation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `bio` to the `DeliveryBoy` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Chef" DROP CONSTRAINT "Chef_userId_fkey";

-- DropForeignKey
ALTER TABLE "DeliveryBoyReservation" DROP CONSTRAINT "DeliveryBoyReservation_deliveryBoyId_fkey";

-- DropForeignKey
ALTER TABLE "DeliveryBoyReservation" DROP CONSTRAINT "DeliveryBoyReservation_reservationId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_chefId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_userId_fkey";

-- DropForeignKey
ALTER TABLE "Reservation" DROP CONSTRAINT "Reservation_userId_fkey";

-- AlterTable
ALTER TABLE "DeliveryBoy" DROP COLUMN "createdAt",
DROP COLUMN "image",
DROP COLUMN "rating",
DROP COLUMN "updatedAt",
ADD COLUMN     "bio" TEXT NOT NULL,
ADD COLUMN     "imageUrl" TEXT;

-- DropTable
DROP TABLE "Chef";

-- DropTable
DROP TABLE "DeliveryBoyReservation";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "Reservation";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Client" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "imageUrl" TEXT,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Chife" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "imageUrl" TEXT,

    CONSTRAINT "Chife_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dish" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "imageUrl" TEXT,
    "ChifeId" INTEGER NOT NULL,
    "ingredientsId" INTEGER NOT NULL,

    CONSTRAINT "Dish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ingredients" (
    "id" SERIAL NOT NULL,
    "ingredient" TEXT NOT NULL,
    "ingredientPrice" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ingredients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cart" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,

    CONSTRAINT "Cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CartItem" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "cartId" INTEGER NOT NULL,
    "dishId" INTEGER NOT NULL,

    CONSTRAINT "CartItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "totalAmount" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,
    "clientId" INTEGER NOT NULL,
    "ChifeId" INTEGER NOT NULL,
    "deliveryBoyId" INTEGER,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DishRating" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "dishId" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,

    CONSTRAINT "DishRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Client_email_key" ON "Client"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Chife_email_key" ON "Chife"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- AddForeignKey
ALTER TABLE "Dish" ADD CONSTRAINT "Dish_ChifeId_fkey" FOREIGN KEY ("ChifeId") REFERENCES "Chife"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dish" ADD CONSTRAINT "Dish_ingredientsId_fkey" FOREIGN KEY ("ingredientsId") REFERENCES "Ingredients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cart" ADD CONSTRAINT "Cart_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "Dish"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_ChifeId_fkey" FOREIGN KEY ("ChifeId") REFERENCES "Chife"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_deliveryBoyId_fkey" FOREIGN KEY ("deliveryBoyId") REFERENCES "DeliveryBoy"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DishRating" ADD CONSTRAINT "DishRating_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DishRating" ADD CONSTRAINT "DishRating_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "Dish"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
