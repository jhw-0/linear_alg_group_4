// https://github.com/jhw-0/linear_alg_group_4
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#import "automata.typ"
#import "title_page.typ"
#import "matrices.typ"
#import "charts.typ"
#import "equations.typ"
#import "@preview/frame-it:1.0.0"

////////////////////////////////////////////////////////////////////////////////

#let (report_note,) = frame-it.make-frames(
  "counter-id",
  report_note: ("Note", gray),
  style: frame-it.styles.hint
)

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

#set text(size: 10pt)

#show ref: set text(blue)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
= Report

== Introduction

=== Game board
// REWRITE HERE:
The game board consists of five spaces: Space 1 (Start, S), Space 2 (A), Space 3 (B), Space 4 (C), and Space 5 (Final, F), as seen in @fig-game-board. The R space is not counted as a "space" since it rturns th The game piece will begin at Space 1 and the players will follow the game rules to continue.
\
#figure(charts.board, caption: "Game board", gap: 1em) <fig-game-board>

=== Game rules
// REWRITE HERE:
The players will take turns moving the game piece, which 
#figure(charts.spinner, caption: "Game spinner") <fig-game-spinner>
//

== Procedure

=== Representing the game as a probabilistic automaton

The game can be represented by the probabilistic automaton $sans("PA") = (sans("NFA"), P, v)$, where $sans("NFA")$ is the nondeterministic finite automaton $sans("NFA") = (Q, Sigma, delta, q_0, F)$,

#report_note()[
  Note @prob_auto: A nondeterministic finite automaton is a $5$-tuple consisting of
  - a set of states $Q$,
  - a set of inputs $Sigma$, 
  - a transition function $delta : Q times Sigma times Q arrow {0, 1}$,
  - an initial state $q in Q$, and
  - a set of accepting states $F subset.eq Q$.
]

$P$ is a function describing the probability of a state transition taking place, and $v$ is a stochastic vector that redefines the initial state $q_0$ of $sans("NFA")$ probabilistically. $sans("NFA")$ is further defined as the $5$-tuple containing the objects in @eq-nfa, and it is visualized in @fig-nfa

#equations.eq_nfa <eq-nfa>


The game rules (representing $delta$) are formalized by the recursive function @eq-move-repr where $t$ is the current turn, $R : {0, dots, 5} arrow Q$ bijectively  in the order of the game board (descending from the top with respect to as it is shown in @fig-game-board), and $b_t$ is the  value of the spin, modified by the coin flip (were there one).

#equations.eq_move_repr <eq-move-repr>


#place(top + center, scope: "parent", float: true)[
  #figure(
    automata.nfa,
    caption: "Non-deterministic automaton representing game states and moves. States represent board-game spaces and transitions represent board-game moves."
  ) <fig-nfa>
]

=== Representing the game as a stochastic matrix
For each $a in Sigma$ of a probabilistic automata, there corresponds a right stochastic matrix $P_a$ @prob_auto. The matrix $P_a$ for each input of the automata representing the game $sans("PA")$ (@fig-nfa) can be found in @sec-trans-mats; accordingly @stoch_mat, if the matrices therein have any row summed, the answer will be $1$. A singular stochastic matrix representing the expected input value is $P_Sigma$ (@eq-trans-mat), which because input probabilities are uniformly distributed, is calculated as the average $P_a$ (@eq-exp-trans). Thus, the state of the game can be estimated by right-applications of $P_Sigma$ to the initial state vector $v = mat(1, 0, 0, 0, 0, delim: "[")$ as a row vector; or in other words, on the $k^"th"$ turn the row vector $v (P_Sigma)^k$

$ P_Sigma = 1 / (|Sigma|) sum P_a $ <eq-exp-trans>

$ P_Sigma = #math.mat(..matrices.pa_expected, delim: "[") $ <eq-trans-mat>




== Results

=== Original game
#figure(image("Table for Question 4.png"), caption: [Probability of finishing the game in $n$ spins.])

#figure(image("Table 1 for Question 5.png"), caption: [Expected number of times visiting each transient state $j$ before a game ends. $R(j - 1)$ is the state as shown on the game board.])

#figure(image("Table 2 for Question 5.png"), caption: [Total visits to state $j$ (where $R(j-1)$ represents the state shown on the game board) summed across all initial starting positions.])

#figure(image("Table 3 for Question 5.png"), caption: [Expected number of spins before the game ends. $R(i - 1)$ is the state as shown on the game board.])


=== Adding input to spinner
#figure(charts.spinner2, caption: [_Modified game spinner_]) <fig-game-spinner2>

#place(bottom + center, scope: "parent", float: true)[
  #figure(
    automata.nfa2,
    caption: [Non-deterministic automaton representing _modified_ game inputs. The game has been modified from its original rule-set by allowing '3.5' to be spun.]
  ) <fig-nfa2>
]

$ P_(Sigma, m) = #math.mat(..matrices.pa_expected2, delim: "[") $ <eq-trans-mat2>

#figure(image("Table for Question 6.png"), caption: [Probability of finishing the game in $n$ spins given the modified game spinner.])

=== Modifying accepting states

