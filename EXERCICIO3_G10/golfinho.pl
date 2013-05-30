%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais


:- use_module( library( 'linda/client' ) ).
:- op( 900,xfy,'::' ).
:- op( 800,xfx,'??' ).
:- dynamic '-'/1.
:- dynamic cor/2.
:- dynamic alimento/1.
:- dynamic locomocao/1.
:- dynamic cobertura/1.
:- dynamic comunicacao/1.
:- dynamic e_um/2.
:- dynamic data_registo/1.
:- dynamic reproducao/1.
:- dynamic ciencia/1.
:- dynamic seres/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inicializacao da vida do agente

demo :-
    write( 'Golfinho' ),nl,
    in( demo( golfinho,Questao ) ),
    write( demo( golfinho,Questao ) ),nl,
    demo( golfinho,Questao ),
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
% Extensao do predicado cor: Golfinho,Cor -> {V,F}

golfinho ?? cor( cinzento ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??cor(C) :: (findall(C, Ag??cor(C), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??cor(C) :- nao(Ag??cor(C)), nao(excepcao(Ag??cor(C))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado alimento: Golfinho,Alimento -> {V,F}

golfinho ?? alimento( peixes ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??alimento(A) :: (findall(A , Ag??( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??alimento(A) :- nao(Ag??alimento(A)), nao(excepcao(Ag??alimento(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comunicacao: Golfinho,Comunicacao -> {V,F}

golfinho ?? comunicacao( ultra-som ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??comunicacao(A) :: (findall(A,Ag??comunicacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??comunicacao(A) :- nao(Ag??comunicacao(A)), nao(excepcao(Ag??comunicacao(A))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado locomocao: Golfinho,Locomocao -> {V,F}

golfinho ?? locomocao( aquatica ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??locomocao(A) :: (findall(A,Ag??locomocao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??locomocao(A) :- nao(Ag??locomocao(A)), nao(excepcao(Ag??locomocao(A))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado localizacao: Golfinho,Localizacao -> {V,F}


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+Ag??localizacao(A) :: (findall(A,localizacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-Ag??localizacao(A) :- nao(Ag??localizacao(A)), nao(excepcao(Ag??localizacao(A))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(Ag??localizacao(B)):- B=='Atlantico'; B=='Pacifico'.





-Agente??Questao:- nao(Agente??Questao), nao(excepcao(Agente??Questao)).



nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).


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
