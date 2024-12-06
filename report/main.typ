// https://github.com/jhw-0/linear_alg_group_4

// Questions for the professor:
// - is Wikipedia an ok reference?
// - do we receive extra credit for the bonus option?
// - ...
#import "automata.typ"
#import "title_page.typ"
#import "matrices.typ"


#set par(justify: true)

#set math.equation(
  numbering: "(1)",
  number-align: left
)

#title_page.title_page

#set page(
  header: [_Group 4_ #h(1fr) Group Project],
  numbering: "1",
  columns: 2
)

#set heading(
  numbering: "1.1"
)

#show ref: set text(blue)

= Report


== Introduction


=== Game description


==== Game board
The game takes place on a board entirely comprised of six spaces defined by set $Q = {0, 1, 2, 3, 4, 5}$. Call each $q in Q$ a "game-state". Each space in $Q$ is indicated on the board, and in conversation and writing, by the elements mapped-to by the bijective function $R_Q: Q arrow Q_alpha$ represented by the relation $R_Q = {(0, cal(S)), (1, cal(A)), (2, cal(B)), (3, cal(R)), (4, cal(C)), (5, cal(F))}$. Call any element $q_alpha in Q_alpha$ a "space".

==== Game rules
At the start of the game, each player $p_i in {p_1, p_2}$ starts with a piece $z_i in {z_1, z_2}$ on space $cal(S)$. Each turn $t_j$, each player of the game spins a spinner that has an equal probability of landing on any number in the set $beta = {1, 3/2, dots, 3}$. Call any $b in beta$ an "input" or "spin-result". Furthermore, if the player spins a number that is not whole, they must flip a coin; if heads is flipped, $1/2$ is added to the spin-result; tails, $1/2$ is subtracted from the spin-result.
At the end of each turn $t_j$, each player $p_i$ must move their piece $z_i$ to the space $q_(alpha, t+1)$ as indicated by the function $delta(q_(alpha, t), b_(t, i))$ defined by the recurrence relation in @eq-move-repr where $b_(t, i)$ is the current turn's spin result and  $cal(q) = R^(-1)(q_(alpha, t)) + b_(t, i)$.

$
q_(alpha, t + 1) = cases(
R_Q (cal(q)) &"if" cal(q) <= 5 "and" cal(q) eq.not 3,
cal(S) &"if" cal(q) = 3,
q_(alpha, t) &"otherwise") \
$<eq-move-repr>
=== Representing the game

==== Representing the game as a probabilistic automaton
The game can be represented by the probabilistic automaton $sans("PA") = (sans("NFA"), P, q_0 ')$. $sans("NFA") = (Q, Sigma, delta, q_0, F)$ is further defined in @eq-nfa and visualized in @fig-nfa.
$
&Q& &= "the set of spaces" \
&Sigma& &= beta \
&delta& &= "as defined above" \
&q_0& &= cal(S) \
&F& &= {cal(F)}
$<eq-nfa

#place(
  bottom + center,
  scope: "parent",
  float: true
)[#figure(
  automata.nfa,
  caption: "Non-deterministic automaton representing game possibilities. States represent board-game spaces and transitions represent board-game moves."
)<fig-nfa>]

#text(fill: red)[
  Still need to have a second automaton figure showing probabilities and a third automaton with the simplified expected probability for each transition. In fact, juxtapose them in sequence, on top of each other, visually showing the calculation of the stochastic matrix.
]

==== Representing the game as a stochastic matrix
- Transition matrices for $sans("NFA")$ for each $a in Sigma$ are shown in @sec-trans-mats.
- Transition matrices for $sans("PA")$ for each $a in Sigma$ are shown in @sec-stoch-mats
- The game's expected transition matrix (@eq-trans-mat) is calculated by application of @eq-exp-trans to  the transition matrices of $sans("PA")$.

$
P_Sigma = 1 / (|Sigma|) sum P_a
$ <eq-exp-trans>

$
P_Sigma = #math.mat(
  ..matrices.pa_expected,
  delim: "["
)
$ <eq-trans-mat>

#text(fill: red)[
  Still need to justify the equivalence between a probabilistic automata and transition matrices. In addition, need to justify why the expected transition matrix can be calculated the way it was.
]

== Results
#text(fill: red)[
  Need results from MATLAB. Include MATLAB code in an appendix.
]


== Conclusions
#text(fill: red)[
  Summarize the results, and explain how the formalization as an automaton helps the game to be modified and analyzed more abstractly than a matrix alone. Remember, an automaton accepts a language, not just one symbol like the rubric requires at the minimum.
]

$
= Bibliography
#bibliography("sources.yml", full: true, title: none)
//
#pagebreak()//
//
#set page(//
  columns: 1//
)

= Appendices== Transition matrices <sec-trans-mats>
$
theta_(1.0) = #math.mat(
  ..matrices.nfa_1_0,
  delim: "["
)
$
$
theta_(1.5) = #math.mat(
  ..matrices.nfa_1_5,
  delim: "["
)
$
$
theta_(2.0) = #math.mat(
  ..matrices.nfa_2_0,
  delim: "["
)
$
$
theta_(2.5) = #math.mat(
  ..matrices.nfa_2_5,
  delim: "["
)
$
$
theta_(3.0) = #math.mat(
  ..matrices.nfa_3_0,
  delim: "["
)
$
== Stochastic matrices <sec-stoch-mats>
$
theta_(1.0) = #math.mat(
  ..matrices.pa_1_0,
  delim: "["
)
$
$
theta_(1.5) = #math.mat(
  ..matrices.pa_1_5,
  delim: "["
)
$
$
theta_(2.0) = #math.mat(
  ..matrices.pa_2_0,
  delim: "["
)
$
$
theta_(2.5) = #math.mat(
  ..matrices.pa_2_5,
  delim: "["
)
$
$
theta_(3.0) = #math.mat(
  ..matrices.pa_3_0,
  delim: "["
)
$

