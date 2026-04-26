 -- Criação do Banco 
 -- Reset no banco descomentar essa linha()
DROP DATABASE IF EXISTS desbravadores;
CREATE DATABASE IF NOT EXISTS desbravadores;
USE desbravadores;

/*
Criação das Tabelas
*/

CREATE TABLE Clube(
id_clube INT PRIMARY KEY AUTO_INCREMENT,

nome VARCHAR(100) NOT NULL,

regiao VARCHAR(100),

cidade VARCHAR(100)
)AUTO_INCREMENT = 10000;

CREATE TABLE Unidade(
id_unidade INT AUTO_INCREMENT,

id_clube INT,

CONSTRAINT pkCompostaUnidade PRIMARY KEY(id_unidade, id_clube),

nome VARCHAR(100),

pontuacao INT,

CONSTRAINT fkUnidadeClube FOREIGN KEY (id_clube) REFERENCES Clube(id_clube)
)AUTO_INCREMENT = 1000;

CREATE TABLE Convite(
id_convite INT AUTO_INCREMENT,

id_clube INT,

CONSTRAINT pkCompostaConvite PRIMARY KEY(id_convite,id_clube),

email VARCHAR(100),

token CHAR(64),

tipo_conta VARCHAR(45),
CONSTRAINT chkTipoContaConvite CHECK (tipo_conta in('DIRETOR','CONSELHEIRO')),

data_expiracao DATE,

status_convite VARCHAR(45),
CONSTRAINT chkStatusConvite CHECK (status_convite in('expirado','aceito','revogado','pendente')),

CONSTRAINT fkConviteClube FOREIGN KEY (id_clube) REFERENCES Clube(id_clube)
)AUTO_INCREMENT = 10;

CREATE TABLE Usuario(
id_usuario INT AUTO_INCREMENT,

id_clube INT,

CONSTRAINT pkCompostaUsuario PRIMARY KEY(id_usuario,id_clube),

id_unidade INT,

nome VARCHAR(100),

email VARCHAR(100),

senha VARCHAR(256),

tipo_conta VARCHAR(45),
CONSTRAINT chkTipoContaUsuario CHECK (tipo_conta in('diretor','conselheiro')),

CONSTRAINT fkUsuarioUnidade FOREIGN KEY (id_unidade, id_clube) REFERENCES Unidade(id_unidade, id_clube)
)AUTO_INCREMENT = 12873;

CREATE TABLE Tarefa(
id_tarefa INT AUTO_INCREMENT,

id_clube INT,

CONSTRAINT pkCompostaTarefa PRIMARY KEY(id_tarefa,id_clube),

nome VARCHAR(100),

descricao TEXT,

pontuacao INT,

prazo_entrega DATE,

data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fkTarefaClube FOREIGN KEY (id_clube) REFERENCES Clube(id_clube)
)AUTO_INCREMENT = 1234;

CREATE TABLE TarefaUnidade(
id_tarefa_unidade INT AUTO_INCREMENT,

id_tarefa INT,

id_unidade INT,

CONSTRAINT pkCompostaTarefaUnidade PRIMARY KEY(id_tarefa_unidade,id_tarefa,id_unidade),

id_clube_tarefa INT,

id_clube_unidade INT,

status_kanban VARCHAR(45),
CONSTRAINT chkTarefaUnidade CHECK(status_kanban in('a fazer','em andamento','em revisao','concluido')),

CONSTRAINT fkTarefaUnidadeTarefa FOREIGN KEY (id_tarefa,id_clube_tarefa) REFERENCES Tarefa(id_tarefa,id_clube),
CONSTRAINT fkTarefaUnidadeUnidade FOREIGN KEY (id_unidade,id_clube_unidade) REFERENCES Unidade(id_unidade,id_clube)
)AUTO_INCREMENT = 1273;

CREATE TABLE Evidencia(
id_evidencia INT AUTO_INCREMENT,

id_tarefa_unidade INT,

CONSTRAINT pkCompostaEvidencia PRIMARY KEY(id_evidencia,id_tarefa_unidade),

id_tarefa INT,

id_unidade INT,

id_clube INT,

nome VARCHAR(100),

urls3 TEXT,

data_upload DATETIME DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fkEvidenciaTarefaUnidade FOREIGN KEY (id_tarefa_unidade, id_tarefa, id_unidade) REFERENCES TarefaUnidade(id_tarefa_unidade, id_tarefa, id_unidade)
)AUTO_INCREMENT = 1876273;


DROP USER IF EXISTS jpauser;
CREATE USER 'jpauser'@'%' IDENTIFIED BY 'senha-segura123';
GRANT INSERT,SELECT,UPDATE,DELETE ON desbravadores.* TO 'jpauser'@'%';
FLUSH PRIVILEGES; 