% vim: set ft=prolog:

:- use_module(library(plunit)).
:- use_module(library(clpfd)).

%  Um jogo é representado por uma estrutura jogo com 3 argumentos. O primeiro é
%  o número de linhas (L), o segundo o número de colunas (C) e o terceiro uma
%  lista (Blocos - de tamanho linhas x colunas) com os blocos do jogo. Nessa
%  representação os primeiros L elementos da lista Blocos correspondem aos
%  blocos da primeira linha do jogo, os próximos L blocos correspondem aos
%  blocos da segunda linha do jogo e assim por diante.
%
%  Dessa forma, em jogo com 3 linhas e 5 colunas (total de 15 blocos), os
%  blocos são indexados da seguinte forma:
%
%   0  1  2  3  4
%   5  6  7  8  9
%  10 11 12 13 14
%
%  Cada bloco é representado por uma estrutura bloco com 4 argumentos. Os
%  argumentos representam os valores da borda superior, direita, inferior e
%  esquerda (sentido horário começando do topo). Por exemplo o bloco
%
%  |  3  |
%  |4   6|  é representado por bloco(3, 6, 7, 4).
%  |  7  |
%
%  Dizemos que um bloco está em posição adequada se os valores das
%  bordas do bloco correspondem aos valores das bordas dos blocos
%  adjacentes na posição em que ele se encontra.
%
%  Dica: Implemente inicialmente o predicado bloco_adequado e depois
%  blocos_adequados. Crie predicados auxiliares se necessário. Depois que o
%  predicado jogo_solucao estiver funcionando, faça uma nova implementação
%  eficiente dele.

%% jogo_solucao(?JogoInicial, ?JogoFinal) is semidet
%
%  Verdadeiro se JogoInicial é uma estrutura jogo(L, C, Blocos) e JogoFinal é
%  uma estrutura jogo(L, C, Solucao), onde Solucao é uma solução válida para o
%  JogoInicial, isto é, os blocos que aparecem em Solucao são os mesmos de
%  Blocos e estão em posições adequadas.

jogo_solucao(JogoInicial, JogoFinal) :-
    jogo(L, C, Blocos) = JogoInicial,
    jogo(L, C, Solucao) = JogoFinal,
    blocos_adequados(JogoFinal),
    permutation(Blocos, Solucao).


:- begin_tests(pequeno).

test(j1x1, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 6, 7, 5)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(1, 1, Inicial), jogo(1, 1, Final)).


test(j2x2, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 4, 7, 9),
        bloco(6, 9, 5, 4),
        bloco(7, 6, 5, 2),
        bloco(5, 3, 1, 6)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(2, 2, Inicial), jogo(2, 2, Final)).

test(j3x3, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(7, 3, 4, 9),
        bloco(3, 4, 8, 3),
        bloco(7, 4, 2, 4),
        bloco(4, 4, 8, 5),
        bloco(8, 3, 6, 4),
        bloco(2, 2, 7, 3),
        bloco(8, 9, 1, 3),
        bloco(6, 6, 6, 9),
        bloco(7, 8, 5, 6)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(3, 3, Inicial), jogo(3, 3, Final)).

:- end_tests(pequeno).


:- begin_tests(medio).

test(j4x4, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(7, 7, 4, 8),
        bloco(3, 0, 2, 7),
        bloco(7, 9, 1, 0),
        bloco(1, 6, 3, 9),
        bloco(4, 2, 5, 5),
        bloco(2, 4, 5, 2),
        bloco(1, 5, 7, 4),
        bloco(3, 8, 0, 5),
        bloco(5, 5, 8, 0),
        bloco(5, 5, 9, 5),
        bloco(7, 6, 7, 5),
        bloco(0, 2, 1, 6),
        bloco(8, 7, 9, 5),
        bloco(9, 2, 8, 7),
        bloco(7, 3, 3, 2),
        bloco(1, 0, 4, 3)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(4, 4, Inicial), jogo(4, 4, Final)).

