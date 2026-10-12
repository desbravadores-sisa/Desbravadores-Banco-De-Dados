-- Garante leitura correta dos acentos em qualquer cliente MySQL
SET NAMES utf8mb4;

-- Migração incremental para bancos criados antes da coluna telefone.
-- Necessária porque a API usa spring.jpa.hibernate.ddl-auto=none e a entidade Usuario mapeia 'telefone'.
ALTER TABLE Usuario ADD COLUMN telefone VARCHAR(20) NULL AFTER senha;
