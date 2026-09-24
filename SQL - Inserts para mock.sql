USE clube_desbravadores;

INSERT INTO Perfil(nome,descricao) VALUES
("Diretoria","Perfil administrador do sistema"),
("Conselheiro","Perfil para gestão de tarefas");

INSERT INTO Clube(nome,regiao,cidade) VALUES
("TDM - Tigre da Montanha","Leste","São Paulo");

INSERT INTO Unidade(id_clube,nome,genero,idade_minima,idade_maxima) VALUES
(1,"Tigresas","Feminino",10,12),
(1,"Leões","Masculino",10,12),
(1,"Panteras","Masculino",13,15),
(1,"Onças","Feminino",13,15);

INSERT INTO Ciclo(id_clube,nome,data_inicio,data_fim) VALUES
(1,"Ciclo 2026","2026-01-01","2026-12-31");

INSERT INTO Desbravador (id_clube, id_unidade, nome, data_nascimento, genero) VALUES
-- Unidade 1: Tigresas (Feminino, 10 a 12 anos) - 12 desbravadoras
(1, 1, 'Ana Clara Silva', '2015-04-11', 'Feminino'),
(1, 1, 'Beatriz Souza', '2014-08-22', 'Feminino'),
(1, 1, 'Camila Rodrigues', '2016-01-10', 'Feminino'),
(1, 1, 'Daniela Costa', '2015-11-30', 'Feminino'),
(1, 1, 'Eduarda Almeida', '2014-02-15', 'Feminino'),
(1, 1, 'Fernanda Lima', '2015-07-08', 'Feminino'),
(1, 1, 'Gabriela Martins', '2016-05-20', 'Feminino'),
(1, 1, 'Helena Carvalho', '2014-09-14', 'Feminino'),
(1, 1, 'Isabela Ribeiro', '2015-12-01', 'Feminino'),
(1, 1, 'Julia Ferreira', '2016-03-25', 'Feminino'),
(1, 1, 'Larissa Gomes', '2014-06-19', 'Feminino'),
(1, 1, 'Mariana Alves', '2015-08-11', 'Feminino'),
-- Unidade 2: Leões (Masculino, 10 a 12 anos) - 13 desbravadores
(1, 2, 'Arthur Mendes', '2015-05-18', 'Masculino'),
(1, 2, 'Bernardo Santos', '2014-11-03', 'Masculino'),
(1, 2, 'Caio Pereira', '2016-02-28', 'Masculino'),
(1, 2, 'Davi Lucca', '2015-10-10', 'Masculino'),
(1, 2, 'Enzo Gabriel', '2014-04-05', 'Masculino'),
(1, 2, 'Felipe Rocha', '2015-09-21', 'Masculino'),
(1, 2, 'Gabriel Oliveira', '2016-07-13', 'Masculino'),
(1, 2, 'Heitor Moreira', '2014-12-08', 'Masculino'),
(1, 2, 'Igor Azevedo', '2015-01-17', 'Masculino'),
(1, 2, 'Joao Pedro', '2016-08-04', 'Masculino'),
(1, 2, 'Kauã Silva', '2014-03-29', 'Masculino'),
(1, 2, 'Lucas Fernandes', '2015-06-22', 'Masculino'),
(1, 2, 'Matheus Castro', '2016-11-15', 'Masculino'),
-- Unidade 3: Panteras (Masculino, 13 a 15 anos) - 13 desbravadores
(1, 3, 'Carlos Eduardo', '2012-03-14', 'Masculino'),
(1, 3, 'Daniel Nunes', '2011-07-29', 'Masculino'),
(1, 3, 'Eduardo Pinto', '2013-05-02', 'Masculino'),
(1, 3, 'Fabricio Dias', '2012-10-18', 'Masculino'),
(1, 3, 'Guilherme Melo', '2011-01-25', 'Masculino'),
(1, 3, 'Henrique Vieira', '2013-08-09', 'Masculino'),
(1, 3, 'Ian Cardoso', '2012-12-11', 'Masculino'),
(1, 3, 'Joaquim Nogueira', '2011-04-20', 'Masculino'),
(1, 3, 'Kevin Barbosa', '2013-09-03', 'Masculino'),
(1, 3, 'Leonardo Barros', '2012-02-14', 'Masculino'),
(1, 3, 'Marcelo Farias', '2011-11-27', 'Masculino'),
(1, 3, 'Nicolas Pires', '2013-06-08', 'Masculino'),
(1, 3, 'Otavio Monteiro', '2012-08-30', 'Masculino'),
-- Unidade 4: Onças (Feminino, 13 a 15 anos) - 12 desbravadoras
(1, 4, 'Alice Viana', '2012-09-05', 'Feminino'),
(1, 4, 'Bruna Novaes', '2013-02-18', 'Feminino'),
(1, 4, 'Cecilia Bentes', '2011-08-12', 'Feminino'),
(1, 4, 'Diana Moura', '2012-04-22', 'Feminino'),
(1, 4, 'Ester Campos', '2013-11-07', 'Feminino'),
(1, 4, 'Flavia Gouveia', '2011-05-19', 'Feminino'),
(1, 4, 'Giovanna Peixoto', '2012-10-31', 'Feminino'),
(1, 4, 'Heloisa Sampaio', '2013-01-14', 'Feminino'),
(1, 4, 'Isis Figueiredo', '2011-12-06', 'Feminino'),
(1, 4, 'Juliana Resende', '2012-07-28', 'Feminino'),
(1, 4, 'Karina Lemos', '2013-04-09', 'Feminino'),
(1, 4, 'Leticia Moraes', '2011-03-23', 'Feminino');


