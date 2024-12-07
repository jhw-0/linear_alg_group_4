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
The game board consists of five spaces: Space 1 (Start, S), Space 2 (A), Space 3 (B), Space 4 (C), and Space 5 (Final, F), as seen in @fig-game-board. The R space is not counted as a "space" since it returns the player to the Space 1. The game piece will begin at Space 1 and the players will follow the game rules to continue. 
\
#figure(charts.board, caption: "Game board", gap: 1em) <fig-game-board>

=== Game rules
// REWRITE HERE:
The players will take turns moving the game piece, which begins on Space 1. Player 1 will spin the game spinner as shown in @fig-game-spinner. If the spinner lands on a whole number, the player will move the game piece forward that number of times. If the spinner lands on 1.5 or 2.5, the player will flip a coin. If the coin lands on heads, the player will add 0.5 to the number spun and move the game piece accordingly. If the coin lands on tails, the player will subtract 0.5 from the number spun and move the game piece accordingly. Once player 1 is done moving the game piece, player 2 will repeat these steps. If the game piece lands on the "R" space, the game piece will return to Space 1.

#figure(charts.spinner, caption: "Game spinner") <fig-game-spinner>
//

== Procedure

=== Representing the game as a probabilistic automaton

The game can be represented by the probabilistic automaton $sans("PA") = (sans("NFA"), P, v)$, where $sans("NFA")$ is the nondeterministic finite automaton $sans("NFA") = (Q, Sigma, delta, q_0, F)$,

#place(bottom + center, scope: "parent", float: true)[
  #figure(
    automata.nfa,
    caption: "Non-deterministic automaton representing game states and moves. States represent board-game spaces and transitions represent board-game moves."
  ) <fig-nfa>
]

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



=== Representing the game as a stochastic matrix
For each $a in Sigma$ of a probabilistic automata, there corresponds a right stochastic matrix $P_a$ @prob_auto. The matrix $P_a$ for each input of the automata representing the game $sans("PA")$ (@fig-nfa) can be found in @sec-trans-mats; accordingly @stoch_mat, if the matrices therein have any row summed, the answer will be $1$. A singular stochastic matrix representing the expected input value is $P_Sigma$ (@eq-trans-mat), which because input probabilities are uniformly distributed, is calculated as the average $P_a$ (@eq-exp-trans).

$ P_Sigma = 1 / (|Sigma|) sum P_a $ <eq-exp-trans>

$ P_Sigma = #math.mat(..matrices.pa_expected, delim: "[") $ <eq-trans-mat>

Thus, the state of the game can be estimated by right-applications of $P_Sigma$ to the initial state vector $v = mat(1, 0, 0, 0, 0, delim: "[")$ as a row vector; or in other words, for the $k^"th"$ turn the $n^"th"$ value of the row vector given by $v (P_Sigma)^k$ contains the probability that the the piece will be on the space designated on the board by $R(n - 1)$.




== Results

=== Original game

@fig-prob4 shows the smallest number of spins that gives 95% probability of finishing the game. The smallest number of spins is 14 spins.

#figure(image("Table for Question 4.png"), caption: [Probability of finishing the game in $n$ spins.]) <fig-prob4>

@fig-prob4-1 shows the expected number of times state each will be visited in a finished game for each starting state.

#figure(image("Table 1 for Question 5.png"), caption: [Expected number of times visiting each transient state $j$ before a game ends. $R(j - 1)$ is the state as shown on the game board.]) <fig-prob4-1>

@fig-prob4-2 shows that Space 4 is the transient state that was visited the most when summed over all starting positions and Space 2 is the transient state that was visited the least. This answer does seem to make sense intuitively because Space 4 has the largest chance of being landed on since there are a lot of different spins possible. However, Space 4 does have the property of being included in all games, regardless of starting position.

#figure(image("Table 2 for Question 5.png"), caption: [Total visits to state $j$ (where $R(j-1)$ represents the state shown on the game board) summed across all initial starting positions.]) <fig-prob4-2>


#figure(image("Table 3 for Question 5.png"), caption: [Expected number of spins before the game ends. $R(i - 1)$ is the state as shown on the game board.])


=== Adding an input to the spinner
@fig-game-spinner2 is the modified game spinner. @eq-trans-mat2 is the resulting transition matrix from the aforementioned change. @a shows the probability of finishing the game in $n$ spins with this new spinner (see @a-matlab for MATLAB code). @fig-nfa2 is the nondeterministic automata representing the game with the new spinner.

#figure(charts.spinner2, caption: [_Modified game spinner_]) <fig-game-spinner2>

#place(top + center, scope: "parent", float: true)[
  #figure(
    automata.nfa2,
    caption: [Non-deterministic automaton representing _modified_ game inputs. The game has been modified from its original rule-set by allowing '3.5' to be spun.]
  ) <fig-nfa2>
]

