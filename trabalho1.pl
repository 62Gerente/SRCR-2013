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

+filho(F,P) :: (solucoes((F,P),filho( F,P ), S),
				comprimento( S,N ), N == 1
				).

+natural(I,L) :: (solucoes((I,L),natural( I,L ), S),
				comprimento( S,N ), N == 1
				).


% Invariante Referencial: 
%                         

+filho( F,P ) :: (solucoes( (Ps), filho(F, Ps), S ),
				 comprimento( S,N ), N =< 2
				 ).

+natural( I,L ) :: (solucoes( (Ls), natural(I, Ls), S ),
				 comprimento( S,N ), N == 1
				 ).

+filho( F,P ) :: nao(descendente(P,F,N)).

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

pai( P,F ) :- 
	filho( F,P ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tio: Tio,Sobrinho -> {V,F}

tio(T,S) :- 
	irmao(T,X), filho(S,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sobrinho: Sobrinho,Tio -> {V,F}

sobrinho(S,T) :- 
	tio(T,S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado primo: Primo,Primo -> {V,F}

primo(P1, P2) :- 
	filho(P1,X), 
	tio(X,P2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado irmao: Irmao,Irmao -> {V,F}

irmao(I1, I2) :- 
	filho(I1,X), 
	filho(I2,X), 
	I1 \== I2.

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
% Extensao do predicado casado: C1,C2 -> {V,F}

casado(C1, C2) :-
	filho(X,C1),
	filho(X,C2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

descendente(D,A) :- 
	filho(D,A);
	filho(D,N),
	descendente(N,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D,A,1) :- 
	filho(D,A).
descendente(D,A,Z) :- 
	filho(D,N),
	descendente(N,A,G), 
	Z is G+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendente: Ascendente,Descendente -> {V,F}

ascendente(A,D) :- 
	descendente(D,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendente: Ascendente,Descendente,Grau -> {V,F}

ascendente(A,D,Z) :- 
	descendente(D,A,Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado nao: Questao -> {V,F}

nao(Questao) :-
	Questao, !, fail .
nao(Questao) .


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

%removerConhecimento(Termo) :-
%	solucoes( Invariante, -Termo::Invariante, Lista),
%	teste( Lista ),
%	remocao(Termo) .
%
%remocao(Termo) :-
%	retract(Termo) .
%remocao(Termo)	:-
%	assert(Termo), !, fail .


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
% Extensão do predicado relacao: I1, I2, R -> {V, F}

relacao(I1,I2, filho) :-
	 filho(I1,I2). 
relacao(I1,I2, pai) :-
	 pai(I1,I2). 
relacao(I1,I2, tio) :-
	 tio(I1,I2). 
relacao(I1,I2, sobrinho) :-
	 sobrinho(I1,I2). 
relacao(I1,I2, avo) :-
	 avo(I1,I2). 
relacao(I1,I2, neto) :-
	 neto(I1,I2). 
relacao(I1,I2, bisavo) :-
	 bisavo(I1,I2). 
relacao(I1,I2, bisneto) :-
	 bisneto(I1,I2).
relacao(I1,I2, casado) :-
	 casado(I1,I2). 
relacao(I1,I2, irmao) :-
	 irmao(I1,I2). 
relacao(I1,I2, primo) :-
	 primo(I1,I2).
relacao(I1,I2, Z) :-
	 descendente(I1,I2,N), 
	 Z = descendente\ de\ grau\ N.
relacao(I1,I2, Z) :-
	 ascencente(I1,I2,N),
	 Z = ascendente\ de\ grau\ N.
relacao(I1,I2,desconhecido). 
