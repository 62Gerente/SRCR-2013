%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- dynamic e_um/3.
:- dynamic ciclos/1.
:- dynamic demo/3.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe,Cancelar -> {V,F}

e_um(ave, animal, []).
e_um(mamifero, animal, []).
e_um(avestruz, ave, [locomocao(_)]).
e_um(golfinho, mamifero, [locomocao(aerea), locomocao(terrestre)]).
e_um(golfinho, ave, []).
e_um(batman, ave, [cobertura(_),reproducao(_),alimento(_)] ).
e_um(batman, mamifero, [locomocao(terrestre),locomocao(aquatica)]).



ciclos(0).
max_ciclos(1000).


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
    retract(e_um(Agente,Classe,Lista)),
    assert(e_um(Agente,Classe,Lista)),
    nao(pertence(Questao,Lista)),
    write( 'Vou enviar ao ' ), write(Classe), nl,
    out( demo( Classe,Questao )),
    esperar(Classe,Questao).
demo( estrutura,Agente,Questao ) :-
    write( 'Nao' ),nl,
    out( prova( Agente,Questao,nao ) ).



esperar(Agente,Questao):- 
    (rd_noblock(prova(Agente,Questao,_));  
    rd_noblock(demo(estrutura,Agente,Questao))).
esperar(Agente,Questao):-
    max_ciclos(M),
    retract(ciclos(X)),
    X<M,
    assert(ciclos(X+1)),
    esperar(Agente,Questao).
esperar(Agente,Questao):-
    write('Nao foi possivel contactar o agente '),
    write(Agente),nl,
    assert(ciclos(0)),
    in( demo( Agente, Questao)),
    demo(estrutura,Agente,Questao).


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
