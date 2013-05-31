%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic cor/2.
:- dynamic alimento/2.
:- dynamic comunicacao/2.
:- dynamic e_um/2.
:- dynamic data_registo/2.
:- dynamic cobertura/2.
:- dynamic locomocao/2.
:- dynamic reproducao/2.
:- dynamic ciencia/2.
:- dynamic seres/2.
:- dynamic localizacao/2.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Batman' ),nl,
    in( demo( batman,Questao ) ),
    write( 'demo( batman,Questao )' ),nl,
    demo( batman,Questao ),
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
% Extensao do predicado cor: Batman,Cor -> {V,F}

batman ?? cor( preto ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??cor(A) :: (findall(A,cor( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??cor(A) :- nao(Ag??cor(A)), nao(excepcao(Ag??cor(A))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado alimento: Batman,Alimento -> {V,F}

batman ?? alimento( fruta ).
batman ?? alimento( legumes ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+AAg??alimento(A) :: (findall(A,alimento( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??alimento(A) :- nao(Ag??alimento(A)), nao(excepcao(Ag??alimento(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comunicacao: Batman,Comunicacao -> {V,F}

batman ?? comunicacao( ultra-som ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??comunicacao(A) :: (findall(A,comunicacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??comunicacao(A) :- nao(Ag??comunicacao(A)), nao(excepcao(Ag??comunicacao(A))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado localizacao: Batman,Localizacao -> {V,F}

batman ?? localizacao( incerto ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??localizacao(A) :: (findall(A,localizacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??localizacao(A) :- nao(Ag??localizacao(A)), nao(excepcao(Ag??localizacao(A))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(Ag??localizacao(A)):- Ag??localizacao( incerto).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado data_registo: Batman,Data -> {V,F}

batman ?? data_registo( data_nula ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??data_registo(A) :: (findall(A,data_registo( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%% Não permitir que a data de introducao do cegripe em comprimidos venha a ser inserida %%
+data_registo(A) :: (findall((B_X), (Aga??data_registo( B_X), nao(nulo(B_X))), [])).


%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??data_registo(A) :- nao(Ag??data_registo(A)), nao(excepcao(Ag??data_registo(A))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(Ag??data_registo(A)):- Ag??data_registo( data_nula).



%%%%%%%%%%%%%%%%%%   NULO   %%%%%%%%%%%%%%%%%%%
% Extensao do meta-predicado nulo: Valor -> {V,F}


nulo(data_nula).



-Agente??Questao:- nao(Agente??Questao), nao(excepcao(Agente??Questao)).


nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).


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
