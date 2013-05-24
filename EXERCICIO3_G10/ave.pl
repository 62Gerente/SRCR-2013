%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic alimento/2.
:- dynamic cobertura/2.
:- dynamic locomocao/2.
:- dynamic reproducao/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Ave' ),nl,
    in( demo( ave,Questao ) ),
    write( 'demo( ave,Questao )' ),nl,
    demo( ave,Questao ),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo( Agente,Questao ) :-
    Questao,
    write( ( 1,Agente,Questao ) ),nl,
    out( prova( Agente,Questao,verdade ) ).
demo( Agente, Questao):- 
    nao(Questao),
    nao(-Questao),
    out(prova(Agente,Questao,desconhecido)).
demo( Agente,Questao ) :-
    out(demo(estrutura,Agente,Questao)).
%demo( Agente,Questao ) :-
%    write( ( 3,nao ) ),nl,
%    out( prova( Agente,nao ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado alimento: Ave,Alimento -> {V,F}

ave :: alimento( sementes ).
ave :: alimento( insectos ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+alimento(A,B) :: (findall((A,B),alimento( A,B ), S),
                                comprimento( S,N ), N == 1
                                ).


%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-alimento(A,B) :- nao(alimento(A,B)), nao(excepcao(alimento(A,B))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado cobertura: Ave,Cobertura -> {V,F}

cobertura( ave, penas ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+cobertura(A,B) :: (findall((A,B),cobertura( A,B ), S),
                                comprimento( S,N ), N == 1
                                ).



-cobertura(A,B) :- nao(cobertura(A,B)), nao(excepcao(cobertura(A,B))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado locomocao: Ave,Locomocao -> {V,F}

locomocao( ave, voo ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+locomocao(A,B) :: (findall((A,B),locomocao( A,B ), S),
                                comprimento( S,N ), N == 1
                                ).


-locomocao(A,B) :- nao(locomocao(A,B)), nao(excepcao(locomocao(A,B))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado reproducao: Ave,Reproducao -> {V,F}

reproducao( ave, oviparo ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+reproducao(A,B) :: (findall((A,B),reproducao( A,B ), S),
                                comprimento( S,N ), N == 1
                                ).

-reproducao(A,B) :- nao(reproducao(A,B)), nao(excepcao(reproducao(A,B))).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado comprimento: L, R -> {V, F}

comprimento([], 0) .
comprimento([H|T], R) :-
        comprimento(T, X),
        R is 1+X .



%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
