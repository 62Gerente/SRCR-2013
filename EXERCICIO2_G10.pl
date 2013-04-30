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

% Extensao do predicado medicamento: Nome -> {V,F,D}

medicamento('ben-u-ron').

% Extensao do predicado indicacoes_terapeuticas: Medicamento,Indicacao -> {V,F,D}

indicacoes_terapeuticas('ben-u-ron','Sindromes gripais').
indicacoes_terapeuticas('ben-u-ron','Enxaquecas').
indicacoes_terapeuticas('ben-u-ron','Dores de dentes').

-indicacoes_terapeuticas('ben-u-ron','Queimaduras').
 
-indicacoes_terapeuticas(A,B) :- nao(indicacoes_terapeuticas(A,B)), nao(excepcao(indicacoes_terapeuticas(A,B))).

% Extensao do predicado principio_activo: Medicamento,Substancia -> {V,F,D}

principio_activo('ben-u-ron','Paracetamol').

-principio_activo(M,S) :- principio_activo(M,X).  % S=!X

-principio_activo(A,B) :- nao(principio_activo(A,B)), nao(excepcao(principio_activo(A,B))).

% Extensao do predicado apresentacao_farmaceutica: Medicamento,Apresentacao -> {V,F,D}

apresentacao_farmaceutica('ben-u-ron','Comprimidos').
apresentacao_farmaceutica('ben-u-ron','Xarope').

-apresentacao_farmaceutica('ben-u-ron','Pensos').

-apresentacao_farmaceutica(A,B) :- nao(apresentacao_farmaceutica(A,B)), nao(excepcao(apresentacao_farmaceutica(A,B))).

% Extensao do predicado aplicacao_clinica: Medicamento,Aplicacao -> {V,F,D}

aplicacao_clinica(M,A) :- indicacoes_terapeuticas(M,A).

aplicacao_clinica('ben-u-ron','Sonolencia').

-aplicacao_clinica(A,B) :- nao(aplicacao_clinica(A,B)), nao(excepcao(aplicacao_clinica(A,B))).

% Extensao do predicado armario: Nome,Apresentacao -> {V,F,D}

armario('Armario 1','Comprimidos').

-armario(A,B) :- nao(armario(A,B)), nao(armario(local(A,B))).

% Extensao do predicado prateleira: Nome, Armario -> {V,F,D}

prateleira('A','Armario 1').
prateleira('B','Armario 1').

-prateleira(A,B) :- nao(prateleira(A,B)), nao(excepcao(prateleira(A,B))).

% Estensao do predicado local: Medicamento, Armario, Prateleira -> {V,F,D}

local('ben-u-ron','Armario 1', incerto).

excepcao(local(A,B,C)) :- local(A, B, incerto).

-local(A,B,C) :- nao(local(A,B,C)), nao(excepcao(local(A,B,C))).

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

