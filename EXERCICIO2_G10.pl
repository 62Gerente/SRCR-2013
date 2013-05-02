%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% TRABALHO DE GRUPO - EXERCÍCIO 2

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistema de representação de conhecimento e raciocínio com capacidade para caracterizar um universo de discurso de âmbito farmacêutico.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic medicamento/1.
:- dynamic indicacao_terapeutica/2.
:- dynamic principio_activo/2.
:- dynamic apresentacao_farmaceutica/2.
:- dynamic aplicacao_clinica/2.
:- dynamic armario/2.
:- dynamic prateleira/2.
:- dynamic local/3.
:- dynamic preco_recomendado/2.
:- dynamic preco_publico/2.
:- dynamic regime_especial/3.
:- dynamic data_validade/4.
:- dynamic data_introducao/4.

% Extensao do predicado medicamento: Nome -> {V,F,D}

medicamento('ben-u-ron').

% Extensao do predicado indicacoes_terapeuticas: Medicamento,Indicacao -> {V,F,D}

indicacao_terapeutica('ben-u-ron','Sindromes gripais').
indicacao_terapeutica('ben-u-ron','Enxaquecas').
indicacao_terapeutica('ben-u-ron','Dores de dentes').
-indicacoes_terapeutica('ben-u-ron','Queimaduras').

excepcao(indicacao_terapeutica(A,B)) :- indicacao_terapeutica(A,incerto). 
excepcao(indicacao_terapeutica(A,B)) :- indicacao_terapeutica(incerto,B). 
-indicacao_terapeutica(A,B) :- nao(indicacao_terapeutica(A,B)), nao(excepcao(indicacao_terapeutica(A,B))).

% Extensao do predicado principio_activo: Medicamento,Substancia -> {V,F,D}

principio_activo('ben-u-ron','Paracetamol').

-principio_activo(M,S) :- principio_activo(M,X).  % S=!X
excepcao(principio_activo(A,B)) :- principio_activo(A,incerto).
excepcao(principio_activo(A,B)) :- principio_activo(incerto,B).
-principio_activo(A,B) :- nao(principio_activo(A,B)), nao(excepcao(principio_activo(A,B))).

% Extensao do predicado apresentacao_farmaceutica: Medicamento,Apresentacao -> {V,F,D}

apresentacao_farmaceutica('ben-u-ron','Comprimidos').
apresentacao_farmaceutica('ben-u-ron','Xarope').
-apresentacao_farmaceutica('ben-u-ron','Pensos').

excepcao(apresentacao_farmaceutica(A,B)) :- apresentacao_farmaceutica(A,incerto). 
excepcao(apresentacao_farmaceutica(A,B)) :- apresentacao_farmaceutica(incerto,B). 
-apresentacao_farmaceutica(A,B) :- nao(apresentacao_farmaceutica(A,B)), nao(excepcao(apresentacao_farmaceutica(A,B))).

% Extensao do predicado aplicacao_clinica: Medicamento,Aplicacao -> {V,F,D}

aplicacao_clinica('ben-u-ron','Sonolencia').

aplicacao_clinica(M,A) :- indicacao_terapeutica(M,A).
excepcao(aplicacao_clinica(A,B)) :- aplicacao_clinica(A,incerto).
excepcao(aplicacao_clinica(A,B)) :- aplicacao_clinica(incerto,B).
-aplicacao_clinica(A,B) :- nao(aplicacao_clinica(A,B)), nao(excepcao(aplicacao_clinica(A,B))).

% Extensao do predicado armario: Nome,Apresentacao -> {V,F,D}

armario('Armario 1','Comprimidos').

excepcao(armario(A,B)) :- armario(A,incerto).
excepcao(armario(A,B)) :- armario(incerto,B).
-armario(A,B) :- nao(armario(A,B)), nao(armario(local(A,B))).

% Extensao do predicado prateleira: Nome, Armario -> {V,F,D}

