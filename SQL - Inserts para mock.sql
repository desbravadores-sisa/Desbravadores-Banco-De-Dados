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