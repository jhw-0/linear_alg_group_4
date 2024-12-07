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

\
#figure(charts.board, caption: "Game board", gap: 1em) <fig-game-board>

=== Game rules
// REWRITE HERE:

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



- Membership matrices for $sans("NFA")$ for each $a in Sigma$ are shown in @sec-membr-mats.
- Transition matrices for $sans("PA")$ for each $a in Sigma$ are shown in @sec-trans-mats
- The game's expected transition matrix (@eq-trans-mat) is calculated by application of @eq-exp-trans to  the transition matrices of $sans("PA")$.

$ P_Sigma = 1 / (|Sigma|) sum P_a $ <eq-exp-trans>

$ P_Sigma = #math.mat(..matrices.pa_expected, delim: "[") $ <eq-trans-mat>

$ P_(Sigma, m) = #math.mat(..matrices.pa_expected2, delim: "[") $ <eq-trans-mat2>

$ P_(Sigma, m') = #math.mat(..matrices.pa_expected3, delim: "[") $ <eq-trans-mat3>

#text(fill: red)[
  Still need to justify the equivalence between a probabilistic automata and transition matrices. In addition, need to justify why the expected transition matrix can be calculated the way it was.
]


== Results
#text(fill: red)[
  Need results from MATLAB. Include MATLAB code in an appendix.
]

#figure(charts.spinner2, caption: [_Modified game spinner_]) <fig-game-spinner2>

#place(bottom + center, scope: "parent", float: true)[
  #figure(
    automata.nfa2,
    caption: [Non-deterministic automaton representing _modified_ game inputs. The game has been modified from its original rule-set by allowing '3.5' to be spun.]
  ) <fig-nfa2>
]

#place(bottom + center, scope: "parent", float: true)[
  #figure(
    automata.nfa3,
    caption: [Non-deterministic automaton representing _modified_ game states. The game has been modified from its original rule-set by designating $cal(B)$ as an absorbing state loss.]
  ) <fig-nfa3>
]

== Conclusions
#text(fill: red)[
  Summarize the results, and explain how the formalization as an automaton helps the game to be modified and analyzed more abstractly than a matrix alone. Remember, an automaton accepts a language, not just one symbol like the rubric requires at the minimum.
]


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