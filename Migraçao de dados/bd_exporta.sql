create database bd_exporta;

use bd_exporta;

create table departamento(
id int primary key auto_increment not null,
nome varchar(50),
localizacao varchar(50),
orcamento decimal(10,2)
);

insert departamento (nome,localizacao,orcamento) values
   ("Recursos Humanos", "São Paulo", "50000.00"),
   ("Financeiro", "Rio de Janeiro", "75000.00"),
   ("Marketing", "Belo Horizonte", "60000.00"),
   ("TI", "Curitiba", "90000.00"),
   ("Vendas", "Porto Alegre", "45000.00");
   
#
show variables like 'secure_file_priv';
select*from departamento

into outfile 'C:\\ProgramData\\MySQL\\MYSQL Server 8.0\\Uploads\\depto.csv' 
fields terminated by ',' enclosed by '"'
lines terminated by '\n';

delete from departamento
where id = 1;

delete from departamento
where id = 2;

delete from departamento
where id = 3;

delete from departamento
where id = 4;

delete from departamento
where id = 5;

#importa arquivo .csv ewportado
load data infile 'C:\\ProgramData\\MySQL\\MYSQL Server 8.0\\Uploads\\depto.csv' 
into table departamento
fields terminated by ',' enclosed by '"'
lines terminated by '\n';

select * from bd_exporta;

###################################################COMIT###########################################################

#--Início da transação
Start Transaction;

#--Aumentar o orçamento do departamento em TI 1000
update departamento set orcamento = orcamento +1000.00 where nome = "TI";

-- aumentar o orcamento em financeir 1000
update departamento set orcamento = orcamento +1000.00 where nome = "Financeiro";

-- CONFIRMAR TRANSAÇÃO
COMMIT;



#--Início da transação
Start Transaction;

#--Reduzir o orçamento do departamento em MARKETING 5000
update departamento set orcamento = orcamento - 5000.00 where nome = "Marketing";

-- Reduzir o orcamento em VENDAS 3000
update departamento set orcamento = orcamento - 3000.00 where nome = "Vendas";

-- Cancelar TRANSAÇÃO
ROLLBACK;

#############################################
#--Início da transação
Start Transaction;

#--Aumentar o orçamento do departamento em RH 7000
update departamento set orcamento = orcamento + 7000.00 where nome = "Recursos Humanos";

-- definir ponto
savepoint ajuste_parcial;

-- aumentar o orcamento em Vendas 2000
update departamento set orcamento = orcamento + 2000.00 where nome = "Vendas";

-- Reverter para ponto intermediário (defaz o aumento do orcamento vendas)
rollback TO ajuste_parcial ;





