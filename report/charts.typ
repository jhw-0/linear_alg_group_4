#import "@preview/cetz:0.3.1": canvas, draw, tree
#import "@preview/cetz-plot:0.1.0": *

#let data = (
  ("1.0", 1),
  ("1.5", 1),
  ("2.0", 1),
  ("2.5", 1),
  ("3.0", 1),
)

#let spinner = canvas({
  let colors = gradient.linear(
    rgb("#2E1A4A"),
    rgb("#501D83"),
    rgb("#B095DE"),
    rgb("#A7B4C3"),
    rgb("#586066")
  )
  chart.piechart(
    data,
    value-key: 1,
    label-key: 0,
    radius: 3,
    slice-style: colors,
    inner-radius: 0,
    inner-label: (
      content: (value, label) => [
        #text(
          fill: luma(255),
          size: 30pt
        )[
          #label
        ]
      ],
      radius: 130%
    ),
    outer-label: (content: none, radius: 110%),
    legend: (label: none),
  )
})

#let board = {
  let space(label) = rect(
    width: 50%,
    height: 10pt,
    outset: 6.6pt,
    fill: luma(200),
    stroke: luma(80)
  )[$cal(#label)$]
  for x in "SABRCF" {space(x)}
  }
}

#let data2 = (
  ("1.0", 1),
  ("1.5", 1),
  ("2.0", 1),
  ("2.5", 1),
  ("3.0", 1),
  ("3.5", 1),
)

#let spinner2 = canvas({
  let colors = gradient.linear(
    rgb("#2E1A4A"),
    rgb("#501D83"),
    rgb("#B095DE"),
    rgb("#A7B4C3"),
    rgb("#586066")
  )
  chart.piechart(
    data2,
    value-key: 1,
    label-key: 0,
    radius: 3,
    slice-style: colors,
    inner-radius: 0,
    inner-label: (
      content: (value, label) => [
        #text(
          fill: luma(255),
          size: 30pt
        )[
          #label
        ]
      ],
      radius: 130%
    ),
    outer-label: (content: none, radius: 110%),
    legend: (label: none),
  )
})