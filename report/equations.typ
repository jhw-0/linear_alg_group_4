#let eq_nfa = $
  &Q& &= "the board spaces except" cal(R) \
  &Sigma& &= "the possibilities of the spinner" \
  &delta& &= "as defined by the game rules" \
  &q_0& &= cal(S) \
  &F& &= {cal(F)}
$

#let eq_move_repr = $
  q_(t + 1) = cases(
  R(cal(q)) &"if" cal(q) <= 5 "and" cal(q) eq.not 3,
  cal(S) &"if" cal(q) = 3,
  q_t &"otherwise") \
  "where" cal(q) = R^(-1)(q_t) + b_t
$