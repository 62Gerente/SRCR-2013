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
:- dynamic e_um/2.
:- dynamic cor/2.
:- dynamic comunicacao/2.
:- dynamic data_registo/2.
:- dynamic ciencia/2.
:- dynamic seres/2.


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
    Agente??Questao,
    %write( ( 1,Agente,Questao ) ),nl,
    write('e verdade'), nl,
    out( prova( Agente,Questao,verdade ) ).
demo( Agente, Questao):- 
    nao(Agente??Questao),
    nao(-Agente??Questao),
    write('e desconhecido'), nl,
    out(prova(Agente,Questao,desconhecido)).
demo( Agente,Questao ) :-
    write('Vou enviar a estrutura'), nl,
    out(demo(estrutura,Agente,Questao)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado alimento: Ave,Alimento -> {V,F}

ave ?? alimento( sementes ).
ave ?? alimento( insectos ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??alimento(A) :: (findall(A,Ag??alimento( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??alimento(A) :- nao(Ag??alimento(A)), nao(excepcao(Ag??alimento(A))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado cobertura: Ave,Cobertura -> {V,F}

ave ?? cobertura( penas ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??cobertura(A) :: (findall(A,Ag??cobertura( A ), S),
                                comprimento( S,N ), N == 1
                                ).



-Ag??cobertura(A,B) :- nao(Ag??cobertura(A)), nao(excepcao(Ag??cobertura(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado locomocao: Ave,Locomocao -> {V,F}

ave ?? locomocao( voo ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??locomocao(A) :: (findall(A,Ag??locomocao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


-Ag??locomocao(A) :- nao(Ag??locomocao(A)), nao(excepcao(Ag??locomocao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado reproducao: Ave,Reproducao -> {V,F}

ave ?? reproducao( oviparo ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??reproducao(A) :: (findall(A,Ag??reproducao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

-Ag??reproducao(A) :- nao(Ag??reproducao(A)), nao(excepcao(Ag??reproducao(A))).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado comprimento: L, R -> {V, F}

comprimento([], 0) .
comprimento([H|T], R) :-
        comprimento(T, X),
        R is 1+X .



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a inserção de conhecimento: Termo -> {v, F}

inserirConhecimento(Termo) :-
        findall( Invariante, +Termo::Invariante, Lista),
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
        findall( Invariante, -Termo::Invariante, Lista),
        teste( Lista ) ,
        remocao(Termo).
        
remocao(Termo) :-
        retract(Termo).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