$ P_(Sigma, m') = #math.mat(..matrices.pa_expected3, delim: "[") $ <eq-trans-mat3>



#place(bottom + center, scope: "parent", float: true)[
  #figure(
    automata.nfa3,
    caption: [Non-deterministic automaton representing _modified_ game states. The game has been modified from its original rule-set by designating $cal(B)$ as an absorbing state loss.]
  ) <fig-nfa3>
]

== Conclusions



////////////////////////////////////////////////////////////////////////////////
= Bibliography
#bibliography("sources.yml", full: true, title: none)


////////////////////////////////////////////////////////////////////////////////
= Appendices

== Original game

=== Membership matrices <sec-membr-mats>
$ theta_(1.0) = #math.mat(..matrices.nfa_1_0, delim: "[") $
$ theta_(1.5) = #math.mat(..matrices.nfa_1_5, delim: "[") $
$ theta_(2.0) = #math.mat(..matrices.nfa_2_0, delim: "[") $
$ theta_(2.5) = #math.mat(..matrices.nfa_2_5, delim: "[") $
$ theta_(3.0) = #math.mat(..matrices.nfa_3_0, delim: "[") $

=== Transition matrices <sec-trans-mats>
$ P_(1.0) = #math.mat(..matrices.pa_1_0, delim: "[") $
$ P_(1.5) = #math.mat(..matrices.pa_1_5, delim: "[") $
$ P_(2.0) = #math.mat(..matrices.pa_2_0, delim: "[") $
$ P_(2.5) = #math.mat(..matrices.pa_2_5, delim: "[") $
$ P_(3.0) = #math.mat(..matrices.pa_3_0, delim: "[") $

=== MATLAB code
```matlab
% Question 4
P = [0.3 0.3 0.4 0 0;
    0.4 0 0.3 0.3 0;
    0.3 0 0 0.4 0.3;
    0 0 0 0.7 0.3;
    0 0 0 0 1];

P^2
P^3
P^4
P^5
P^6
P^7
P^8
P^9
P^10
P^11
P^12
P^13
P^14

% Question 5
Q = [0.3 0.3 0.4 0;
    0.4 0 0.3 0.3;
    0.3 0 0 0.4;
    0 0 0 0.7];

I = [1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];

N = inv(I-Q);
N

sum_of_each_row = sum(N,2);
sum_of_each_row
```


== Game with modified spinner

=== Membership matrices <sec-membr-mats2>
$ theta_(1.0) = #math.mat(..matrices.nfa2_1_0, delim: "[") $
$ theta_(1.5) = #math.mat(..matrices.nfa2_1_5, delim: "[") $
$ theta_(2.0) = #math.mat(..matrices.nfa2_2_0, delim: "[") $
$ theta_(2.5) = #math.mat(..matrices.nfa2_2_5, delim: "[") $
$ theta_(3.0) = #math.mat(..matrices.nfa2_3_0, delim: "[") $
$ theta_(3.5) = #math.mat(..matrices.nfa2_3_5, delim: "[") $

=== Transition matrices <sec-trans-mats2>
$ P_(1.0) = #math.mat(..matrices.pa2_1_0, delim: "[") $
$ P_(1.5) = #math.mat(..matrices.pa2_1_5, delim: "[") $
$ P_(2.0) = #math.mat(..matrices.pa2_2_0, delim: "[") $
$ P_(2.5) = #math.mat(..matrices.pa2_2_5, delim: "[") $
$ P_(3.0) = #math.mat(..matrices.pa2_3_0, delim: "[") $
$ P_(3.5) = #math.mat(..matrices.pa2_3_5, delim: "[") $

=== MATLAB code
```matlab
% Question 6

P_2 = [0.33 0.33 0.33 0 0;
    0.33 0 0.33 0.33 0;
    0.33 0 0 0.33 0.33;
    0 0 0 0.67 0.33;
    0 0 0 0 1];

P_2^2
P_2^3
P_2^4
P_2^5
P_2^6
P_2^7
P_2^8
P_2^9
P_2^10
P_2^11
P_2^12
P_2^13
P_2^14
P_2^15
P_2^16
P_2^17
P_2^18
P_2^19
```

== Game with modified states

=== Membership matrices <sec-membr-mats3>
$ theta_(1.0) = #math.mat(..matrices.nfa3_1_0, delim: "[") $
$ theta_(1.5) = #math.mat(..matrices.nfa3_1_5, delim: "[") $
$ theta_(2.0) = #math.mat(..matrices.nfa3_2_0, delim: "[") $
$ theta_(2.5) = #math.mat(..matrices.nfa3_2_5, delim: "[") $
$ theta_(3.0) = #math.mat(..matrices.nfa3_3_0, delim: "[") $

=== Transition matrices <sec-trans-mats3>
$ P_(1.0) = #math.mat(..matrices.pa3_1_0, delim: "[") $
$ P_(1.5) = #math.mat(..matrices.pa3_1_5, delim: "[") $
$ P_(2.0) = #math.mat(..matrices.pa3_2_0, delim: "[") $
$ P_(2.5) = #math.mat(..matrices.pa3_2_5, delim: "[") $
$ P_(3.0) = #math.mat(..matrices.pa3_3_0, delim: "[") $

=== MATLAB code