-- CreateEnum
CREATE TYPE "Combustivel" AS ENUM ('g', 'a', 'd', 'e', 'h', 'f');

-- CreateEnum
CREATE TYPE "Cambio" AS ENUM ('m', 'a', 'e');

-- CreateEnum
CREATE TYPE "Tipo" AS ENUM ('adm', 'com');

-- CreateTable
CREATE TABLE "Marca" (
    "id" VARCHAR(20) NOT NULL,

    CONSTRAINT "Marca_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Modelo" (
    "nome" VARCHAR(20) NOT NULL,
    "ano" INTEGER NOT NULL,
    "versao" VARCHAR(20) NOT NULL,
    "combustivel" "Combustivel" NOT NULL,
    "cambio" "Cambio" NOT NULL,
    "qtd_lugares" INTEGER NOT NULL,
    "cv" INTEGER NOT NULL,
    "cc" INTEGER NOT NULL,
    "portas" INTEGER,
    "id_marca" TEXT NOT NULL,

    CONSTRAINT "Modelo_pkey" PRIMARY KEY ("nome")
);

-- CreateTable
CREATE TABLE "Acessorios" (
    "descricao" VARCHAR(100) NOT NULL,

    CONSTRAINT "Acessorios_pkey" PRIMARY KEY ("descricao")
);

-- CreateTable
CREATE TABLE "AceVeiculo" (
    "id_Acessorio" TEXT NOT NULL,
    "id_Veiculo" INTEGER NOT NULL,

    CONSTRAINT "AceVeiculo_pkey" PRIMARY KEY ("id_Acessorio","id_Veiculo")
);

-- CreateTable
CREATE TABLE "Veiculo" (
    "id" SERIAL NOT NULL,
    "placa" VARCHAR(7) NOT NULL,
    "km" INTEGER NOT NULL,
    "gnv" BOOLEAN NOT NULL,
    "cor" VARCHAR(20) NOT NULL,
    "novo" BOOLEAN NOT NULL,
    "id_modelo" VARCHAR(20) NOT NULL,

    CONSTRAINT "Veiculo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FotoVeiculo" (
    "link" TEXT NOT NULL,
    "id_veiculo" INTEGER NOT NULL,

    CONSTRAINT "FotoVeiculo_pkey" PRIMARY KEY ("link")
);

-- CreateTable
CREATE TABLE "Estado" (
    "uf" VARCHAR(2) NOT NULL,
    "nome" VARCHAR(30) NOT NULL,

    CONSTRAINT "Estado_pkey" PRIMARY KEY ("uf")
);

-- CreateTable
CREATE TABLE "Cidade" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "id_estado" VARCHAR(2) NOT NULL,

    CONSTRAINT "Cidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Usuario" (
    "cpf" VARCHAR(11) NOT NULL,
    "nome" VARCHAR(50) NOT NULL,
    "tipo" "Tipo" NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "senha" VARCHAR(100) NOT NULL,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("cpf")
);

-- CreateTable
CREATE TABLE "Anuncio" (
    "id_veiculo" INTEGER NOT NULL,
    "id_usuario" TEXT NOT NULL,
    "id_cidade" INTEGER NOT NULL,
    "descricao" TEXT NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,
    "dt_criacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "aprovado" BOOLEAN NOT NULL DEFAULT false,
    "telefone_ddd" TEXT NOT NULL,
    "telefone_numero" TEXT NOT NULL,

    CONSTRAINT "Anuncio_pkey" PRIMARY KEY ("id_veiculo","id_cidade","id_usuario")
);

-- CreateTable
CREATE TABLE "InteresseCompra" (
    "id_veiculo" INTEGER NOT NULL,
    "cpf_comprador" VARCHAR(11) NOT NULL,

    CONSTRAINT "InteresseCompra_pkey" PRIMARY KEY ("id_veiculo","cpf_comprador")
);

-- CreateTable
CREATE TABLE "Telefone" (
    "ddd" VARCHAR(2) NOT NULL,
    "numero" VARCHAR(9) NOT NULL,
    "veiculo_id" INTEGER NOT NULL,

    CONSTRAINT "Telefone_pkey" PRIMARY KEY ("ddd","numero")
);

-- CreateIndex
CREATE UNIQUE INDEX "Modelo_id_marca_key" ON "Modelo"("id_marca");

-- CreateIndex
CREATE UNIQUE INDEX "Anuncio_id_veiculo_key" ON "Anuncio"("id_veiculo");

-- CreateIndex
CREATE UNIQUE INDEX "Anuncio_id_usuario_key" ON "Anuncio"("id_usuario");

-- CreateIndex
CREATE UNIQUE INDEX "Anuncio_id_cidade_key" ON "Anuncio"("id_cidade");

-- CreateIndex
CREATE UNIQUE INDEX "Anuncio_telefone_ddd_key" ON "Anuncio"("telefone_ddd");

-- CreateIndex
CREATE UNIQUE INDEX "Anuncio_telefone_numero_key" ON "Anuncio"("telefone_numero");

-- CreateIndex
CREATE UNIQUE INDEX "Telefone_veiculo_id_key" ON "Telefone"("veiculo_id");

-- AddForeignKey
ALTER TABLE "Modelo" ADD CONSTRAINT "Modelo_id_marca_fkey" FOREIGN KEY ("id_marca") REFERENCES "Marca"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AceVeiculo" ADD CONSTRAINT "AceVeiculo_id_Acessorio_fkey" FOREIGN KEY ("id_Acessorio") REFERENCES "Acessorios"("descricao") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AceVeiculo" ADD CONSTRAINT "AceVeiculo_id_Veiculo_fkey" FOREIGN KEY ("id_Veiculo") REFERENCES "Veiculo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Veiculo" ADD CONSTRAINT "Veiculo_id_modelo_fkey" FOREIGN KEY ("id_modelo") REFERENCES "Modelo"("nome") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FotoVeiculo" ADD CONSTRAINT "FotoVeiculo_id_veiculo_fkey" FOREIGN KEY ("id_veiculo") REFERENCES "Veiculo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cidade" ADD CONSTRAINT "Cidade_id_estado_fkey" FOREIGN KEY ("id_estado") REFERENCES "Estado"("uf") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Anuncio" ADD CONSTRAINT "Anuncio_id_veiculo_fkey" FOREIGN KEY ("id_veiculo") REFERENCES "Veiculo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Anuncio" ADD CONSTRAINT "Anuncio_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("cpf") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Anuncio" ADD CONSTRAINT "Anuncio_id_cidade_fkey" FOREIGN KEY ("id_cidade") REFERENCES "Cidade"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Anuncio" ADD CONSTRAINT "Anuncio_telefone_ddd_telefone_numero_fkey" FOREIGN KEY ("telefone_ddd", "telefone_numero") REFERENCES "Telefone"("ddd", "numero") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InteresseCompra" ADD CONSTRAINT "InteresseCompra_id_veiculo_fkey" FOREIGN KEY ("id_veiculo") REFERENCES "Anuncio"("id_veiculo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InteresseCompra" ADD CONSTRAINT "InteresseCompra_cpf_comprador_fkey" FOREIGN KEY ("cpf_comprador") REFERENCES "Usuario"("cpf") ON DELETE RESTRICT ON UPDATE CASCADE;
