%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- dynamic e_um/3.
:- dynamic e_um/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe,Cancelar -> {V,F}

e_um(ave, animal, []).
e_um(mamifero, animal, []).
e_um(avestruz, ave, [locomocao(_)]).
e_um(golfinho, mamifero, [locomocao(aerea), locomocao(terrestre)]).
e_um(batman, ave, [cobertura(X),reproducao(X),alimento(X)] ).
e_um(batman, mamifero, [locomocao(terrestre),locomocao(aquatica)]).

e_um(ave, animal).
%e_um(mamifero, animal).
e_um(avestruz, ave).
e_um(golfinho, mamifero).
e_um(batman, ave).
e_um(batman, mamifero).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inicializacao da vida do agente

demo :-
    write( 'Estrutura' ),nl,
    in( demo( estrutura,Agente,Questao ) ),
    write( demo( estrutura,Agente,Questao ) ),nl,
    demo( estrutura,Agente,Questao ),
    demo.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Estrutura,Agente,Questao -> {V,F}

demo( estrutura,Agente,Questao ) :-
    write( (Agente ) ),nl,
    e_um(Agente,Classe,Lista),
    nao(pertence(Questao,Lista)),
%    write( ( 1,Agente::Classe ) ),nl,
    out( demo( Classe,Questao ) ).
demo( estrutura,Agente,Questao ) :-
    write( ( 2,nao ) ),nl,
    out( prova( Agente,nao ) ).

pertence(X, [X|T]).
pertence(Questao, [X|T]):- pertence(Questao, T).  


nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).
