%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais


:- use_module( library( 'linda/client' ) ).
:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic cor/1.
:- dynamic alimento/1.
:- dynamic locomocao/1.
:- dynamic comunicacao/1.
:- dynamic e_um/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento




golfinho :: cor( cinzento ).
golfinho :: alimento( peixes ).
golfinho :: locomocao( aquatica ).
golfinho :: comunicacao( ultra-som ).

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

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