INSERT INTO Caderno (id_clube, nome, idade_alvo) VALUES 
(1, 'Amigo', 10),
(1, 'Companheiro', 11),
(1, 'Pesquisador', 12),
(1, 'Pioneiro', 13),
(1, 'Excursionista', 14),
(1, 'Guia', 15);

-- Inserindo Tarefas do Caderno 'Amigo' (ID 1) - 6 Requisitos
INSERT INTO Tarefa (id_clube, id_caderno, titulo, descricao, tipo_tarefa, pontuacao) VALUES
(1, 1, 'Voto e Lei dos Desbravadores', 'Decorar e explicar o significado do Voto e da Lei.', 'CADERNO', 10),
(1, 1, 'Leitura Bíblica: Gênesis', 'Ler o livro de Gênesis conforme o ano bíblico.', 'CADERNO', 15),
(1, 1, 'Especialidade de Acampamento I', 'Completar os requisitos teóricos e práticos.', 'CADERNO', 20),
(1, 1, 'Nós e Amarras Básicas', 'Fazer e explicar o uso de 5 nós básicos.', 'CADERNO', 10),
(1, 1, 'História dos Desbravadores', 'Contar a história de como o clube começou.', 'CADERNO', 10),
(1, 1, 'Preservação da Natureza', 'Participar de um projeto ecológico no bairro.', 'CADERNO', 20);

-- Inserindo Tarefas do Caderno 'Companheiro' (ID 2) - 7 Requisitos
INSERT INTO Tarefa (id_clube, id_caderno, titulo, descricao, tipo_tarefa, pontuacao) VALUES
(1, 2, 'Alvo, Lema e Voto à Bíblia', 'Memorizar e recitar para o conselheiro.', 'CADERNO', 10),
(1, 2, 'Leitura Bíblica: Êxodo', 'Acompanhar a leitura no clube bíblico.', 'CADERNO', 15),
(1, 2, 'Primeiros Socorros Básicos', 'Saber como tratar cortes e queimaduras leves.', 'CADERNO', 20),
(1, 2, 'Culinária de Acampamento', 'Fazer uma fogueira segura e cozinhar uma refeição.', 'CADERNO', 20),
(1, 2, 'Uso de Bússola', 'Aprender a encontrar os pontos cardeais.', 'CADERNO', 15),
(1, 2, 'Participar de Investidura', 'Estar presente na cerimônia de admissão.', 'CADERNO', 10),
(1, 2, 'Projeto Comunitário', 'Arrecadar alimentos ou roupas para doação.', 'CADERNO', 20);

