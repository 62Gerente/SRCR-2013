%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic '-'/1.
:- dynamic alimento/1.
:- dynamic cobertura/1.
:- dynamic locomocao/1.
:- dynamic reproducao/1.
:- dynamic e_um/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento

mamifero :: cobertura( pelos ).
mamifero :: locomocao( terrestre ).
mamifero :: locomocao( aerea ).
mamifero :: locomocao( aquatica ).
mamifero :: reproducao( viviparo ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Mamífero' ),nl,
    in( demo( mamifero,Questao ) ),
    write( demo( mamifero,Questao ) ),nl,
    demo( mamifero,Questao ),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo( Agente,Questao ) :-
    Agente::Questao,
    write( ( 1,Agente::Questao ) ),nl,
    out( prova( Agente,Questao ) ).
demo( Agente,Questao ) :-
    out(demo(estrutura,Agente,Questao)).
demo( Agente,Questao ) :-
    write( ( 3,nao ) ),nl,
    out( prova( Agente,nao ) ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