test(j5x5, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(1, 6, 7, 5),
        bloco(4, 0, 0, 6),
        bloco(9, 2, 0, 0),
        bloco(8, 3, 5, 2),
        bloco(0, 4, 5, 3),
        bloco(7, 1, 2, 6),
        bloco(0, 4, 5, 1),
        bloco(0, 0, 3, 4),
        bloco(5, 1, 1, 0),
        bloco(5, 3, 2, 1),
        bloco(2, 9, 1, 0),
        bloco(5, 5, 5, 9),
        bloco(3, 2, 2, 5),
        bloco(1, 0, 6, 2),
        bloco(2, 9, 0, 0),
        bloco(1, 0, 7, 0),
        bloco(5, 0, 7, 0),
        bloco(2, 4, 8, 0),
        bloco(6, 9, 4, 4),
        bloco(0, 0, 6, 9),
        bloco(7, 0, 2, 5),
        bloco(7, 2, 0, 0),
        bloco(8, 6, 1, 2),
        bloco(4, 4, 6, 6),
        bloco(6, 5, 8, 4)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(5, 5, Inicial), jogo(5, 5, Final)).

test(j6x6, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 0, 2, 4),
        bloco(9, 5, 5, 0),
        bloco(1, 1, 8, 5),
        bloco(4, 2, 0, 1),
        bloco(4, 3, 2, 2),
        bloco(8, 0, 0, 3),
        bloco(2, 2, 3, 9),
        bloco(5, 9, 1, 2),
        bloco(8, 2, 3, 9),
        bloco(0, 2, 3, 2),
        bloco(2, 9, 8, 2),
        bloco(0, 6, 9, 9),
        bloco(3, 1, 6, 9),
        bloco(1, 2, 2, 1),
        bloco(3, 0, 8, 2),
        bloco(3, 5, 8, 0),
        bloco(8, 7, 8, 5),
        bloco(9, 4, 8, 7),
        bloco(6, 0, 6, 9),
        bloco(2, 4, 5, 0),
        bloco(8, 7, 6, 4),
        bloco(8, 3, 7, 7),
        bloco(8, 7, 2, 3),
        bloco(8, 7, 1, 7),
        bloco(6, 3, 9, 0),
        bloco(5, 1, 9, 3),
        bloco(6, 9, 8, 1),
        bloco(7, 7, 0, 9),
        bloco(2, 0, 6, 7),
        bloco(1, 3, 7, 0),
        bloco(9, 9, 8, 7),
        bloco(9, 0, 6, 9),
        bloco(8, 1, 6, 0),
        bloco(0, 9, 7, 1),
        bloco(6, 1, 7, 9),
        bloco(7, 8, 1, 1)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(6, 6, Inicial), jogo(6, 6, Final)).

:- end_tests(medio).


:- begin_tests(grande).