prateleira('A','Armario 1').
prateleira('B','Armario 1').

excepcao(prateleira(A,B)) :- prateleira(A,incerto).
excepcao(prateleira(A,B)) :- prateleira(incerto,B).
-prateleira(A,B) :- nao(prateleira(A,B)), nao(excepcao(prateleira(A,B))).

% Estensao do predicado local: Medicamento, Armario, Prateleira -> {V,F,D}

local('ben-u-ron','Armario 1', incerto).

excepcao(local(A,B,C)) :- local(A, B, incerto).
excepcao(local(A,B,C)) :- local(A, incerto, C).
excepcao(local(A,B,C)) :- local(incerto, B, C).
-local(A,B,C) :- nao(local(A,B,C)), nao(excepcao(local(A,B,C))).

% Estensao do predicado preco_recomendado: Medicamento, Preco -> {V,F,D}

excepcao(preco_recomendado('ben-u-ron', P)) :- P>=7.5, p<=10.

excepcao(preco_recomendado(A,B)) :- preco_recomendado(A,incerto).
excepcao(preco_recomendado(A,B)) :- preco_recomendado(incerto,B).
-preco_recomendado(A,B) :- nao(preco_recomendado(A,B)), nao(excepcao(preco_recomendado(A,B))).

% Estensao do predicado preco_publico: Medicamento, Preco -> {V,F,D}

excepcao(preco_publico('ben-u-ron', P)) :- P>=9, p<=10.

excepcao(preco_publico(A,B)) :- preco_publico(A,incerto).
excepcao(preco_publico(A,B)) :- preco_publico(incerto,B).
-preco_publico(A,B) :- nao(preco_publico(A,B)), nao(excepcao(preco_publico(A,B))).

% Estensao do predicado regime_especial: Medicamento, Escalao, Preco -> {V,F,D}

regime_especial('ben-u-ron', A, 3).
regime_especial('ben-u-ron', B, incerto).

excepcao(regime_especial(A,B,C)) :- regime_especial(A, B, incerto).
excepcao(regime_especial(A,B,C)) :- regime_especial(A, incerto, C).
excepcao(regime_especial(A,B,C)) :- regime_especial(incerto, B, C).
-regime_especial(A,B,C) :- nao(regime_especial(A,B,C)), nao(excepcao(regime_especial(A,B,C))).

% Estensao do predicado data_validade: Medicamento, Dia, Mes, Ano -> {V,F,D}

data_validade('ben-u-ron', 23, 10, 2013).

excepcao(data_validade(A,B,C,D)) :- data_validade(A,B,C,incerto).
excepcao(data_validade(A,B,C,D)) :- data_validade(A,B,incerto,D).
excepcao(data_validade(A,B,C,D)) :- data_validade(A,incerto,C,D).
excepcao(data_validade(A,B,C,D)) :- data_validade(incerto,B,C,D).
excepcao(data_validade(A,B,C,D)) :- data_validade(A,incerto,incerto,incerto).
-data_validade(A,B,C,D) :- nao(data_validade(A,B,C,D)), nao(excepcao(data_validade(A,B,C,D))).

% Estensao do predicado data_introducao: Medicamento, Dia, Mes, Ano -> {V,F,D}

data_introducao('ben-u-ron', 23, 02, 2013).

excepcao(data_introducao(A,B,C,D)) :- data_introducao(A,B,C,incerto).
excepcao(data_introducao(A,B,C,D)) :- data_introducao(A,B,incerto,D).
excepcao(data_introducao(A,B,C,D)) :- data_introducao(A,incerto,C,D).
excepcao(data_introducao(A,B,C,D)) :- data_introducao(incerto,B,C,D).
excepcao(data_introducao(A,B,C,D)) :- data_introducao(A,incerto,incerto,incerto).
-data_introducao(A,B,C,D) :- nao(data_introducao(A,B,C,D)), nao(excepcao(data_introducao(A,B,C,D))).

% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

