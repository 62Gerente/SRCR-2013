%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic cor/1.
:- dynamic alimento/1.
:- dynamic comunicacao/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento

batman :: cor( preto ).
batman :: alimento( fruta ).
batman :: alimento( legumes ).
batman :: comunicacao( ultra-som ).


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
% Iniciaizacao da vida do agente

demo :-
    write( 'Batman' ),nl,
    in( demo( ave,Questao ) ),
    write( 'demo( ave,Questao )' ),nl,
    demo( ave,Questao ),
    demo.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado localizacao: Ave,Localizacao -> {V,F}

localizacao( batman, incerto ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+localizacao(A,B) :: (findall((A,B),localizacao( A,B ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-localizacao(A,B) :- nao(localizacao(A,B)), nao(excepcao(localizacao(A,B))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(localizacao(A,B)):- localizacao(batman, incerto).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
