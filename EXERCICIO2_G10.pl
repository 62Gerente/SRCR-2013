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

% Invariante Estrutural:  nao permitir a insercao de conhecimento repetido

+medicamento(M) :: (solucoes((M),medicamento( M ), S),
				comprimento( S,N ), N == 1
				).

+indicacao_terapeutica(M,I) :: (solucoes((M,I),indicacao_terapeutica( M,I ), S),
				comprimento( S,N ), N == 1
				).

+principio_activo(M,P) :: (solucoes((M,P),principio_activo( M,P ), S),
				comprimento( S,N ), N == 1
				).

+apresentacao_farmaceutica(M,A) :: (solucoes((M,A),apresentacao_farmaceutica( M,A ), S),
				comprimento( S,N ), N == 1
				).

+aplicacao_clinica(M,A) :: (solucoes((M,A),aplicacao_clinica( M,A ), S),
				comprimento( S,N ), N == 1
				).

+armario(X,A) :: (solucoes((X,A),armario( X,A ), S),
				comprimento( S,N ), N == 1
				).

+prateleira(P,A) :: (solucoes((P,A),prateleira( P,A ), S),
				comprimento( S,N ), N == 1
				).

+local(M,A,P) :: (solucoes((M,A,P),local( M,A,P ), S),
				comprimento( S,N ), N == 1
				).

+preco_recomendado(M,A,P) :: (solucoes((M,A,P),preco_recomendado( M,A,P ), S),
				comprimento( S,N ), N == 1
				).

+preco_publico(M,A,P) :: (solucoes((M,A,P),preco_publico( M,A,P ), S),
				comprimento( S,N ), N == 1
				).

+regime_especial(M,A,E,P) :: (solucoes((M,A,E,P),regime_especial( M,A,E,P ), S),
				comprimento( S,N ), N == 1
				).

+data_validade(X,A,D,M,A) :: (solucoes((X,A,D,M,A),data_validade( X,A,D,M,A ), S),
				comprimento( S,N ), N == 1
				).

+data_introducao(X,A,D,M,A) :: (solucoes((X,A,D,M,A),data_introducao( X,A,D,M,A ), S),
				comprimento( S,N ), N == 1
				).

% _________ Invariante Referencial

% SO UM PRINCIPIO ACTIVO POR MEDICAMENTO
% SO DEIXAR POR UM MEDICAMENTO NO ARMARIO CERTO (APRESENTACAO ARMARIO = UMA DAS APRESENTACOES DO MEDICAMENTO)
% NAO PODE ESTAR EM MAIS ARMARIOS QUE APRESENTACOES FARMACEUTICAS
% DATA VALIDADE > DATA INTRODUCAO


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

% Estensao do predicado preco_recomendado: Medicamento, Apresentacao, Preco -> {V,F,D}

excepcao(preco_recomendado('ben-u-ron', 'Comprimidos', P)) :- P>=7.5, p<=10.
preco_recomendado('ben-u-ron', 'Xarope' 12).

excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(A,incerto,C).
excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(incerto,B,C).
excepcao(preco_recomendado(A,B,C)) :- preco_recomendado(A,B,incerto).
-preco_recomendado(A,B,C) :- nao(preco_recomendado(A,B,C)), nao(excepcao(preco_recomendado(A,B,C))).

% Estensao do predicado preco_publico: Medicamento, Apresentacao, Preco -> {V,F,D}

excepcao(preco_publico('ben-u-ron', 'Comprimidos', P)) :- P>=9, p<=10.
preco_publico('ben-u-ron', incerto, 5).

excepcao(preco_publico(A,B,C)) :- preco_publico(A,incerto,C).
excepcao(preco_publico(A,B,C)) :- preco_publico(incerto,B,C).
excepcao(preco_publico(A,B,C)) :- preco_publico(A,B,incerto).
-preco_publico(A,B,C) :- nao(preco_publico(A,B,C)), nao(excepcao(preco_publico(A,B,C))).

% Estensao do predicado regime_especial: Medicamento, Apresentacao, Escalao, Preco -> {V,F,D}

regime_especial('ben-u-ron', 'Comprimidos', A, 3).
regime_especial('ben-u-ron', 'Comprimidos', B, incerto).

excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, B, incerto, D).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, incerto, C, D).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(incerto, B, C, D).
excepcao(regime_especial(A,B,C,D)) :- regime_especial(A, B, C, incerto).
-regime_especial(A,B,C,D) :- nao(regime_especial(A,B,C,D)), nao(excepcao(regime_especial(A,B,C,D))).

% Estensao do predicado data_validade: Medicamento, Apresentacao, Dia, Mes, Ano -> {V,F,D}

data_validade('ben-u-ron', 'Comprimidos', 23, 10, 2013).

excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,C,incerto,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,incerto,D,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,incerto,C,D,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(incerto,B,C,D,E).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,C,D,incerto).
excepcao(data_validade(A,B,C,D,E)) :- data_validade(A,B,incerto,incerto,incerto).
-data_validade(A,B,C,D,E) :- nao(data_validade(A,B,C,D,E)), nao(excepcao(data_validade(A,B,C,D,E))).

% Estensao do predicado data_introducao: Medicamento, Apresentacao, Dia, Mes, Ano -> {V,F,D}

data_introducao('ben-u-ron', 'Comprimidos', 23, 02, 2013).

excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,C,incerto,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,incerto,D,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,incerto,C,D,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(incerto,B,C,D,E).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,C,D,incerto).
excepcao(data_introducao(A,B,C,D,E)) :- data_introducao(A,B,incerto,incerto,incerto).
-data_introducao(A,B,C,D,E) :- nao(data_introducao(A,B,C,D,E)), nao(excepcao(data_introducao(A,B,C,D,E))).

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
insercao(Termo)	:-
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
eliminarElemento([H|T], E, Res)	:-
	H \== E,
	eliminarElemento(T, E, R_e_elem),
	Res = [H|R_e_elem] .

