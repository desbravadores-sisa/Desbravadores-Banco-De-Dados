-- ==============================================================================
-- RESET E CRIAÇÃO DO BANCO
-- ==============================================================================
DROP DATABASE IF EXISTS clube_desbravadores;
CREATE DATABASE clube_desbravadores CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE clube_desbravadores;

-- ==============================================================================
-- 1. ESTRUTURA BASE E CICLO ANUAL
-- ==============================================================================
CREATE TABLE Clube (
  id_clube INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  regiao VARCHAR(100),
  cidade VARCHAR(100),
  data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Ciclo (
  id_ciclo INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  nome VARCHAR(45) NOT NULL, 
  data_inicio DATE,
  data_fim DATE,
  ativo BOOLEAN DEFAULT TRUE,
  
  CONSTRAINT fk_Ciclo_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube)
);

CREATE TABLE Perfil (
  id_perfil INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL UNIQUE, -- Ex: 'DIRETORIA', 'CONSELHEIRO'
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

-- ==============================================================================
-- 2. PESSOAS (ACESSO E ALVOS DE NEGÓCIO)
-- ==============================================================================
CREATE TABLE Usuario (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  id_perfil INT NOT NULL,
  id_unidade INT, 
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(256) NOT NULL,
  ativo BOOLEAN DEFAULT TRUE,
  
  CONSTRAINT fk_Usuario_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube),
  CONSTRAINT fk_Usuario_Perfil FOREIGN KEY (id_perfil) REFERENCES Perfil (id_perfil),
  CONSTRAINT fk_Usuario_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade)
);

CREATE TABLE Convite (
  id_convite INT PRIMARY KEY AUTO_INCREMENT,
  id_clube INT NOT NULL,
  id_perfil INT NOT NULL,  
  id_unidade INT,         
  
  email VARCHAR(100) NOT NULL,
  token VARCHAR(128) NOT NULL UNIQUE, 
  status_convite VARCHAR(20) DEFAULT 'PENDENTE',
  data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  data_expiracao DATETIME NOT NULL,
  
  CONSTRAINT chk_Status_Convite CHECK (status_convite IN ('PENDENTE', 'ACEITO', 'REVOGADO', 'EXPIRADO')),
  CONSTRAINT fk_Convite_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube),
  CONSTRAINT fk_Convite_Perfil FOREIGN KEY (id_perfil) REFERENCES Perfil (id_perfil),
  CONSTRAINT fk_Convite_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade)
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

-- ==============================================================================
-- 3. CATÁLOGO (MOLDES DE ATIVIDADES)
-- ==============================================================================
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
  id_caderno INT, -- NULL se for tarefa de Clube
  titulo VARCHAR(150) NOT NULL,
  descricao TEXT,
  tipo_tarefa VARCHAR(20) NOT NULL, -- 'CLUBE' ou 'CADERNO'
  pontuacao INT DEFAULT 0,
  prazo_padrao DATE,
  
  CONSTRAINT chk_Tipo_Tarefa CHECK (tipo_tarefa IN ('CLUBE', 'CADERNO')),
  CONSTRAINT fk_Tarefa_Clube FOREIGN KEY (id_clube) REFERENCES Clube (id_clube),
  CONSTRAINT fk_Tarefa_Caderno FOREIGN KEY (id_caderno) REFERENCES Caderno (id_caderno)
);

-- ==============================================================================
-- 4. EXECUÇÃO TAREFAS DE CLUBE (COM EVIDÊNCIA)
-- ==============================================================================
CREATE TABLE Unidade_Tarefa (
  id_unidade_tarefa INT PRIMARY KEY AUTO_INCREMENT,
  id_unidade INT NOT NULL,
  id_tarefa INT NOT NULL,
  id_ciclo INT NOT NULL, 
  
  status_kanban VARCHAR(45) DEFAULT 'A FAZER',
  prazo_entrega DATETIME,
  data_conclusao DATETIME,
  
  CONSTRAINT chk_Status_Unidade CHECK (status_kanban IN ('A FAZER', 'EM ANDAMENTO', 'EM REVISAO', 'CONCLUIDA')),
  CONSTRAINT fk_UniTarefa_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade),
  CONSTRAINT fk_UniTarefa_Tarefa FOREIGN KEY (id_tarefa) REFERENCES Tarefa (id_tarefa),
  CONSTRAINT fk_UniTarefa_Ciclo FOREIGN KEY (id_ciclo) REFERENCES Ciclo (id_ciclo)
);

CREATE TABLE Evidencia (
  id_evidencia INT PRIMARY KEY AUTO_INCREMENT,
  id_unidade_tarefa INT NOT NULL, -- Evidência fotográfica/documental restrita às tarefas de Clube
  
  url_s3 VARCHAR(500) NOT NULL,
  comentario_feedback TEXT,
  data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT fk_Evidencia_UniTarefa FOREIGN KEY (id_unidade_tarefa) REFERENCES Unidade_Tarefa (id_unidade_tarefa)
);

-- ==============================================================================
-- 5. EXECUÇÃO TAREFAS DE CADERNO (AGRUPADO MESTRE-DETALHE)
-- ==============================================================================
-- O Cartão Agrupado no Kanban (Mestre)
CREATE TABLE Execucao_Caderno (
  id_execucao_caderno INT PRIMARY KEY AUTO_INCREMENT,
  id_unidade INT NOT NULL,
  id_tarefa INT NOT NULL,
  id_ciclo INT NOT NULL, 
  
  status_kanban VARCHAR(45) DEFAULT 'A FAZER',
  data_conclusao DATETIME,
  
  CONSTRAINT chk_Status_Execucao CHECK (status_kanban IN ('A FAZER', 'EM ANDAMENTO', 'EM REVISAO', 'CONCLUIDA')),
  CONSTRAINT fk_ExecCaderno_Unidade FOREIGN KEY (id_unidade) REFERENCES Unidade (id_unidade),
  CONSTRAINT fk_ExecCaderno_Tarefa FOREIGN KEY (id_tarefa) REFERENCES Tarefa (id_tarefa),
  CONSTRAINT fk_ExecCaderno_Ciclo FOREIGN KEY (id_ciclo) REFERENCES Ciclo (id_ciclo)
);

-- O Checklist individual das Crianças dentro do Cartão (Detalhe)
CREATE TABLE Checklist_Caderno (
  id_checklist INT PRIMARY KEY AUTO_INCREMENT,
  id_execucao_caderno INT NOT NULL, 
  id_desbravador INT NOT NULL,
  
  concluiu_tarefa BOOLEAN DEFAULT FALSE, 
  data_marcacao DATETIME, 
  
  CONSTRAINT fk_Checklist_ExecCaderno FOREIGN KEY (id_execucao_caderno) REFERENCES Execucao_Caderno (id_execucao_caderno),
  CONSTRAINT fk_Checklist_Desbravador FOREIGN KEY (id_desbravador) REFERENCES Desbravador (id_desbravador)
);

-- ==============================================================================
-- CONFIGURAÇÃO DE USUÁRIO DO BANCO DE DADOS
-- ==============================================================================
DROP USER IF EXISTS jpauser;
CREATE USER 'jpauser'@'%' IDENTIFIED BY 'senha-segura123';
GRANT INSERT, SELECT, UPDATE, DELETE ON clube_desbravadores.* TO 'jpauser'@'%';
FLUSH PRIVILEGES;