$ P_(Sigma, m) = #math.mat(..matrices.pa_expected2, delim: "[") $ <eq-trans-mat2>

#figure(image("Table for Question 6.png"), caption: [Probability of finishing the game in $n$ spins given the modified game spinner.]) <a>

#pagebreak()

=== Modifying accepting states
@fig-nfa3 is the nondeterministic automata representing the game with a new absorbing state. @eq-trans-mat3 is the resulting transition matrix from the aforementioned change. @fig-prob7 shows the probability of winning ($0.1552$) and the probability of losing ($0.8448$) with the corresponding MATLAB code in @b-matlab.

$ P_(Sigma, m') = #math.mat(..matrices.pa_expected3, delim: "[") $ <eq-trans-mat3>

#figure(image("prob7.png"), caption: [Probability of finishing the game in $n$ spins.]) <fig-prob7>

#place(top + center, scope: "parent", float: true)[
  #figure(
    automata.nfa3,
    caption: [Non-deterministic automaton representing _modified_ game states. The game has been modified from its original rule-set by designating $cal(B)$ as an absorbing state loss.]
  ) <fig-nfa3>
]

////////////////////////////////////////////////////////////////////////////////
= Bibliography
#bibliography("sources.yml", full: true, title: none)


////////////////////////////////////////////////////////////////////////////////
#pagebreak()

#set page(
  columns: 1
)

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
P^13
P^14

%% ans =
%% 
%%     0.3300    0.0900    0.2100    0.2500    0.1200
%%     0.2100    0.1200    0.1600    0.3300    0.1800
%%     0.0900    0.0900    0.1200    0.2800    0.4200
%%          0         0         0    0.4900    0.5100
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.1980    0.0990    0.1590    0.2860    0.2580
%%     0.1590    0.0630    0.1200    0.3310    0.3270
%%     0.0990    0.0270    0.0630    0.2710    0.5400
%%          0         0         0    0.3430    0.6570
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.1467    0.0594    0.1089    0.2935    0.3915
%%     0.1089    0.0477    0.0825    0.2986    0.4623
%%     0.0594    0.0297    0.0477    0.2230    0.6402
%%          0         0         0    0.2401    0.7599
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0057    0.0025    0.0043    0.0439    0.9435
%%     0.0043    0.0019    0.0033    0.0364    0.9541
%%     0.0025    0.0011    0.0019    0.0228    0.9718
%%          0         0         0    0.0097    0.9903
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0040    0.0017    0.0030    0.0332    0.9580
%%     0.0030    0.0013    0.0023    0.0273    0.9660
%%     0.0017    0.0007    0.0013    0.0171    0.9792
%%          0         0         0    0.0068    0.9932
%%          0         0         0         0    1.0000

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

%% N =
%% 
%%     2.3095    0.6928    1.1316    2.2017
%%     1.1316    1.3395    0.8545    2.4788
%%     0.6928    0.2079    1.3395    1.9938
%%          0         0         0    3.3333
%% 
%% 
%% sum_of_each_row =
%% 
%%     6.3356
%%     5.8045
%%     4.2340
%%     3.3333
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

=== MATLAB code <a-matlab>
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

