%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- op( 800,xfx,'??' ).
:- dynamic '??'/2.
:- dynamic '-'/1.
:- dynamic ciencia/2.
:- dynamic seres/2.
:- dynamic e_um/2.
:- dynamic cor/2.
:- dynamic alimento/2.
:- dynamic comunicacao/2.
:- dynamic data_registo/2.
:- dynamic cobertura/2.
:- dynamic locomocao/2.
:- dynamic reproducao/2.
:- dynamic ciencia/2.
:- dynamic seres/2.
:- dynamic excepcao/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Animal' ),nl,
    in( demo( animal,Questao ) ),
    write( demo( animal,Questao ) ),nl,
    demo( animal,Questao ),
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
    nao(-(Agente??Questao)),
    write('e desconhecido'), nl,
    out(prova(Agente,Questao,desconhecido)).
demo( Agente,Questao ) :-
    write('Vou enviar a estrutura'), nl,
    out(demo(estrutura,Agente,Questao)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ciencia: Animal,Ciencia -> {V,F}

animal ?? ciencia( zoologia ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??ciencia(A)) :: (findall((A), Ag??ciencia( A), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-(Ag??ciencia(A)) :- nao(Ag??ciencia(A)), nao(excepcao(Ag??ciencia(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado seres: Animal,Seres -> {V,F}

animal ?? seres(eucariontes).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??seres(A)) :: (findall(A, Ag??seres( A), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-(Ag??seres(A)) :- nao(Ag??seres(A)), nao(excepcao(Ag??seres(A))).


-(Agente??Questao) :- nao(Agente??Questao), nao(excepcao(Agente??Questao)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a inserção de conhecimento: Termo -> {v, F}

inserirConhecimento(Termo) :-
        findall( Invariante, +(Termo)::Invariante, Lista),
        insercao(Termo),
        teste( Lista ).

insercao(Termo) :-
        assert(Termo) .
insercao(Termo) :-
        retract(Termo), !, fail .

teste([]) .
teste([H|T]) :-
        H, teste(T) .  


nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a remoção de conhecimento: Termo -> {v, F}

removerConhecimento(Termo) :-
        findall( Invariante, -(Termo)::Invariante, Lista),
        teste( Lista ) ,
        remocao(Termo).
        
remocao(Termo) :-
        retract(Termo).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado comprimento: L, R -> {V, F}

comprimento([], 0) .
comprimento([H|T], R) :-
	comprimento(T, X),
	R is 1+X .
