create database VendasInfoM 
go

use VendasInfoM 
go

create table Pessoas
(
  idPessoa int not null primary key identity,
  nome varchar(50) not null,
  cpf varchar(14) not null unique,
  status int null,

  check (status in (1, 2, 3))
)

go


exec sp_help Pessoas
go


create table Clientes
(
  pessoaId int not null primary key,
  renda decimal(10,2) not null,
  credito decimal(10,2) not null,

  foreign key(pessoaId) references Pessoas(idPessoa),

  check(renda >= 700.00),
  check(credito >= 100.00)
)

go


create table Vendedores
(
  pessoaId int not null primary key,
  salario decimal(10,2) not null check(salario >= 1000.00),

  foreign key(pessoaId) references Pessoas(idPessoa),
)

go


insert into Pessoas
  (nome, cpf, status)
values
  ('Reginaldo Morikawa', '111.111.111-11', 1)
go

insert into Pessoas
  (nome, cpf)
values
  ('Mario Henrique Pardo', '222.222.222-22')
go


insert into Pessoas
values
  ('Waldir Barros', '333.333.333-33', 2)
go


insert into Pessoas
values
  ('Lucimar Sasso', '444.444.444-44', 3),
  ('Maura Frigo', '555.555.555-55', 1),
  ('Lucimeire Schinelo', '666.666.666-66', 2),
  ('Adriano Simonato', '777.777.777-77', 1),
  ('Adriana Generoso', '888.888.888-88', 1),
  ('Claudia Hidalgo', '999.999.999-99', 2),
  ('Luciene Cavalcante', '101.101.101-10', 3)
go





insert into Clientes
  (pessoaId, renda, credito)
values
  (1, 1500.00, 750.00)
go

insert into Clientes
values
  (3, 5000.00, 1500.00)
go

insert into Clientes
values
  (5, 2500.00, 750.00),
  (7, 1700.00, 980.00),
  (9, 1872.00, 258.00)
go


select *
from Pessoas
go

select *
from Clientes
go

select Pessoas.idPessoa Cod_Cliente, Pessoas.nome Cliente, Pessoas.cpf CPF_Cliente, Pessoas.status Situacao, Clientes.renda Renda_Cliente, Clientes.credito Credito_Cliente
from Pessoas, Clientes
where Pessoas.idPessoa = Clientes.pessoaId
go


select Pessoas.idPessoa Cod_Cliente, Pessoas.nome Cliente, Pessoas.cpf CPF_Cliente, Pessoas.status Situacao, Clientes.renda Renda_Cliente, Clientes.credito Credito_Cliente
from Pessoas inner join Clientes on Pessoas.idPessoa = Clientes.pessoaId
go



insert into Vendedores
  (pessoaId, salario)
values
  (2, 1500.00)
go

insert into Vendedores
values
  (4, 2000.00),
  (6, 2500.00),
  (8, 1000.00),
  (10, 5500.00)
go

select *
from Vendedores
go

select P.idPessoa Cod_Vendedor, P.nome Vendedor, P.cpf CPF_Vendedor, P.status Situacao, V.salario Salario
from Pessoas as P, Vendedores as V
where P.idPessoa = V.pessoaId
go

select P.idPessoa Cod_Vendedor, P.nome Vendedor, P.cpf CPF_Vendedor, P.status Situaao, V.salario Salario
from Pessoas P inner join Vendedores V on P.idPessoa = V.pessoaId
go


create table Pedidos
(
  id int not null primary key identity,
  data datetime not null,
  valor money,
  status int,
  vendedor_id int not null,
  cliente_id int not null,

  foreign key(vendedor_id) references Vendedores(pessoaId),
  foreign key(cliente_id) references Clientes(pessoaId),

  check (status between 1 and 3)
)
go


insert into Pedidos
  (data, status, vendedor_id, cliente_id)
values
  ('2023-12-25', 1, 2, 1)
go

insert into Pedidos
  (data, status, vendedor_id, cliente_id)
values
  (getdate(), 1, 4, 1),
  (getdate(), 2, 6, 5),
  ('2024-04-17', 1, 8, 7),
  ('2023-10-04', 3, 6, 3)
go

select *
from Pedidos
go

select P.idPessoa Cod_Cliente, P.nome Cliente, P.cpf CPF_Cliente, P.status Situacao, C.credito Credito_Cliente, Ped.id No_Pedido, Ped.data Data_Pedido, Ped.vendedor_id Cod_Vendedor
from Pessoas P, Clientes C, Pedidos Ped
where P.idPessoa = C.pessoaId and C.pessoaId = Ped.cliente_id
go 