%% ans =
%% 
%%     0.3267    0.1089    0.2178    0.2178    0.1089
%%     0.2178    0.1089    0.1089    0.3300    0.2178
%%     0.1089    0.1089    0.1089    0.2211    0.4389
%%          0         0         0    0.4489    0.5511
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.2156    0.1078    0.1437    0.2537    0.2526
%%     0.1437    0.0719    0.1078    0.2930    0.3626
%%     0.1078    0.0359    0.0719    0.2200    0.5478
%%          0         0         0    0.3008    0.6992
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.1542    0.0712    0.1067    0.2530    0.3838
%%     0.1067    0.0474    0.0712    0.2556    0.4949
%%     0.0712    0.0356    0.0474    0.1830    0.6441
%%          0         0         0    0.2015    0.7985
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.1096    0.0509    0.0744    0.2282    0.5025
%%     0.0744    0.0352    0.0509    0.2104    0.6027
%%     0.0509    0.0235    0.0352    0.1500    0.7202
%%          0         0         0    0.1350    0.8650
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0775    0.0362    0.0530    0.1942    0.6024
%%     0.0530    0.0245    0.0362    0.1694    0.6889
%%     0.0362    0.0168    0.0245    0.1199    0.7813
%%          0         0         0    0.0905    0.9095
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0550    0.0256    0.0375    0.1595    0.6840
%%     0.0375    0.0175    0.0256    0.1335    0.7568
%%     0.0256    0.0119    0.0175    0.0939    0.8289
%%          0         0         0    0.0606    0.9394
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0390    0.0181    0.0266    0.1277    0.7490
%%     0.0266    0.0124    0.0181    0.1037    0.8093
%%     0.0181    0.0084    0.0124    0.0727    0.8657
%%          0         0         0    0.0406    0.9594
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0276    0.0129    0.0188    0.1003    0.7999
%%     0.0188    0.0088    0.0129    0.0795    0.8494
%%     0.0129    0.0060    0.0088    0.0555    0.8938
%%          0         0         0    0.0272    0.9728
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0196    0.0091    0.0134    0.0777    0.8392
%%     0.0134    0.0062    0.0091    0.0604    0.8799
%%     0.0091    0.0042    0.0062    0.0421    0.9150
%%          0         0         0    0.0182    0.9818
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0139    0.0065    0.0095    0.0595    0.8693
%%     0.0095    0.0044    0.0065    0.0455    0.9029
%%     0.0065    0.0030    0.0044    0.0316    0.9309
%%          0         0         0    0.0122    0.9878
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0098    0.0046    0.0067    0.0451    0.8920
%%     0.0067    0.0031    0.0046    0.0341    0.9200
%%     0.0046    0.0021    0.0031    0.0237    0.9428
%%          0         0         0    0.0082    0.9918
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0070    0.0032    0.0048    0.0339    0.9091
%%     0.0048    0.0022    0.0032    0.0254    0.9328
%%     0.0032    0.0015    0.0022    0.0176    0.9517
%%          0         0         0    0.0055    0.9945
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0049    0.0023    0.0034    0.0254    0.9219
%%     0.0034    0.0016    0.0023    0.0188    0.9422
%%     0.0023    0.0011    0.0016    0.0130    0.9582
%%          0         0         0    0.0037    0.9963
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0035    0.0016    0.0024    0.0189    0.9314
%%     0.0024    0.0011    0.0016    0.0139    0.9492
%%     0.0016    0.0008    0.0011    0.0096    0.9630
%%          0         0         0    0.0025    0.9975
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0025    0.0012    0.0017    0.0140    0.9384
%%     0.0017    0.0008    0.0012    0.0102    0.9543
%%     0.0012    0.0005    0.0008    0.0070    0.9665
%%          0         0         0    0.0016    0.9984
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0018    0.0008    0.0012    0.0103    0.9436
%%     0.0012    0.0006    0.0008    0.0075    0.9581
%%     0.0008    0.0004    0.0006    0.0052    0.9691
%%          0         0         0    0.0011    0.9989
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0012    0.0006    0.0009    0.0076    0.9473
%%     0.0009    0.0004    0.0006    0.0055    0.9608
%%     0.0006    0.0003    0.0004    0.0038    0.9710
%%          0         0         0    0.0007    0.9993
%%          0         0         0         0    1.0000
%% 
%% 
%% ans =
%% 
%%     0.0009    0.0004    0.0006    0.0055    0.9501
%%     0.0006    0.0003    0.0004    0.0040    0.9628
%%     0.0004    0.0002    0.0003    0.0027    0.9724
%%          0         0         0    0.0005    0.9995
%%          0         0         0         0    1.0000
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

=== MATLAB code <b-matlab>
```matlab
>> % Question 7
P = [0.3 0.3 0.4 0 0;
    0.4 0 0.3 0.3 0;
    0 0 1 0 0;
    0 0 0 0.7 0.3;
    0 0 0 0 1];

P^14
P^40

%% ans =
%% 
%%     0.0001    0.0001    0.8447    0.0037    0.1514
%%     0.0001    0.0000    0.6378    0.0050    0.3570
%%          0         0    1.0000         0         0
%%          0         0         0    0.0068    0.9932
%%          0         0         0         0    1.0000
%% 

%% ans =
%% 
%%     0.0000    0.0000    0.8448    0.0000    0.1552
%%     0.0000    0.0000    0.6379    0.0000    0.3621
%%          0         0    1.0000         0         0
%%          0         0         0    0.0000    1.0000
%%          0         0         0         0    1.0000
%% 
>> P^200

%% ans =
%% 
%%     0.0000    0.0000    0.8448    0.0000    0.1552
%%     0.0000    0.0000    0.6379    0.0000    0.3621
%%          0         0    1.0000         0         0
%%          0         0         0    0.0000    1.0000
%%          0         0         0         0    1.0000
%% 
>> P^400

%% ans =
%% 
%%     0.0000    0.0000    0.8448    0.0000    0.1552
%%     0.0000    0.0000    0.6379    0.0000    0.3621
%%          0         0    1.0000         0         0
%%          0         0         0    0.0000    1.0000
%%          0         0         0         0    1.0000
%% 
%% >> 
```