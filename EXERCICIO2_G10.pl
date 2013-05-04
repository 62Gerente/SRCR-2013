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
:- dynamic preco_recomendado/3.
:- dynamic preco_publico/3.
:- dynamic regime_especial/4.
:- dynamic data_validade/5.
:- dynamic data_introducao/5.

% NAO PODE ESTAR EM MAIS QUE UMA PRATELEIRA DO MESMO ARMARIO ????????
% VERIFICAR LETRA ARMARIO MEDICAMENTO ?????????

% _________________FALTA___________________________

% PREDICADOS: indicacoes_terapeuticas, apresentacoes_terapeuticas, aplicacoes_clinicas, locais, precos, datas... bla bla
% PREDICADOS: preco (MEDICAMENTO,APRESENTACAO,ESCALAO) -> dá o preco do regime especial para o escalao, se o escalao nao existir da o preco publico
% ACRESCENTAR APRESENTACAO NO (LOCAL?)
% DADOS TESTE E ARRANJAR UMA MANEIRA DE OS REPRESENTAR NO RELATORIO

% MAIS CASOS DE CONHECIMENTO INCERTO? EX: REGIME_ESPECIAL(A,INCERTO,INCERTO)???????????????????

% _________________DUVIDAS_________________________

% LISTA DE DATAS PARA O MESMO MEDICAMENTO E APRESENTACAO ????


