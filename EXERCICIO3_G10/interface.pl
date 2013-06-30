%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo( Agente,Questao, Res ) :-
    out(demo(Agente,Questao)),
    esperar(Questao, Res).
   

esperar(Questao, Res):- 
	rd_noblock(prova(Agente,Questao,R)),
   % in(prova(Agente,Questao,R)),
    Res = R .
    %write(prova(Agente,Questao,R)).
esperar(Questao, Res):-
	esperar(Questao, Res).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ),
    retirar(L).


retirar([]).
retirar([X|T]):- in(X), retirar(T).
