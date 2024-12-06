#import "automata.typ"

#set par(justify: true)

#set math.equation(
  numbering: "(1)",
  number-align: left
)

- The game takes place on a board entirely comprised of six spaces defined by set $Q = {0, 1, 2, 3, 4, 5}$. \
  - Call each $q in Q$ a "game-state".
- Each space in $Q$ is indicated on the board, and in conversation and writing, by the elements mapped-to by the bijective function $R_Q: Q arrow Q_alpha$ represented by the relation $R_Q = {(0, cal(S)), (1, cal(A)), (2, cal(B)), (3, cal(R)), (4, cal(C)), (5, cal(F))}$. \
  - Call any element $q_alpha in Q_alpha$ a "space".
- At the start of the game, each player $p_i in {p_1, p_2}$ starts with a piece $z_i in {z_1, z_2}$ on space $cal(S)$. Each turn $t_j$, each player of the game spins a spinner that has an equal probability of landing on any number in the set $beta = {1, 3/2, dots, 3}$. Call any $b in beta$ an "input" or "spin-result". Furthermore, if the player spins a number that is not whole, they must flip a coin; if heads is flipped, $1/2$ is added to the spin-result; tails, $1/2$ is subtracted from the spin-result.
- At the end of each turn $t_j$, each player $p_i$ must move their piece $z_i$ to the space $q_(alpha, t+1)$ indicated by the function on their piece's current space and spin-result $b_(t, i)$.
  $ delta(q_(alpha, t), b_(t, i)) = q_(alpha, t + 1) = cases(
    R_Q (cal(q)) &"if" cal(q) <= 5 "and" cal(q) eq.not 3,
    cal(S) &"if" cal(q) = 3,
    q_(alpha, t) &"else") "where" cal(q) = R^(-1)(q_(alpha, t)) + b_(t, i)
  $
- This can be represented by the probabilistic automaton $sans("PA") = (sans("NFA"), P, q_0 ')$. Here $sans("NFA") = (Q, Sigma, delta, q_0, F)$ where \
  \
  $
  Q &= "the set of spaces on the game board" \
  Sigma &= beta \
  delta &= "as defined above" \
  q_0 &= cal(S) \
  F &= {cal(F)}
  $
#figure(
  automata.nfa,
  caption: "Non-deterministic automaton representing game possibilities. States represent board-game spaces and transitions represent board-game moves."
)
    $ (Q, Sigma, delta, q_0, F) $ \
    $Q$: spaces to land on (excluding redirection spaces) \
    $Sigma$:  \
    $delta$:  \
    $q_0$:  \
    $F$:  \
    $$$
    Q = {S, A, B, C, F} \
    Sigma = {1, 2, 3} \
    delta(q, a, q') =  1 "if" (q, a, q') in { \
      (S, 1, A), (S, 2, B), (S, 3, S), \
      (A, 1, B), (A, 2, S), (A, 3, C), \
      (B, 1, S), (B, 2, C), (B, 3, F), \
      (C, 1, F), (C, 2, C), (C, 3, C)}; \
    0 "otherwise" \
    q_0 = S \
    F = {1}
    $$$
  

    $$$
    theta_1 = mat(
      0, 1, 0, 0, 0;
      0, 0, 1, 0, 0;
      1, 0, 0, 0, 0;
      0, 0, 0, 0, 1;
      0, 0, 0, 0, 1;
      delim: "["
    ) \
    dots.v
    $$$
    $$$
    sum theta_a = mat(
      1, 1, 1, 0, 0;
      1, 0, 1, 1, 0;
      1, 0, 0, 1, 1;
      0, 0, 0, 1, 1;
      0, 0, 0, 0, 1;
      delim: "["
    )
    $$$
    $$$
    P_1 = mat(
      0, 1/3, 0, 0, 0;
      0, 0, 1/3, 0, 0;
      1/3, 0, 0, 0, 0;
      0, 0, 0, 0, 1/3;
      0, 0, 0, 0, 1/3;
      delim: "["
    ) \
    dots.v
    $$$
    $$$
    sum P_a = mat(
      1/3, 1/3, 1/3, 0, 0;
      1/3, 0, 1/3, 1/3, 0;
      1/3, 0, 0, 1/3, 1/3;
      0, 0, 0, 2/3, 1/3;
      0, 0, 0, 0, 1;
      delim: "["
    )
    $$$