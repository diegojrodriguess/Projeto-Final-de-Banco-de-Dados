DROP DATABASE IF EXISTS projeto_bd;
CREATE DATABASE projeto_bd;
USE projeto_bd;

CREATE TABLE IF NOT EXISTS Faculdade (
endereco VARCHAR (100) NOT NULL,
nome VARCHAR (50) NOT NULL,

PRIMARY KEY (endereco)
);

CREATE TABLE IF NOT EXISTS Aluno (
nome VARCHAR (50) NOT NULL,
idade INT NOT NULL,
curso VARCHAR (3) NOT NULL,
matricula INT NOT NULL,
endereco_Faculdade VARCHAR (100) NOT NULL,

PRIMARY KEY (matricula),
CONSTRAINT fk1
FOREIGN KEY (endereco_Faculdade) references Faculdade (endereco) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Professor (
nome VARCHAR (50) NOT NULL,
id INT NOT NULL AUTO_INCREMENT,
idade INT NOT NULL,
endereco_Faculdade VARCHAR (50) NOT NULL,

PRIMARY KEY (id),
CONSTRAINT fk2
FOREIGN KEY (endereco_Faculdade) REFERENCES Faculdade (endereco)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Responsavel (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
idade INT NOT NULL,
matricula_Aluno INT NOT NULL,

PRIMARY KEY (id),
CONSTRAINT fk3
FOREIGN KEY (matricula_Aluno) REFERENCES Aluno (matricula)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Leciona(
id_Professor INT,
matricula_Aluno INT, 

CONSTRAINT fk4
FOREIGN KEY (id_Professor) REFERENCES Professor (id)
	ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk5
FOREIGN KEY (matricula_Aluno) REFERENCES Aluno (matricula)
	ON DELETE CASCADE ON UPDATE CASCADE
);

#COMANDOS DML
INSERT INTO Faculdade VALUES ('Av. João de Camargo, 510','INATEL');
INSERT INTO Aluno (nome, idade, curso, matricula,endereco_faculdade) VALUES ('Diego de Jesus Rodrigues',20,'GES',233,'Av. João de Camargo, 510');
INSERT INTO Professor (nome, idade, endereco_faculdade) VALUES ('JOSE',30,'Av. João de Camargo, 510');
INSERT INTO Responsavel (nome,idade,matricula_Aluno) VALUES ('JOAO',35,233);
INSERT INTO Leciona (id_Professor, matricula_Aluno) VALUES (1,233);

#COMANDOS DQL
#PROCURANDO QUEM E O RESPONSAVEL PELO ALUNO DIEGO
SELECT r.nome FROM Responsavel AS r, Aluno AS a
WHERE r.matricula_Aluno = a.matricula;

#Procurando nome e idade de professores que lecionam para o aluno Diego
SELECT p.nome, p.idade FROM Leciona, Professor as p, Aluno as a
WHERE Leciona.id_Professor = p.id and Leciona.matricula_Aluno = a.matricula;


