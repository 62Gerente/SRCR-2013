%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic ciencia/1.
:- dynamic seres/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento

ciencia( zoologia ).
seres ( eucariontes ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Animal' ),nl,
    in( demo( animal,Questao ) ),
    write( 'demo( animal,Questao )' ),nl,
    demo( animal,Questao ),
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
