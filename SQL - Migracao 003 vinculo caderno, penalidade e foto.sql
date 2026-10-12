-- Garante leitura correta dos acentos em qualquer cliente MySQL
SET NAMES utf8mb4;

-- Migração incremental 003 (12/10/2026):
--   * Desbravador_Caderno: vínculo explícito desbravador ↔ caderno + data de conclusão (histórico)
--   * Penalidade: descontos de pontos lançados pela Diretoria (com motivo)
--   * Usuario.foto_url: foto de perfil enviada pela API
-- Depois de aplicar, reexecute 'SQL - Views.sql' (vinculados e pontuação líquida).

-- Vínculo definido pela Diretoria em "Ver Caderno". data_conclusao preenchida quando o
-- desbravador cumpre todos os requisitos do caderno (histórico de "Cadernos concluídos").
CREATE TABLE Desbravador_Caderno (
  id_desbravador_caderno INT PRIMARY KEY AUTO_INCREMENT,
  id_desbravador INT NOT NULL,
  id_caderno INT NOT NULL,
  data_vinculo DATETIME DEFAULT CURRENT_TIMESTAMP,
  data_conclusao DATETIME,

  CONSTRAINT uq_Desbravador_Caderno UNIQUE (id_desbravador, id_caderno),
  CONSTRAINT fk_DesbCaderno_Desbravador FOREIGN KEY (id_desbravador) REFERENCES Desbravador (id_desbravador),
  CONSTRAINT fk_DesbCaderno_Caderno FOREIGN KEY (id_caderno) REFERENCES Caderno (id_caderno)
);

-- Desconto de pontos lançado pela Diretoria (com motivo), descontado no ranking do ciclo.
CREATE TABLE Penalidade (
  id_penalidade INT PRIMARY KEY AUTO_INCREMENT,
  id_unidade INT NOT NULL,
  id_ciclo INT NOT NULL,
  id_usuario INT, -- quem lançou
  pontos INT NOT NULL,
  motivo VARCHAR(255) NOT NULL,
  data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT chk_Penalidade_Pontos CHECK (pontos > 0),
  CONSTRAINT fk_Penalidade_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade),
  CONSTRAINT fk_Penalidade_Ciclo FOREIGN KEY (id_ciclo) REFERENCES Ciclo (id_ciclo),
  CONSTRAINT fk_Penalidade_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario)
);

ALTER TABLE Usuario ADD COLUMN foto_url VARCHAR(500) NULL AFTER telefone;

-- Vínculo inicial desbravador ↔ caderno pela idade (depois a Diretoria ajusta em "Ver Caderno")
INSERT INTO Desbravador_Caderno (id_desbravador, id_caderno)
SELECT d.id_desbravador, c.id_caderno
FROM Desbravador d
JOIN Caderno c ON c.id_clube = d.id_clube
             AND c.idade_alvo = TIMESTAMPDIFF(YEAR, d.data_nascimento, CURDATE())
WHERE d.ativo = TRUE
  AND NOT EXISTS (SELECT 1 FROM Desbravador_Caderno x
                  WHERE x.id_desbravador = d.id_desbravador AND x.id_caderno = c.id_caderno);