test(j7x7, [nondet, Blocos = Final]) :-
    Blocos = [
        bloco(4, 1, 0, 8),
        bloco(7, 8, 1, 1),
        bloco(0, 3, 5, 8),
        bloco(4, 0, 9, 3),
        bloco(9, 7, 1, 0),
        bloco(6, 8, 3, 7),
        bloco(3, 5, 2, 8),
        bloco(0, 9, 5, 8),
        bloco(1, 4, 9, 9),
        bloco(5, 1, 6, 4),
        bloco(9, 3, 1, 1),
        bloco(1, 5, 6, 3),
        bloco(3, 3, 2, 5),
        bloco(2, 0, 4, 3),
        bloco(5, 1, 8, 8),
        bloco(9, 6, 8, 1),
        bloco(6, 5, 2, 6),
        bloco(1, 8, 6, 5),
        bloco(6, 4, 9, 8),
        bloco(2, 8, 2, 4),
        bloco(4, 1, 8, 8),
        bloco(8, 1, 5, 4),
        bloco(8, 2, 0, 1),
        bloco(2, 0, 2, 2),
        bloco(6, 4, 8, 0),
        bloco(9, 7, 7, 4),
        bloco(2, 8, 5, 7),
        bloco(8, 0, 7, 8),
        bloco(5, 6, 0, 8),
        bloco(0, 9, 4, 6),
        bloco(2, 2, 2, 9),
        bloco(8, 9, 5, 2),
        bloco(7, 1, 5, 9),
        bloco(5, 2, 0, 1),
        bloco(7, 9, 6, 2),
        bloco(0, 7, 5, 8),
        bloco(4, 7, 5, 7),
        bloco(2, 9, 1, 7),
        bloco(5, 7, 5, 9),
        bloco(5, 5, 4, 7),
        bloco(0, 8, 5, 5),
        bloco(6, 8, 7, 8),
        bloco(5, 7, 9, 6),
        bloco(5, 0, 2, 7),
        bloco(1, 4, 6, 0),
        bloco(5, 3, 2, 4),
        bloco(4, 9, 6, 3),
        bloco(5, 8, 1, 9),
        bloco(7, 8, 0, 8)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(7, 7, Inicial), jogo(7, 7, Final)).

:- end_tests(grande).

% blocos_adequados(?Jogo) is semidet
%
% Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), e todos os blocos de
% Blocos estão em posições adequadas.

% Verdadeiro se Blocos é vazio.
blocos_adequados(jogo(_, _, [])).

% Verdadeiro se Blocos é unitário.
blocos_adequados(jogo(1, 1, _)).

% Verdadeiro se todos os blocos estão na posição adequada.
blocos_adequados(jogo(L, C, Blocos)) :-
    X is L * C - 1,
    findall(P, between(0, X, P), Posicoes),
    maplist(bloco_adequado(jogo(L,C,Blocos)), Posicoes).


% Jogo 2x2 : Para um jogo 2x2, possuimos 4 blocos, Jogo2x2 = (bloco_1,
% bloco_2, bloco_3 e bloco_4), onde,
%
% Jogo2x2 = [bloco_0 , bloco_1,]
%           [bloco_3 , bloco_2 ]

%% bloco_adequado(?Jogo, +P) is semidet
%
% Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), e o bloco na posição
% P de Blocos está em uma posição adequada.

% Verdadeiro se o bloco_0 de Blocos é adequado para um jogo 2x2.
bloco_adequado(jogo(_, C, Blocos), P) :-
    P is 0, % Posição
    D is P + 1 , % Direita
    B is P + C , % Baixo
    nth0(D, Blocos, bloco(_, _, _, D1)),
    nth0(B, Blocos, bloco(B1, _, _, _)),
    nth0(P, Blocos, bloco(_, D2, B2, _)),
    B1 = B2,
    D1 = D2.

% Verdadeiro se o bloco_1 de Blocos é adequado para um jogo 2x2.
bloco_adequado(jogo(_, C, Blocos), P) :-
    P is C - 1, % Posição
    E is P - 1, % Esquerda
    B is P + C, % Baixo
    nth0(P, Blocos, bloco(_, _, C1, D1)),
    nth0(E, Blocos, bloco(_, D2, _, _)),
    nth0(B, Blocos, bloco(C2, _, _, _)),
    C1 = C2,
    D1 = D2.

% Verdadeiro se o Bloco_2 de Blocos é adequado para um jogo 2x2.
bloco_adequado(jogo(L, C, Blocos), P) :-
    P is (L * C - 1), % Posição
    E is P - 1, % Esquerda
    A is P - C, % Cima
    nth0(P, Blocos, bloco(A1, _, _, D1)),
    nth0(E, Blocos, bloco(_, D2, _, _)),
    nth0(A, Blocos, bloco(_, _, A2, _)),
    A1 = A2,
    D1 = D2.

