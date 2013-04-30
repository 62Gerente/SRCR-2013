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
 
% Extensao do predicado principio_activo: Medicamento,Substancia -> {V,F,D}

principio_activo('ben-u-ron','Paracetamol').

-principio_activo(M,S) :- principio_activo(M,X).  % S=!X

% Extensao do predicado apresentacao_farmaceutica: Medicamento,Apresentacao -> {V,F,D}

apresentacao_farmaceutica('ben-u-ron','Comprimidos').
apresentacao_farmaceutica('ben-u-ron','Xarope').

-apresentacao_farmaceutica('ben-u-ron','Pensos').

% Extensao do predicado aplicacao_clinica: Medicamento,Aplicacao -> {V,F,D}

aplicacao_clinica(M,A) :- indicacoes_terapeuticas(M,A).

aplicacao_clinica('ben-u-ron','Sonolencia').

% Extensao do predicado armario: Nome,Apresentacao -> {V,F,D}

armario('C A-G','Comprimidos').

% Extensao do predicado prateleira: Nome, Armario -> {V,F,D}

prateleira('C A-C','C A-G').
prateleira('C D-F','C A-G').

% Estensao do predicado esta_prateleira: Medicamento, Armario, Prateleira -> {V,F,D}

local('ben-u-ron','C A-G','C A-C').

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

