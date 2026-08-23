-- Reset limpo
DROP DATABASE IF EXISTS clube_desbravadores;
CREATE DATABASE clube_desbravadores CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE clube_desbravadores;

-- -----------------------------------------------------
-- 1. Tabelas Base
-- -----------------------------------------------------
CREATE TABLE Clube (
  id_clube INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  regiao VARCHAR(100),
  cidade VARCHAR(100),
  data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Perfil (
  id_perfil INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL UNIQUE,
  descricao VARCHAR(100)
);

CREATE TABLE Unidade (
  id_unidade INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  genero VARCHAR(45),
  idade_minima INT,
  idade_maxima INT,
  
  CONSTRAINT fk_Unidade_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube)
);

-- -----------------------------------------------------
-- 2. Pessoas (Usuários e Desbravadores)
-- -----------------------------------------------------
CREATE TABLE Usuario (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  id_perfil INT NOT NULL,
  id_unidade INT, -- Pode ser NULL se for Diretoria
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(256) NOT NULL,
  ativo BOOLEAN DEFAULT TRUE,
  
  CONSTRAINT fk_Usuario_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube),
  CONSTRAINT fk_Usuario_Perfil FOREIGN KEY (id_perfil) REFERENCES Perfil (id_perfil),
  CONSTRAINT fk_Usuario_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade)
);

CREATE TABLE Desbravador (
  id_desbravador INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  id_unidade INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  data_nascimento DATE NOT NULL,
  genero VARCHAR(45),
  data_admissao DATETIME DEFAULT CURRENT_TIMESTAMP,
  ativo BOOLEAN DEFAULT TRUE,
  
  CONSTRAINT fk_Desbravador_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube),
  CONSTRAINT fk_Desbravador_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade)
);

-- -----------------------------------------------------
-- 3. Catálogo (Cadernos e Tarefas)
-- -----------------------------------------------------
CREATE TABLE Caderno (
  id_caderno INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  idade_alvo INT NOT NULL,
  
  CONSTRAINT fk_Caderno_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube)
);

CREATE TABLE Tarefa (
  id_tarefa INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  id_caderno INT, -- Se for NULL, é tarefa do Clube. Se tiver ID, é de Caderno.
  titulo VARCHAR(150) NOT NULL,
  descricao TEXT,
  tipo_tarefa VARCHAR(20) NOT NULL, -- 'CLUBE' ou 'CADERNO'
  pontuacao INT DEFAULT 0,
  prazo_padrao DATE,
  
  CONSTRAINT chk_Tipo_Tarefa CHECK (tipo_tarefa IN ('CLUBE', 'CADERNO')),
  CONSTRAINT fk_Tarefa_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube),
  CONSTRAINT fk_Tarefa_Caderno FOREIGN KEY (id_caderno) REFERENCES Caderno (id_caderno)
);

-- -----------------------------------------------------
-- 4. Execução (O Kanban)
-- -----------------------------------------------------
-- Kanban individual para os Cadernos
CREATE TABLE Desbravador_Tarefa (
  id_desbravador_tarefa INT PRIMARY KEY AUTO_INCREMENT,
  id_desbravador INT NOT NULL,
  id_tarefa INT NOT NULL,
  status_kanban VARCHAR(45) DEFAULT 'A FAZER',
  prazo_entrega DATETIME,
  data_conclusao DATETIME,
  
  CONSTRAINT chk_Status_Desbravador CHECK (status_kanban IN ('A FAZER', 'EM ANDAMENTO', 'EM REVISAO', 'CONCLUIDA')),
  CONSTRAINT fk_DesbTarefa_Desbravador FOREIGN KEY (id_desbravador) REFERENCES Desbravador (id_desbravador),
  CONSTRAINT fk_DesbTarefa_Tarefa FOREIGN KEY (id_tarefa) REFERENCES Tarefa (id_tarefa)
);

-- Kanban em grupo para as Tarefas do Clube
CREATE TABLE Unidade_Tarefa (
  id_unidade_tarefa INT PRIMARY KEY AUTO_INCREMENT,
  id_unidade INT NOT NULL,
  id_tarefa INT NOT NULL,
  status_kanban VARCHAR(45) DEFAULT 'A FAZER',
  prazo_entrega DATETIME,
  data_conclusao DATETIME,
  
  CONSTRAINT chk_Status_Unidade CHECK (status_kanban IN ('A FAZER', 'EM ANDAMENTO', 'EM REVISAO', 'CONCLUIDA')),
  CONSTRAINT fk_UniTarefa_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade),
  CONSTRAINT fk_UniTarefa_Tarefa FOREIGN KEY (id_tarefa) REFERENCES Tarefa (id_tarefa)
);

-- -----------------------------------------------------
-- 5. Evidências
-- -----------------------------------------------------
CREATE TABLE Evidencia (
  id_evidencia INT PRIMARY KEY AUTO_INCREMENT,
  id_desbravador_tarefa INT, -- Preenchido se a evidência for de Caderno
  id_unidade_tarefa INT,     -- Preenchido se a evidência for de Clube
  url_s3 VARCHAR(500) NOT NULL,
  comentario_feedback TEXT,
  data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT fk_Evidencia_DesbTarefa FOREIGN KEY (id_desbravador_tarefa) REFERENCES Desbravador_Tarefa (id_desbravador_tarefa),
  CONSTRAINT fk_Evidencia_UniTarefa FOREIGN KEY (id_unidade_tarefa) REFERENCES Unidade_Tarefa (id_unidade_tarefa),
  
  -- Garante que a evidência pertence a um ou a outro, nunca aos dois ou a nenhum
  CONSTRAINT chk_Evidencia_Origem CHECK (
      (id_desbravador_tarefa IS NOT NULL AND id_unidade_tarefa IS NULL) OR 
      (id_desbravador_tarefa IS NULL AND id_unidade_tarefa IS NOT NULL)
  )
);

DROP USER IF EXISTS jpauser;
CREATE USER 'jpauser'@'%' IDENTIFIED BY 'senha-segura123';
GRANT INSERT, SELECT, UPDATE, DELETE ON clube_desbravadores.* TO 'jpauser'@'%';
FLUSH PRIVILEGES;