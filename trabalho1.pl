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
% Extensao do predicado filhos: Individuo, Resultado -> {V,F}

filhos(I, R) :-
	solucoes(F, filho(F, I), S),
	R = S .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai( P,F ) :- 
	filho( F,P ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pais: Individuo, Resultado -> {V,F}

pais(I, R) :-
	solucoes(P, pai(P, I), S),
	R = S .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tio: Tio,Sobrinho -> {V,F}

tio(T,S) :- 
	irmao(T,X), filho(S,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tios: Individuo, Resultado -> {V,F}

tios(I, R) :-
	solucoes(T, tio(T, I), S),
	eliminarRepetidos(S, R_e_r),
	R = R_e_r .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sobrinho: Sobrinho,Tio -> {V,F}

sobrinho(S,T) :- 
	tio(T,S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sobrinhos: Individuo, Resultado -> {V,F}

sobrinhos(I, R) :-
	solucoes(Sobr, sobrinho(Sobr, I), S),
	eliminarRepetidos(S, R_e_r),
	R = R_e_r .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado primo: Primo,Primo -> {V,F}

primo(P1, P2) :- 
	filho(P1,X), 
	tio(X,P2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado primos: Individuo, Resultado -> {V,F}

primos(I, R) :-
	solucoes(Pr, primo(Pr, I), S),
	eliminarRepetidos(S, R_e_r),
	R = R_e_r .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado irmao: Irmao,Irmao -> {V,F}

irmao(I1, I2) :- 
	filho(I1,X), 
	filho(I2,X), 
	I1 \== I2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado irmaos: Individuo, Resultado -> {V,F}

irmaos(I, R) :-
	solucoes(Irm, irmao(Irm, I), S),
	eliminarRepetidos(S, R_e_r),
	R = R_e_r .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A, N) :- 
	filho(X, A),
	filho(N, X) .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avos: Individuo, Resultado -> {V,F}

avos(I, R) :-
	solucoes(A, avo(A, I), S),
	R = S .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Neto,Avo -> {V,F}

neto(N, A) :-
	avo(A, N) .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado netos: Individuo, Resultado -> {V,F}

netos(I, R) :-
	solucoes(N, neto(N, I), S),
	R = S .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo(B, N) :-
	filho(X, B),
	filho(Y, X),
	filho(N, Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavos: Individuo, Resultado -> {V,F}

bisavos(I, R) :-
	solucoes(Ba, bisavo(Ba, I), S),
	R = S .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisneto: Bisneto,Bisavo -> {V,F}

bisneto(N, B) :-
	bisavo(B, N) .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisnetos: Individuo, Resultado -> {V,F}

bisnetos(I, R) :-
	solucoes(Bn, bisneto(Bn, I), S),
	R = S .

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
% Extensao do predicado descendentes: Individuo, Resultado -> {V,F}

descendentes(I, R) :-
	solucoes(D, descendente(D, I), S),
	R = S .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D,A,1) :- 
	filho(D,A).
descendente(D,A,Z) :- 
	filho(D,N),
	descendente(N,A,G), 
	Z is G+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendentes: Individuo, Grau, Resultado -> {V,F}

descendentes(I, G, R) :-
	solucoes(D, descendente(D, I, G), S),
	R = S .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendenteAteGrau: Descendente,Ascendente,Grau -> {V,F}

descendenteAteGrau(D,A,N) :- 
	descendente(D,A,Z), 
	Z=<N.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendentesAteGrau: Individuo, Grau, Resultado -> {V,F}

descendentesAteGrau(I, G, R) :-
	solucoes(D, descendenteAteGrau(D, I, G), S),
	R = S .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendente: Ascendente,Descendente -> {V,F}

ascendente(A,D) :- 
	descendente(D,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendentes: Individuo, Resultado -> {V,F}

ascendentes(I, R) :-
	solucoes(A, ascendente(A, I), S),
	R = S .	

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendente: Ascendente,Descendente,Grau -> {V,F}

ascendente(A,D,Z) :- 
	descendente(D,A,Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendentes: Individuo, Grau, Resultado -> {V,F}

ascendentes(I, G, R) :-
	solucoes(A, ascendente(A, I, G), S),
	R = S .

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendenteAteGrau: Ascendente,Descendente,Grau -> {V,F}

ascendenteAteGrau(D,A,N) :- 
	 descendenteAteGrau(A,D,N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ascendentesAteGrau: Individuo, Grau, Resultado -> {V,F}

ascendentesAteGrau(I, G, R) :-
	solucoes(A, ascendenteAteGrau(A, I, G), S),
	R = S .

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