%%%%%%%%%%%%%%%%%%   MEDICAMENTO   %%%%%%%%%%%%%%%%%%%
% Extensao do predicado medicamento: Nome -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+medicamento(M) :: (solucoes((M),medicamento( M ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
medicamento('ben-u-ron').
medicamento('vibrocil').
medicamento('brufen').
medicamento('cegripe').

%%%%%%%%%%  Conhecimento negativo %%%%%%%%%%
-medicamento(M) :- nao(medicamento(M)), nao(excepcao(medicamento(M))).



%%%%%%%%%%%%%%%%%%   INDICACAO_TERAPEUTICA   %%%%%%%%%%%%%%%%%%%

% Extensao do predicado indicacao_terapeutica: Medicamento,Indicacao -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+indicacao_terapeutica(M,I) :: (solucoes((M,I),indicacao_terapeutica( M,I ), S),
                                comprimento( S,N ), N == 1
                                ).
%% Medicamento tem de existir  %%
+indicacao_terapeutica(M,I) :: ( medicamento(M) ).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
indicacao_terapeutica('ben-u-ron', 'Sindromes gripais').
indicacao_terapeutica('ben-u-ron', 'Enxaquecas').
indicacao_terapeutica('ben-u-ron', 'Dores de dentes').

indicacao_terapeutica('vibrocil', 'Sindromes gripais').
indicacao_terapeutica('vibrocil', 'Congestao nasal').
indicacao_terapeutica('vibrocil', 'Rinorreia').

indicacao_terapeutica('brufen', 'Artrite Reumatoide').
indicacao_terapeutica('brufen', 'Traumatismos').
indicacao_terapeutica('brufen', 'Febre').

indicacao_terapeutica('cegripe', 'Sindromes gripais').

%%%%%%%%%%  Conhecimento negativo %%%%%%%%%%
-indicacao_terapeutica(A,B) :- nao(indicacao_terapeutica(A,B)), nao(excepcao(indicacao_terapeutica(A,B))).
% -indicacoes_terapeutica('ben-u-ron', 'Queimaduras').

%%%%%%%%%%  Excepções %%%%%%%%%%
excepcao(indicacao_terapeutica(A,B)) :- indicacao_terapeutica(A,incerto). 
excepcao(indicacao_terapeutica(A,B)) :- indicacao_terapeutica(incerto,B). 



%%%%%%%%%%%%%%%%%%   PRINCIPIO_ACTIVO   %%%%%%%%%%%%%%%%%%%
% Extensao do predicado principio_activo: Medicamento,Substancia -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+principio_activo(M,P) :: (solucoes((M,P),principio_activo( M,P ), S),
                                comprimento( S,N ), N == 1
                                ).
%% Medicamento tem de existir %%
+principio_activo(M, P) :: ( medicamento(M) ).
%% So um principio activo por medicamento %%
+principio_activo( M,P ) :: (solucoes( (Ps), principio_activo(M, Ps), S ),
                                 comprimento( S,N ), N == 1
                                 ).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
principio_activo('ben-u-ron', 'Paracetamol').
principio_activo('vibrocil', 'Femilefrina').
principio_activo('brufen', 'Ibuprofeno').
principio_activo('cegripe','Paracetamol').

%%%%%%%%%%  Conhecimento negativo %%%%%%%%%%
-principio_activo(A,B) :- nao(principio_activo(A,B)), nao(excepcao(principio_activo(A,B))).
% -principio_activo(M,S) :- principio_activo(M,X).  % S=!X

%%%%%%%%%%  Excepções %%%%%%%%%%
excepcao(principio_activo(A,B)) :- principio_activo(A,incerto).
excepcao(principio_activo(A,B)) :- principio_activo(incerto,B).



%%%%%%%%%%%%%%%%%%   APRESENTACAO_FARMACEUTICA   %%%%%%%%%%%%%%%%%%%
% Extensao do predicado apresentacao_farmaceutica: Medicamento,Apresentacao -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+apresentacao_farmaceutica(M,A) :: (solucoes((M,A),apresentacao_farmaceutica( M,A ), S),
                                comprimento( S,N ), N == 1
                                ).
%% Medicamento tem de existir %%
+apresentacao_farmaceutica(M, A) :: ( medicamento(M) ).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
apresentacao_farmaceutica('ben-u-ron','Comprimidos').
apresentacao_farmaceutica('ben-u-ron','Xarope').

apresentacao_farmaceutica('vibrocil', 'Gotas nasais').

apresentacao_farmaceutica('brufen', 'Comprimidos').
apresentacao_farmaceutica('brufen', 'Xarope').

apresentacao_farmaceutica('cegripe', 'Comprimidos').

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-apresentacao_farmaceutica(A,B) :- nao(apresentacao_farmaceutica(A,B)), nao(excepcao(apresentacao_farmaceutica(A,B))).
% -apresentacao_farmaceutica('ben-u-ron','Pensos').

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(apresentacao_farmaceutica(A,B)) :- apresentacao_farmaceutica(A,incerto). 
excepcao(apresentacao_farmaceutica(A,B)) :- apresentacao_farmaceutica(incerto,B). 



%%%%%%%%%%%%%%%%%%   APLICAÇÃO_CLINICA   %%%%%%%%%%%%%%%%%%%
% Extensao do predicado aplicacao_clinica: Medicamento,Aplicacao -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+aplicacao_clinica(M,A) :: (solucoes((M,A),aplicacao_clinica( M,A ), S),
                                comprimento( S,N ), N == 1
                                ).
%% Medicamento tem de existir %%
+aplicacao_clinica(M, A) :: ( medicamento(M) ).
%% Não permitir a inserção de valores que já sejam nulos %%
+aplicacao_clinica(M, A) :: (aplicacao_clinica(M, X),
                               nao(nulo(X))).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
aplicacao_clinica(M,A) :- indicacao_terapeutica(M,A).

aplicacao_clinica('ben-u-ron', 'Sonolencia').

%aplicacao_clinica('vibrocil', aplicacao_nula).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-aplicacao_clinica(A,B) :- nao(aplicacao_clinica(A,B)), nao(excepcao(aplicacao_clinica(A,B))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
%excepcao(aplicacao_clinica(A,B)) :- aplicacao_clinica(A, aplicacao_nula).
excepcao(aplicacao_clinica(A,B)) :- aplicacao_clinica(A,incerto).
excepcao(aplicacao_clinica(A,B)) :- aplicacao_clinica(incerto,B).



%%%%%%%%%%%%%%%%%%   ARMARIO   %%%%%%%%%%%%%%%%%%%
% Extensao do predicado armario: Nome,Apresentacao -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+armario(X,A) :: (solucoes((X,A),armario( X,A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
armario('Armario 1', 'Comprimidos').
armario('Armario 2', 'Xarope').
armario('Armario 3', 'Gotas nasais').
armario('Armario 4', incerto).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-armario(A,B) :- nao(armario(A,B)), nao(armario(local(A,B))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(armario(A,B)) :- armario(A,incerto).
excepcao(armario(A,B)) :- armario(incerto,B).



%%%%%%%%%%%%%%%%%%   PRATELEIRA   %%%%%%%%%%%%%%%%%%%
% Extensao do predicado prateleira: Nome, Armario -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+prateleira(P,A) :: (solucoes((P,A),prateleira( P,A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
prateleira('A','Armario 1').
prateleira('B','Armario 1').
prateleira('C','Armario 1').
prateleira('B','Armario 2').
prateleira('V','Armario 3').
prateleira('E', 'Armario 4').

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-prateleira(A,B) :- nao(prateleira(A,B)), nao(excepcao(prateleira(A,B))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(prateleira(A,B)) :- prateleira(A,incerto).
excepcao(prateleira(A,B)) :- prateleira(incerto,B).



%%%%%%%%%%%%%%%%%%   LOCAL   %%%%%%%%%%%%%%%%%%%
% Estensao do predicado local: Medicamento, Armario, Prateleira -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+local(M,A,P) :: (solucoes((M,A,P),local( M,A,P ), S),
                                comprimento( S,N ), N == 1
                                ).
%% O armário e a prateleira existem %%
+local( M,A,P ) :: (armario(A,X), prateleira(P,A)).
%% SO DEIXAR POR UM MEDICAMENTO NO ARMARIO CERTO (APRESENTACAO ARMARIO = UMA DAS APRESENTACOES DO MEDICAMENTO) %%
+local( M,A,P ) :: (armario(A,X),aplicacao_clinica(M,X)).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
local('ben-u-ron', 'Armario 1', incerto).
local('ben-u-ron', 'Armario 2', 'B').

local('vibrocil', 'Armario 3', 'V').

local('brufen', 'Armario 1', 'B').
local('brufen', 'Armario 2', 'B').

local('cegripe', 'Armario 1', 'C').

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-local(A,B,C) :- nao(local(A,B,C)), nao(excepcao(local(A,B,C))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(local(A,B,C)) :- local(A, B, incerto).
excepcao(local(A,B,C)) :- local(A, incerto, C).
excepcao(local(A,B,C)) :- local(incerto, B, C).



%%%%%%%%%%%%%%%%%%   PRECO_RECOMENDADO   %%%%%%%%%%%%%%%%%%%
% Estensao do predicado preco_recomendado: Medicamento, Apresentacao, Preco -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+preco_recomendado(M,A,P) :: (solucoes((M,A,P),preco_recomendado( M,A,P ), S),
                                comprimento( S,N ), N == 1
                                ).
%% SO DEIXAR REFERIR APRESENTACAO SE ELA EXISTIR %%
+preco_recomendado(M,A,P) :: aplicacao_clinica(M,A).
%% Não permitir a inserção de valores que já sejam nulos %%
+preco_recomendado(M, A, P) :: (preco_recomendado(M, A, X),
                               nao(nulo(X))).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
preco_recomendado('ben-u-ron', 'Xarope', 12).

preco_recomendado('vibrocil', 'Gotas nasais', preco_nulo).

preco_recomendado('brufen', 'Comprimidos', 6).
preco_recomendado('brufen', 'Xarope', 8).

preco_recomendado('cegripe', 'Comprimidos', 4).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-preco_recomendado(A,B,C) :- nao(preco_recomendado(A,B,C)), nao(excepcao(preco_recomendado(A,B,C))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(preco_recomendado('ben-u-ron', 'Comprimidos', P)) :- P>=7.5, P=<10.

excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(A, B, preco_nulo).

excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(A,incerto,C).
excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(incerto,B,C).
excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(A,B,incerto).



%%%%%%%%%%%%%%%%%%   PRECO_PUBLICO   %%%%%%%%%%%%%%%%%%%
% Estensao do predicado preco_publico: Medicamento, Apresentacao, Preco -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+preco_publico(M,A,P) :: (solucoes((M,A,P),preco_publico( M,A,P ), S),
                                comprimento( S,N ), N == 1
                                ).
%% SO DEIXAR REFERIR APRESENTACAO SE ELA EXISTIR %%
+preco_publico(M,A,P) :: aplicacao_clinica(M,A).
%% Não permitir a inserção de valores que já sejam nulos %%
+preco_publico(M, A, P) :: (preco_publico(M, A, X),
                               nao(nulo(X))).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
preco_publico('ben-u-ron', incerto, 5).

preco_publico('vibrocil', 'Gotas nasais', 4.95).

preco_publico('brufen', 'Comprimidos', 8).
preco_publico('brufen', 'Xarope', preco_nulo).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-preco_publico(A,B,C) :- nao(preco_publico(A,B,C)), nao(excepcao(preco_publico(A,B,C))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(preco_publico('ben-u-ron', 'Comprimidos', P)) :- P>=9, P=<10.

excepcao(preco_publico('cegripe', 'Comprimidos', P)) :- P>=5, P=<7.

excepcao(preco_publico(A,B,C)) :- preco_publico(A, B, preco_nulo).
excepcao(preco_publico(A,B,C)) :- preco_publico(A,incerto,C).
excepcao(preco_publico(A,B,C)) :- preco_publico(incerto,B,C).
excepcao(preco_publico(A,B,C)) :- preco_publico(A,B,incerto).



%%%%%%%%%%%%%%%%%%   REGIME_ESPECIAL   %%%%%%%%%%%%%%%%%%%
% Estensao do predicado regime_especial: Medicamento, Apresentacao, Escalao, Preco -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+regime_especial(M,A,E,P) :: (solucoes((M,A,E,P),regime_especial( M,A,E,P ), S),
                                comprimento( S,N ), N == 1
                                ).
%% SO DEIXAR REFERIR APRESENTACAO SE ELA EXISTIR %%
+regime_especial(M,A,E,P) :: aplicacao_clinica(M,A).
%% Não permitir a inserção de valores que já sejam nulos %%
+regime_especial(M, A, E, P) :: (regime_especial(M, A, E, X),
                               nao(nulo(X))).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
regime_especial('ben-u-ron', 'Comprimidos', 'A', 3).
regime_especial('ben-u-ron', 'Comprimidos', 'B', incerto).

regime_especial('vibrocil', 'Gotas nasais', 'A', incerto).
regime_especial('vibrocil', 'Gotas nasais', 'B', 4).

regime_especial('brufen', 'Comprimidos', 'B', preco_nulo).
regime_especial('brufen', 'Xarope', 'A', 6).
regime_especial('brufen', 'Xarope', 'B', incerto).

regime_especial('cegripe', 'Comprimidos', 'A', 2).
regime_especial('cegripe', 'Comprimidos', 'B', 3).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-regime_especial(A,B,C,D) :- nao(regime_especial(A,B,C,D)), nao(excepcao(regime_especial(A,B,C,D))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(regime_especial('brufen', 'Comprimidos', 'A', P)) :- P>=4, P=<6.

excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, B, C, preco_nulo).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, B, incerto, D).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, incerto, C, D).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(incerto, B, C, D).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, B, C, incerto).



%%%%%%%%%%%%%%%%%%   DATA_VALIDADE   %%%%%%%%%%%%%%%%%%%
% Estensao do predicado data_validade: Medicamento, Apresentacao, Dia, Mes, Ano -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+data_validade(X,A,D,M,A) :: (solucoes((X,A,D,M,A),data_validade( X,A,D,M,A ), S),
                                comprimento( S,N ), N == 1
                                ).
%% SO DEIXAR REFERIR APRESENTACAO SE ELA EXISTIR %%
+data_validade(X,A,D,M,A) :: aplicacao_clinica(M,A).
%% Data de validade maior do que data de introdução %%
+data_validade( X,A,D,M,A ) :: (
                                ( nao(data_introducao(X,A,D2,M2,A2)) );
                                ( A>A2 );
                                ( A==A2, M>M2 );
                                ( A==A2, M==M2, D>D2 )).
%% Não permitir a inserção de valores que já sejam nulos %%
+data_validade(M, Apr, D, M, Ano) :: (data_validade(M, Apr, D_X, M_X, Ano_X),
                               nao(nulo(D_X),
                                   nulo(M_X),
                                   nulo(Ano_X))).

%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
data_validade('ben-u-ron', 'Comprimidos', 23, 10, 2013).
data_validade('ben-u-ron', 'Xarope', data_nula, data_nula, data_nula).

data_validade('vibrocil', 'Gotas nasais', incerto, 09, 2014).

data_validade('brufen', 'Comprimidos', 01, 05, 2016).
data_validade('brufen', 'Xarope', incerto, incerto, 2015).

data_validade('cegripe', 'Comprimidos', 31, 12, 2015).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-data_validade(A,B,C,D,E) :- nao(data_validade(A,B,C,D,E)), nao(excepcao(data_validade(A,B,C,D,E))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B, data_nula, data_nula, data_nula).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,C,incerto,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,incerto,D,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,incerto,C,D,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(incerto,B,C,D,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,C,D,incerto).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,incerto,incerto,incerto).



%%%%%%%%%%%%%%%%%%   DATA_INTRODUÇÃO   %%%%%%%%%%%%%%%%%%%
% Estensao do predicado data_introducao: Medicamento, Apresentacao, Dia, Mes, Ano -> {V,F,D}

%%%%%%%%%%  Invariantes   %%%%%%%%%%
%% Não pode haver conhecimento repetido %%
+data_introducao(X,A,D,M,A) :: (solucoes((X,A,D,M,A),data_introducao( X,A,D,M,A ), S),
                                comprimento( S,N ), N == 1
                                ).
%% SO DEIXAR REFERIR APRESENTACAO SE ELA EXISTIR %%
+data_introducao(X,A,D,M,A) :: aplicacao_clinica(M,A).
%% Data de introdução menor do que data de validade %%
+data_introducao( X,A,D,M,A ) :: (
                                ( nao(data_validade(X,A,D2,M2,A2)) );
                                ( A<A2 );
                                ( A==A2, M<M2 );
                                ( A==A2, M==M2, D<D2 )).
%% Não permitir a inserção de valores que já sejam nulos %%
+data_introducao(M, Apr, D, M, Ano) :: (data_introducao(M, Apr, D_X, M_X, Ano_X),
                               nao(nulo(D_X),
                                   nulo(M_X),
                                   nulo(Ano_X))).
                               
%%%%%%%%%%   Base de conhecimento inicial    %%%%%%%%%%
excepcao(data_introducao('ben-u-ron', 'Comprimidos', D, 02, 2013)) :- D>=15, D=<25.
data_introducao('ben-u-ron', 'Xarope', 23, 02, 2013).

data_introducao('vibrocil', 'Gotas nasais', 01, 01, 2010).

data_introducao('brufen', 'Comprimidos', 01, 01, 2012).
data_introducao('brufen', 'Xarope', 10, incerto, 2012).

data_introducao('cegripe', 'Comprimidos', data_nula, data_nula, data_nula).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-data_introducao(A,B,C,D,E) :- nao(data_introducao(A,B,C,D,E)), nao(excepcao(data_introducao(A,B,C,D,E))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B, data_nula, data_nula, data_nula).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,C,incerto,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,incerto,D,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,incerto,C,D,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(incerto,B,C,D,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,C,D,incerto).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,incerto,incerto,incerto).



%%%%%%%%%%%%%%%%%%   NULO   %%%%%%%%%%%%%%%%%%%
% Extensao do meta-predicado nulo: Valor -> {V,F}

nulo(preco_nulo).
nulo(data_nula).
nulo(aplicacao_nula).

%%%%%%%%%% ----------------------------------------------------------------------------------- %%%%%%%%%%

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

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado solucoes: X,Teorema,Solucoes -> {V, F}

solucoes(X, Teorema, Solucoes) :-
        Teorema, 
        assert(temp(X)), 
        fail. 
solucoes(X, Teorema, Solucoes) :-
        assert(temp(fim)), 
        construir(Solucoes).

construir(Solucoes) :-
        retract(temp(Y)), !,
                (Y==fim, !, Solucoes=[];
                Solucoes=[Y | Resto], 
                construir(Resto)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a inserção de conhecimento: Termo -> {v, F}

inserirConhecimento(Termo) :-
        solucoes( Invariante, +Termo::Invariante, Lista),
        insercao(Termo),
        teste( Lista ).

insercao(Termo) :-
        assert(Termo) .
insercao(Termo) :-
        retract(Termo), !, fail .

teste([]) .
teste([H|T]) :-
        H, teste(T) .   

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a remoção de conhecimento: Termo -> {v, F}

removerConhecimento(Termo) :-
        remocao(Termo) .

remocao(Termo) :-
        retract(Termo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado comprimento: L, R -> {V, F}

comprimento([], 0) .
comprimento([H|T], R) :-
        comprimento(T, X),
        R is 1+X .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado eliminarRepetidos: L, R -> {V, F}

eliminarRepetidos([], []) .
eliminarRepetidos([H|T], Res) :-
        eliminarElemento(T, H, R_e_elem),
        eliminarRepetidos(R_e_elem, R_e_rep),
        Res = [H|R_e_rep] .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado eliminarElemento: L, E, R -> {V, F}     

eliminarElemento([], _, []).
eliminarElemento([H|T], H, Res) :-
        eliminarElemento(T, H, R_e_elem),
        Res = R_e_elem .
eliminarElemento([H|T], E, Res) :-
        H \== E,
        eliminarElemento(T, E, R_e_elem),
        Res = [H|R_e_elem] .

