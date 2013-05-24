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
:- dynamic cobertura/1.
:- dynamic locomocao/1.
:- dynamic comunicacao/1.
:- dynamic reproducao/1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento

avestruz :: cor( preto ).
avestruz :: cor( cinzento ).
avestruz :: alimento( ervas ).
avestruz :: alimento( vertebrados ).
avestruz :: alimento( invertebrados ).
avestruz :: cobertura( penas ).
avestruz :: locomocao( terrestre ).
avestruz :: comunicacao( pio ).
avestruz :: reproducao( oviparo ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Batman' ),nl,
    in( demo( batman,Questao ) ),
    write( 'demo( batman,Questao )' ),nl,
    demo( avestruz,Questao ),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo( Agente,Questao ) :-
    Agente::Questao,
    write( ( 1,Agente::Questao ) ),nl,
    out( prova( Agente,Questao ) ).
demo( Agente,Questao ) :-
    e_um( Agente,Classe ),
    write( ( 2,e_um( Agente,Classe ) ) ),nl,
    out( demo( Classe,Questao ) ).
demo( Agente,Questao ) :-
    write( ( 3,nao ) ),nl,
    out( prova( Agente,nao ) ).





%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
