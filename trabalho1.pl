%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% TRABALHO DE GRUPO - EXERCÍCIO 1

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacão relativa a uma árvore genealógica familiar.

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
:- dynamic filho/2.
:- dynamic natural/2.

% Invariante Estrutural:  nao permitir a insercao de conhecimento repetido

+filho(F,P) :: (solucoes((F,P),(filho( F,P )), S),
				comprimento( S,N ), N == 1
				).

+natural(I,L) :: (solucoes((I,L),(natural( I,L )), S),
				comprimento( S,N ), N == 1
				).


% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo

+filho( F,P ) :: (soluccoes( Ps, (filho(F, Ps)), S ),
				 comprimento( S,N ), N =< 2
				 ).

+natural( I,L ) :: (soluccoes( Ls, (natural(I, Ls)), S ),
				 comprimento( S,N ), N == 1
				 ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho(zacarias,zeca).
filho(zacarias,tina).

filho(fatima,zeca).
filho(fatima,tina).

filho(zecaj,lena).
filho(zecaj,zacarias).

filho(alice,zecaj).
filho(alice,susana).

filho(marcos,fatima).
filho(marcos,telmo).

filho(maria,fatima).
filho(maria,telmo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai( P,F ) :- filho( F,P ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tio: Tio,Sobrinho -> {V,F}

tio(T,S) :- irmao(T,X), filho(S,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sobrinho: Sobrinho,Tio -> {V,F}

sobrinho(S,T) :- tio(T,S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado primo: Primo,Primo -> {V,F}

primo(P1, P2) :- filho(P1,X), tio(X,P2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado irmao: Irmao,Irmao -> {V,F}

irmao(I1, I2) :- filho(I1,X), filho(I2,X), I1 \== I2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A, N) :- 
	filho(X, A),
	filho(N, X) .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Neto,Avo -> {V,F}

neto(N, A) :-
	avo(A, N) .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo(B, N) :-
	filho(X, B),
	filho(Y, X),
	filho(N, Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisneto: Bisneto,Bisavo -> {V,F}

bisneto(N, B) :-
	bisavo(B, N) .


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

descendente(D,A) :- filho(D,A);filho(D,N),descendente(N,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D,A,1) :- filho(D,A).
descendente(D,A,Z) :- filho(D,N),descendente(N,A,G), Z is G+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendente: Ascendente,Descendente -> {V,F}

ascendente(A,D) :- descendente(D,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendente: Ascendente,Descendente,Grau -> {V,F}

ascendente(A,D,Z) :- descendente(D,A,Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado nao: Questao -> {V,F}

nao(Questao) :-
	Questao, !, fail .
nao(Questao) .


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado solucoes: X,Teorema,Solucoes -> {V, F}

solucoes(X, Teorema, Solucoes) :-
	Teorema, assert(temp(X)), fail. 
solucoes(X, Teorema, Solucoes) :-
	assert(temp(fim)), construir(Solucoes).

construir(Solucoes) :-
	retract(temp(Y)), !,
		(Y==fim, !, Solucoes=[];
		Solucoes=[Y | Resto], construir(Resto)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

inserirConhecimento(Termo) :-
	solucoes( Invariante, +Termo::Invariante, Lista),
	insercao(Termo),
	teste( Lista ).

insercao(Termo) :-
	assert(Termo) .
insercao(Termo)	:-
	retract(Termo), !, fail .

removerConhecimento(Termo) :-
	solucoes( Invariante, +Termo::Invariante, Lista),
	remocao(Termo),
	teste( Lista ).

remocao(Termo) :-
	retract(Termo) .
remocao(Termo)	:-
	assert(Termo), !, fail .	

teste([]) .
teste([H|T]) :-
	H, teste(T) .


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado comprimento: L, R -> {V, F}

comprimento([], 0) .
comprimento([H|T], R) :-
	comprimento(T, X),
	R is 1+X .
