%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- op( 800,xfx,'??' ).
:- dynamic '-'/1.
:- dynamic '??'/2.
:- dynamic cor/2.
:- dynamic alimento/2.
:- dynamic cobertura/2.
:- dynamic locomocao/2.
:- dynamic comunicacao/2.
:- dynamic reproducao/2.
:- dynamic e_um/2.
:- dynamic ciencia/2.
:- dynamic seres/2.
:- dynamic nome_cientifico/2.
:- dynamic excepcao/1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Carregamento das bibliotecas

:- use_module(library('linda/client')).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Avestruz' ),nl,
    in( demo( avestruz,Questao ) ),
    write( 'demo( avestruz,Questao )' ),nl,
    demo( avestruz,Questao ),
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
% Extensao do predicado cor: Avestruz,Cor -> {V,F}

avestruz ?? cor( preto ).
avestruz ?? cor( cinzento ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??cor(A,B)) :: (findall(A, Ag??cor( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-(Ag??cor(A)) :- nao(Ag??cor(A)), nao(excepcao(Ag??cor(A))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado alimento: Avestruz,Alimento -> {V,F}

avestruz ?? alimento( ervas ).
avestruz ?? alimento( vertebrados ).
avestruz ?? alimento( invertebrados ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??alimento(A)) :: (findall(A, Ag??alimento( A ), S),
                                comprimento( S,N ), N == 1
                                ).


%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-(Ag??alimento(A)) :- nao(Ag??alimento(A)), nao(excepcao(Ag??alimento(A))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado cobertura: Avestruz,Cobertura -> {V,F}

avestruz ?? cobertura( penas ).


%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??cobertura(A)) :: (findall(A, Ag??cobertura( A ), S),
                                comprimento( S,N ), N == 1
                                ).



-(Ag??cobertura(A)) :- nao(Ag??cobertura(A)), nao(excepcao(Ag??cobertura(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado locomocao: Avestruz,Locomocao -> {V,F}

avestruz ?? locomocao( terrestre ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??locomocao(A)) :: (findall(A, Ag??locomocao( A ), S),
                                comprimento( S,N ), N == 1
                                ).


-(Ag??locomocao(A)) :- nao(Ag??locomocao(A)), nao(excepcao(Ag??locomocao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado reproducao: Avestruz,Reproducao -> {V,F}

avestruz ?? reproducao( oviparo ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??reproducao(A)) :: (findall(A, Ag??reproducao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

-(Ag??reproducao(A)) :- nao(Ag??reproducao(A)), nao(excepcao(Ag??reproducao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comunicacao: Avestruz,Comunicacao -> {V,F}

avestruz ?? comunicacao( pio ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??comunicacao(A)) :: (findall(A, Ag??comunicacao( A ), S),
                                comprimento( S,N ), N == 1
                                ).

-(Ag??comunicacao(A)) :- nao(Ag??comunicacao(A)), nao(excepcao(Ag??comunicacao(A))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado nome_cientifico: Batman,Nome Científico  -> {V,F}

avestruz ?? nome_cientifico( incerto ).

%%%%%%%%%%  Invariantes   %%%%%%%%%%

%% Não pode haver conhecimento repetido %%
+(Ag??nome_cientifico(A)) :: (findall(A, Ag??nome_cientifico( A ), S),
                                comprimento( S,N ), N == 1
                                ).

%%%%%%%%%%   Conhecimento negativo    %%%%%%%%%%
-(Ag??nome_cientifico(A)) :- nao(Ag??nome_cientifico(A)), nao(excepcao(Ag??nome_cientifico(A))).

%%%%%%%%%%   Excepções    %%%%%%%%%%
excepcao(Ag??nome_cientifico(A)):- Ag??nome_cientifico( incerto).



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