% Verdadeiro se o bloco_3 de Blocos é adequado para um jogo 2x2.
bloco_adequado(jogo(L, C, Blocos), P) :-
    P is (L * C - L), % Posição
    D is P + 1, % Direita
    A is P - C, % Cima
    nth0(P, Blocos, bloco(A1, B1, _, _)),
    nth0(D, Blocos, bloco(_, _, _, B2)),
    nth0(A, Blocos, bloco(_, _, A2, _)),
    A1 = A2,
    B1 = B2.

% Verdadeiro se um Bloco x que se encontra na primeira linha é adequado.
bloco_adequado(jogo(_, C, Blocos), P) :-
    P #> 0,
    P #< C - 1,
    E is P - 1, % Esquerda
    D is P + 1, % Direita
    B is P + C, % Baixo
    nth0(P, Blocos, bloco(_, B1, C1, D1)),
    nth0(B, Blocos, bloco(C2, _, _, _)),
    nth0(E, Blocos, bloco(_, D2, _, _)),
    nth0(D, Blocos, bloco(_, _, _, B2)),
    B1 = B2,
    C1 = C2,
    D1 = D2.

% Verdadeiro se um Bloco x que se encontra na última linha é adequado.
bloco_adequado(jogo(L, C, Blocos), P) :-
    P #< (L * C - 1),
    P #> (L * C - L),
    E is P - 1, % Esquerda
    D is P + 1, % Direita
    A is P - C, % Cima
    nth0(P, Blocos, bloco(A1, B1, _, D1)),
    nth0(A, Blocos, bloco(_, _, A2, _)),
    nth0(E, Blocos, bloco(_, D2, _, _)),
    nth0(D, Blocos, bloco(_, _, _, B2)),
    A1 = A2,
    B1 = B2,
    D1 = D2.

% Verdadeiro se um Bloco x que se encontra na primeira coluna é
% adequado.
bloco_adequado(jogo(L, C, Blocos), P) :-
    P #\= (L * C - L),
    P #\= 0,
    P mod C #= 0,
    D is P + 1, % Direita
    A is P - C, % Cima
    B is P + C, % Baixo
    nth0(P, Blocos, bloco(A1, B1, C1, _)),
    nth0(A, Blocos, bloco(_, _, A2, _)),
    nth0(B, Blocos, bloco(C2, _, _, _)),
    nth0(D, Blocos, bloco(_, _, _, B2)),
    A1 = A2,
    B1 = B2,
    C1 = C2.

% Verdadeiro se um Bloco x que se encontra na última coluna é adequado.
bloco_adequado(jogo(L, C, Blocos), P) :-
    P #\= C - 1,
    P #\= (L * C - 1),
    (P + 1) mod C #= 0,
    E is P - 1, % Esquerda
    A is P - C, % Cima
    B is P + C, % Baixo
    nth0(P, Blocos, bloco(A1, _, C1, D1)),
    nth0(A, Blocos, bloco(_, _, A2, _)),
    nth0(B, Blocos, bloco(C2, _, _, _)),
    nth0(E, Blocos, bloco(_, D2, _, _)),
    A1 = A2,
    C1 = C2,
    D1 = D2.

% Verdadeiro se um Bloco x é adequado.
bloco_adequado(jogo(_, C, Blocos), P) :-
    E is P - 1, % Esquerda
    D is P + 1, % Direita
    A is P - C, % Cima
    B is P + C, % Baixo
    nth0(P, Blocos, bloco(A1, B1, C1, D1)),
    nth0(A, Blocos, bloco(_, _, A2, _)),
    nth0(B, Blocos, bloco(C2, _, _,_)),
    nth0(E, Blocos, bloco(_, D2, _, _)),
    nth0(D, Blocos, bloco(_, _, _, B2)),
    A1 = A2,
    B1 = B2,
    C1 = C2,
    D1 = D2.


