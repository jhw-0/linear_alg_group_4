#import "@preview/frame-it:1.0.0": *
#import "@preview/finite:0.3.2": *

#set par(justify: true)

#let (plan, answer) = make-frames(
  "counter-id",
  plan: ("Plan",),
  answer: ("Answer",),
  style: styles.hint
)

+ Describe your game by constructing a game board and a spinner dial.  Be creative but keep the game board to 12 or fewer spaces on which you can land. Your game can have a theme and it does not need to be laid out as a boring rectangle like the example.  You could even have a square that send you onto a different path. Limit the spinner to no more than 6 places the spinner can stop.  They do not have to all be distinct outcomes. 
  #plan()[
    - Let's use a *_probabilistic automaton_* (related to a *_nondeterministic finite automaton_*) to describe the game.
      - #underline()[Wikipedia]: \
        _Formal Definition (of a probabilistic automaton)_: \
        The _probabilistic automaton_ may be defined as an extension of a _nondeterministic finite automaton_ $(Q, Sigma, delta, q_0, F)$, together with two probabilities: the probability $P$ of a particular state transition taking place, and with the initial state $q_0$ replaced by a *_stochastic vector_* giving the probability of the automaton being in a given initial state.

        For the ordinary non-deterministic finite automaton, one has
        - a finite set of states $Q$
        - a finite set of input symbols $Sigma$
        - a transition function $delta : Q times Sigma arrow cal(P)(Q)$, \
          where $cal(P)(Q)$ denotes the power set of $Q$
        - a set of states $F$ distinguished as *_accepting_* (or *_final_*) states $F subset.eq Q$.
        By use of *_currying_*, the transition function $delta : Q times Sigma arrow cal(P)(Q)$ of a non-deterministic finite automaton can be written as a membership function
        $ delta : Q times Sigma times Q arrow {0, 1} $
        so that $delta(q, a, q') = 1$ if $q' in delta(q, a)$ and $0$ otherwise. \
        The curried transition function can be understood to be a matrix with matrix entries
        $ [theta_a]_(q q') = delta(q, a, q') $
        The matrix $theta_a$ is then a square matrix, whose entries are zero or one, indicating whether a transition $q arrow^a q'$ is allowed by the NFA. Such a transition matrix is always defined for a non-deterministic finite automaton.

        The probabilistic automaton replaces these matrices by a family of *_right stochastic matrices_* $P_a$, for each symbol $a$ in the alphabet $Sigma$
        
  ]
  #answer()[
    There is a board with six spaces defined by set $Q = {0, 1, 2, 3, 4, 5}$. Call each $q in Q$ a "game-state" or "space". Each space in $Q$ is indicated on the board and in speaking about the game by the bijective function $R_Q: Q arrow Q'$ represented by the relation $R_Q = {(0, cal(S)), (1, cal(A)), (2, cal(B)), (3, cal(R)), (4, cal(C)), (5, cal(F))}$. Call any element $q' in Q'$ a "space". At the start of the game, each player starts with a piece on space $S$. Each turn, the players of the game take turns spinning a spinner that has an equal probability of landing on any number in the set $beta = {0, 1/2, dots, 3}$. Call any $b in beta$ an "input"" or "spin-result".
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

    
    #automaton(
      (
        q0: (q0: 3, q1: 1, q2: 2),
        q1: (q0: 2, q2: 1, q3: 3),
        q2: (q0: 1, q3: 2, q4: 3),
        q3: (q3: (2, 3), q4: 1),
        q4: ()
      ),
      labels: (
        q0: "S",
        q1: "A",
        q2: "B",
        q3: "C",
        q4: "F"
      )
    )
  ]
  
+ Develop the complete transition matrix that describes the probability of moving from any space to any other space when it is your turn. The finish square is called an absorbing state because once you land in it you cannot go to another state. It is convenient to label the finish state with the largest number you are assigning to the states.  In the case of our example, the finish state is state 
  #plan()[
    
  ]
  #answer()[
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
  ]
+ The probability of going from the finish state to any other state is 0.  The probability of going from the finish state to itself is 1.  
  #plan()[
    
  ]
  #answer()[
    
  ]
+ Read about stochastic matrices. Describe the properties a matrix must have to be a stochastic matrix. Explain why the matrix for your game is a stochastic matrix. 
  #plan()[
    
  ]
  #answer()[
    
  ]
+ The entries of powers of the transition matrix, 𝑃𝑘 , give you the probability of going from state 𝑖 to state 𝑗 in 𝑘 spins. Use MATLAB to determine the probability of finishing the game in 𝑛 spins for 𝑛 = 1,2,3,…. . Go to a large enough 𝑛 that there is at least a 95% chance of finishing in 𝑛 spins. What is the smallest number of spins that gives a 95% probability of finishing the game? Present your results in a table. Observe that as 𝑘 gets larger the probability of being in any state except the absorbing state approaches zero.  
  #plan()[
    
  ]
  #answer()[
    
  ]
+ States which are not absorbing are called transient states.  We call the submatrix of 𝑃 that only involves all the transient states 𝑄.  In our example, 𝑄 is the upper left 4 × 4 matrix. We can use the matrix 𝑄 to determine the average number of times we will visit each transient state before the game ends. Since we don’t know how many spins are required, we really need to sum all the possibilities.  That is, we need 𝑄 + 𝑄2 + 𝑄3 + ⋯.  Now, if 𝑄 were a scalar with absolute value less than 1, then this geometric series would converge to 11−𝑄.  Of course, this does not make sense because 𝑄 is a matrix.  However, something remarkable is true.  If any power of  𝑄 has columns that sum to less than 1, then the series in fact does converge to (𝐼 − 𝑄)−1.  If that doesn’t make you think mathematics is cool, then nothing will. Let 𝑁 = (𝐼 − 𝑄)−1 for your game.  The 𝑖𝑗-entry of 𝑁 gives the expected number of times you will visit state 𝑗 assuming you started in state 𝑖. In our game, we can assume we start in state 1, so the entries in the first row show the expected number of visits to each state.  Summing the entries in row 1 gives the expected number of spins before entering the absorbing state.  Calculate this for your game.  Present the results in a table. Which of your transient states is visited most frequently and which one is the least?  Does your answer seem to make sense intuitively by just thinking about the game and the spinner?  
  #plan()[
    
  ]
  #answer()[
    
  ]
+ Suppose you add another space to the spinner with a new number on it? Will this make the game take more or less time? Confirm your answer.  
  #plan()[
    
  ]
  #answer()[
    
  ]
+ Bonus option: Instead of a game where two or more players take turns, imagine a game where a single player places a bet and then either “wins” or “loses” the game.  For this scenario, modify your game so there is a WIN space and a LOSE space.  Both are absorbing states.  Try to make it so it is not obvious to the player which outcome is more likely.  Analyze the new situation to determine the probability the player wins the game.  
  #plan()[
    
  ]
  #answer()[
    
  ]