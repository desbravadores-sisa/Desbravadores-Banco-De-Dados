-- Garante leitura correta dos acentos em qualquer cliente MySQL
SET NAMES utf8mb4;

-- Migração incremental: permite à Diretoria ajustar os pontos ao aprovar uma evidência.
-- Depois de aplicar, reexecute 'SQL - Views.sql' para atualizar vw_resumo_unidades.
ALTER TABLE Unidade_Tarefa ADD COLUMN pontuacao_concedida INT NULL AFTER data_conclusao;
