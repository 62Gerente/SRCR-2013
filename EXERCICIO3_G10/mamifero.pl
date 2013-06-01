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
:- dynamic alimento/1.
:- dynamic cor/1.
:- dynamic cobertura/1.
:- dynamic locomocao/1.
:- dynamic reproducao/1.
:- dynamic e_um/2.
:- dynamic comunicacao/1.
:- dynamic data_registo/1.
:- dynamic ciencia/1.
:- dynamic seres/1.
:- dynamic excepcao/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Mamifero' ),nl,
    in( demo( mamifero,Questao ) ),
    write( demo( mamifero,Questao ) ),nl,
    demo( mamifero,Questao ),
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
% Extensao do predicado cobertura: Mamifero,Cobertura -> {V,F}

mamifero ?? cobertura( pelos ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??cobertura(A)) :: (findall(A, Ag??cobertura( A), S),
                                comprimento( S,N ), N == 1
                                ).



-(Ag??cobertura(A)) :- nao(Ag??cobertura(A)), nao(excepcao(Ag??cobertura(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado locomocao: Mamifero,Locomocao -> {V,F}

mamifero ?? locomocao( terrestre ).
mamifero ?? locomocao( aerea ).
mamifero ?? locomocao( aquatica ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??locomocao(A)) :: (findall(A, Ag??locomocao( A), S),
                                comprimento( S,N ), N == 1
                                ).


-(Ag??locomocao(A)) :- nao(Ag??locomocao(A)), nao(excepcao(Ag??locomocao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado reproducao: Mamifero,Reproducao -> {V,F}

mamifero??reproducao( viviparo ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??reproducao(A)) :: (findall(A, Ag??reproducao( A), S),
                                comprimento( S,N ), N == 1
                                ).

-(Ag??reproducao(A)) :- nao(Ag??reproducao(A)), nao(excepcao(Ag??reproducao(A))).


-(Agente??Questao) :- nao(Agente??Questao), nao(excepcao(Agente??Questao)).

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).


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
