# Puzzle_Solver

- Este repositório contém a implementação de um resolvedor para um jogo de quebra-cabeça de correspondência de borda.

- No jogo, é dada uma grade de blocos, onde cada bloco tem um número em cada borda.
- O objetivo é colocar cada bloco em uma posição apropriada.
- Um bloco está em uma posição apropriada se os blocos adjacentes (acima, à direita, abaixo e à esquerda) têm o mesmo valor nas bordas adjacentes.

- O repositório inclui um arquivo jogo.pl que contém uma implementação do predicado principal. Esta implementação descreve a solução como uma permutação dos blocos de entrada onde os blocos estão em posições adequadas. - No entanto, como o Prolog usa por padrão uma estratégia de busca em profundidade, esta abordagem não é muito eficiente.

- Um dos desafios deste trabalho é descrever um predicado que gere uma busca mais eficiente. Uma possibilidade é descrever as restrições de forma conjunta. Ou seja, ao invés de descrever que a solução é uma permutação da entrada com os blocos nas posições adequadas, descrevemos a solução como tendo um bloco da entrada adequado na posição 1, um bloco da entrada (ainda não utilizado) adequado na posição 2 e assim por diante. Dessa forma, durante a busca, assim que não existir um bloco viável para uma determinada posição, a busca irá retroceder e outras possibilidades serão verificadas.
