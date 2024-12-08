#import "@preview/finite:0.3.2": *
// make nfa a function so that nfa and pa can be called from same literal unit
#let nfa = automaton(
    (
      q0: (q0: (2.5, 3), q1: (1, 1.5), q2: (1.5, 2, 2.5)),
      q1: (q0: (1.5, 2, 2.5), q2: (1, 1.5), q3: (2.5, 3)),
      q2: (q0: (1, 1.5), q3: (1.5, 2, 2.5), q4: (2.5, 3)),
      q3: (q3: (1.5, 2, 2.5, 3), q4: (1, 1.5)),
      q4: (q4: (1, 1.5, 2, 2.5, 3))
    ),
    labels: (
      q0: $cal(S)$,
      q1: $cal(A)$,
      q2: $cal(B)$,
      q3: $cal(C)$,
      q4: $cal(F)$
    ),
    layout: layout.custom.with(positions:(..) => (
      q0: (0, 0),
      q1: (2, 2),
      q2: (4, 0),
      q3: (6, 2),
      q4: (8, 0),
    )),
    style: (
      q1-q2: (curve: 0),
      q0-q1: (curve: 0),
      q2-q3: (curve: 0),
      q3-q4: (curve: 0),
      q2-q4: (curve: -0.618),
      q2-q0: (curve: 0.618),
      q1-q3: (curve: 0.618),
      q0-q2: (curve: -1.618, label: (dist: -0.33))          
    )
  )

#let nfa2 = automaton(
    (
      q0: (q0: (2.5, 3, 3.5), q1: (1, 1.5, 3.5), q2: (1.5, 2, 2.5)),
      q1: (q0: (1.5, 2, 2.5), q2: (1, 1.5, 3.5), q3: (2.5, 3, 3.5)),
      q2: (q0: (1, 1.5, 3.5), q3: (1.5, 2, 2.5), q4: (2.5, 3, 3.5)),
      q3: (q3: (1.5, 2, 2.5, 3, 3.5), q4: (1, 1.5, 3.5)),
      q4: (q4: (1, 1.5, 2, 2.5, 3, 3.5))
    ),
    labels: (
      q0: $cal(S)$,
      q1: $cal(A)$,
      q2: $cal(B)$,
      q3: $cal(C)$,
      q4: $cal(F)$
    ),
    layout: layout.custom.with(positions:(..) => (
      q0: (0, 0),
      q1: (2, 2),
      q2: (4, 0),
      q3: (6, 2),
      q4: (8, 0),
    )),
    style: (
      q1-q2: (curve: 0),
      q0-q1: (curve: 0),
      q2-q3: (curve: 0),
      q3-q4: (curve: 0),
      q2-q4: (curve: -0.618),
      q2-q0: (curve: 0.618),
      q1-q3: (curve: 0.618),
      q0-q2: (curve: -1.618, label: (dist: -0.33))          
    )
  )

#let nfa3 = automaton(
    (
      q0: (q0: (2.5, 3), q1: (1, 1.5), q2: (1.5, 2, 2.5)),
      q1: (q0: (1.5, 2, 2.5), q2: (1, 1.5), q3: (2.5, 3)),
      q2: (q2: (1, 1.5, 2, 2.5, 3)),
      q3: (q3: (1.5, 2, 2.5, 3), q4: (1, 1.5)),
      q4: (q4: (1, 1.5, 2, 2.5, 3))
    ),
    labels: (
      q0: $cal(S)$,
      q1: $cal(A)$,
      q2: $cal(B)$,
      q3: $cal(C)$,
      q4: $cal(F)$
    ),
    final: ("q2", "q4"),
    layout: layout.custom.with(positions:(..) => (
      q0: (0, 0),
      q1: (2, 2),
      q2: (4, 0),
      q3: (6, 2),
      q4: (8, 0),
    )),
    style: (
      q1-q2: (curve: 0),
      q0-q1: (curve: 0),
      q2-q3: (curve: 0),
      q3-q4: (curve: 0),
      q2-q4: (curve: -0.618),
      q2-q0: (curve: 0.618),
      q1-q3: (curve: 0.618),
      q0-q2: (curve: -1.618, label: (dist: -0.33))          
    )
  )