-- Inserindo Tarefas do Caderno 'Pesquisador' (ID 3) - 6 Requisitos
INSERT INTO Tarefa (id_clube, id_caderno, titulo, descricao, tipo_tarefa, pontuacao) VALUES
(1, 3, 'Evangelhos', 'Leitura guiada dos livros de Mateus e Marcos.', 'CADERNO', 15),
(1, 3, 'Especialidade de Mapa e Bússola', 'Concluir a especialidade com prova prática.', 'CADERNO', 25),
(1, 3, 'Acampamento de Fim de Semana', 'Dormir ao menos duas noites em barraca.', 'CADERNO', 30),
(1, 3, 'Estudo sobre a Criação', 'Preparar uma apresentação sobre os 7 dias.', 'CADERNO', 15),
(1, 3, 'Caminhada de 5km', 'Participar de uma caminhada com a unidade.', 'CADERNO', 20),
(1, 3, 'Arte de Acampar', 'Saber montar, desmontar e limpar uma barraca.', 'CADERNO', 15);

-- Inserindo Tarefas do Caderno 'Pioneiro' (ID 4) - 6 Requisitos
INSERT INTO Tarefa (id_clube, id_caderno, titulo, descricao, tipo_tarefa, pontuacao) VALUES
(1, 4, 'Clube de Leitura', 'Ler o livro do ano recomendado pela Divisão.', 'CADERNO', 20),
(1, 4, 'Estudo sobre Temperança', 'Fazer um cartaz sobre os perigos das drogas.', 'CADERNO', 15),
(1, 4, 'Fogueiras e Acampamento', 'Saber construir três tipos diferentes de fogueiras.', 'CADERNO', 20),
(1, 4, 'Orientação Avançada', 'Fazer uma trilha usando apenas bússola e mapa.', 'CADERNO', 25),
(1, 4, 'Pioneirismo', 'Construir um móvel de acampamento usando amarras.', 'CADERNO', 30),
(1, 4, 'Liderança Jovem', 'Ajudar a dirigir um culto ou devocional.', 'CADERNO', 20);

-- Inserindo Tarefas do Caderno 'Excursionista' (ID 5) - 5 Requisitos
INSERT INTO Tarefa (id_clube, id_caderno, titulo, descricao, tipo_tarefa, pontuacao) VALUES
(1, 5, 'Debate Cristão', 'Participar de um debate sobre ética cristã.', 'CADERNO', 15),
(1, 5, 'Resgate Básico', 'Concluir a especialidade de resgate e maca.', 'CADERNO', 25),
(1, 5, 'Fogueira em Condições Adversas', 'Acender uma fogueira debaixo de chuva.', 'CADERNO', 30),
(1, 5, 'Caminhada de 10km', 'Completar o percurso mantendo registro.', 'CADERNO', 30),
(1, 5, 'Estudo Profético', 'Compreender os pilares básicos de Daniel.', 'CADERNO', 20);

-- Inserindo Tarefas do Caderno 'Guia' (ID 6) - 6 Requisitos
INSERT INTO Tarefa (id_clube, id_caderno, titulo, descricao, tipo_tarefa, pontuacao) VALUES
(1, 6, 'Liderança de Unidade', 'Atuar como capitão de unidade por um mês.', 'CADERNO', 30),
(1, 6, 'Especialidade de Liderança', 'Completar todos os requisitos teóricos.', 'CADERNO', 25),
(1, 6, 'Atividade Missionária', 'Organizar um pequeno grupo ou ação social.', 'CADERNO', 35),
(1, 6, 'Primeiros Socorros Avançados', 'Saber realizar RCP e imobilização de fraturas.', 'CADERNO', 30),
(1, 6, 'Mensagens aos Jovens', 'Leitura e resumo crítico do livro.', 'CADERNO', 20),
(1, 6, 'Sobrevivência na Selva', 'Passar uma noite no mato com equipamento mínimo.', 'CADERNO', 40);

-- Convite para Conselheiro (Vinculado à Unidade 2 - Leões)
INSERT INTO Convite (id_clube, id_perfil, id_unidade, email, token, status_convite, data_expiracao) VALUES 
(1, 2, 2, 'conselheiro.mock@gmail.com', 't0k3nM0ckC0ns3lh31r0B4s364g3r4d0Ex3mpl0', 'PENDENTE', '2026-09-25 23:59:59');

-- Convite para Diretoria (Sem unidade vinculada)
INSERT INTO Convite (id_clube, id_perfil, id_unidade, email, token, status_convite, data_expiracao) VALUES 
(1, 1, NULL, 'diretor.mock@gmail.com', 't0k3nM0ckD1r3t0r14B4s364g3r4d0Ex3mpl0', 'PENDENTE', '2026-09-25 23:59:59');
