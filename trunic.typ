#let raw-rune(
  vowel_top_left: false,
  vowel_top_right: false,
  vowel_left: false,
  vowel_bottom_left: false,
  vowel_bottom_right: false,
  consonant_top_left: false,
  consonant_top_middle: false,
  consonant_top_right: false,
  consonant_bottom_left: false,
  consonant_bottom_middle: false,
  consonant_bottom_right: false,
  invert_vowel_consonant: false,
  ligatures: true,
  ..args,
) = {
  let width = 0.6em
  set box(width: width)

  let circle_width = 40% * width

  let segment_stroke = stroke(args.at("stroke", default: 0.75pt + black))
  let segment_stroke = stroke((
    paint: segment_stroke.paint,
    thickness: segment_stroke.thickness,
    cap: "round",
    join: "round",
    dash: segment_stroke.dash,
    miter-limit: segment_stroke.miter-limit,
  ))

  set line(stroke: segment_stroke)
  set circle(stroke: segment_stroke)

  box(
    baseline: circle_width,
    stack(
      dir: ttb,
      box(height: 1em)[
        #let OFFSET = if (ligatures) { 17.5% } else { 25% }
        #let POINTS = (
          top_left: (0%, OFFSET),
          top_middle: (50%, 0%),
          top_right: (100%, OFFSET),
          middle_left: (0%, 50%),
          center: (50%, 50%),
          middle_right: (100%, 50%),
          middle_top_left: (0%, 50% + OFFSET),
          middle_bottom_left: (0%, 50% + OFFSET),
          center_top: if (ligatures) { (50%, 50% - OFFSET) } else {
            (50%, 50%)
          },
          center_bottom: if (ligatures) { (50%, 50% + OFFSET) } else {
            (50%, 50%)
          },
          bottom_left: (0%, 100% - OFFSET),
          bottom_middle: (50%, 100%),
          bottom_right: (100%, 100% - OFFSET),
        )

        #if (ligatures) {
          place(line(start: POINTS.middle_left, end: POINTS.middle_right))
        }
        #if (vowel_top_left) {
          place(line(start: POINTS.top_middle, end: POINTS.top_left))
        }
        #if (vowel_top_right) {
          place(line(start: POINTS.top_middle, end: POINTS.top_right))
        }
        #if (vowel_left) {
          if (ligatures) {
            place(line(start: POINTS.top_left, end: POINTS.middle_left))
            place(
              line(start: POINTS.middle_bottom_left, end: POINTS.bottom_left),
            )
          } else {
            place(line(start: POINTS.top_left, end: POINTS.bottom_left))
          }
        }
        #if (vowel_bottom_left) {
          place(line(start: POINTS.bottom_middle, end: POINTS.bottom_left))
        }
        #if (vowel_bottom_right) {
          place(line(start: POINTS.bottom_middle, end: POINTS.bottom_right))
        }
        #if (consonant_top_left) {
          place(line(start: POINTS.center_top, end: POINTS.top_left))
        }
        #if (consonant_top_middle) {
          place(line(start: POINTS.center, end: POINTS.top_middle))
        }
        #if (consonant_top_right) {
          place(line(start: POINTS.center_top, end: POINTS.top_right))
        }
        #if (consonant_bottom_left) {
          place(line(start: POINTS.center_bottom, end: POINTS.bottom_left))
        }
        #if (consonant_bottom_middle) {
          if (ligatures) {
            place(line(start: POINTS.center_top, end: POINTS.center))
            place(line(start: POINTS.center_bottom, end: POINTS.bottom_middle))
          } else {
            place(line(start: POINTS.center_top, end: POINTS.bottom_middle))
          }
        }
        #if (consonant_bottom_right) {
          place(line(start: POINTS.center_bottom, end: POINTS.bottom_right))
        }
      ],
      box(height: circle_width)[
        #if (invert_vowel_consonant) {
          align(center, circle(width: circle_width))
        }
      ],
    ),
  )
}

#let rune(
  vowel,
  consonant,
  invert_vowel_consonant: false,
  ligatures: true,
  ..args,
) = {
  let params = (
    vowel_top_left: false,
    vowel_top_right: false,
    vowel_left: false,
    vowel_bottom_left: false,
    vowel_bottom_right: false,
    consonant_top_left: false,
    consonant_top_middle: false,
    consonant_top_right: false,
    consonant_bottom_left: false,
    consonant_bottom_middle: false,
    consonant_bottom_right: false,
    invert_vowel_consonant: invert_vowel_consonant,
    horizontal: ligatures,
  )

  if ("a",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_top_right = true
    params.vowel_left = true
  } else if ("ah",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_top_right = true
    params.vowel_bottom_left = true
    params.vowel_bottom_right = true
  } else if ("aw",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_left = true
  } else if ("ay", "ei").contains(vowel) {
    params.vowel_top_left = true
  } else if ("eh",).contains(vowel) {
    params.vowel_left = true
    params.vowel_bottom_left = true
    params.vowel_bottom_right = true
  } else if ("ee",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_left = true
    params.vowel_bottom_left = true
    params.vowel_bottom_right = true
  } else if ("ear",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_left = true
    params.vowel_bottom_right = true
  } else if ("uh",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_top_right = true
  } else if ("air",).contains(vowel) {
    params.vowel_left = true
    params.vowel_bottom_right = true
  } else if ("ee-sharp",).contains(vowel) {
    params.vowel_bottom_left = true
    params.vowel_bottom_right = true
  } else if ("aye",).contains(vowel) {
    params.vowel_top_right = true
  } else if ("uhr",).contains(vowel) {
    params.vowel_top_right = true
    params.vowel_left = true
    params.vowel_bottom_left = true
    params.vowel_bottom_right = true
  } else if ("oh",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_top_right = true
    params.vowel_left = true
    params.vowel_bottom_left = true
    params.vowel_bottom_right = true
  } else if ("oi",).contains(vowel) {
    params.vowel_bottom_left = true
  } else if ("oo-long",).contains(vowel) {
    params.vowel_top_left = true
    params.vowel_top_right = true
    params.vowel_left = true
    params.vowel_bottom_left = true
  } else if ("oo-short",).contains(vowel) {
    params.vowel_left = true
    params.vowel_bottom_left = true
  } else if ("ow",).contains(vowel) {
    params.vowel_bottom_right = true
  } else if ("oar", "our").contains(vowel) {
    params.vowel_top_left = true
    params.vowel_top_right = true
    params.vowel_left = true
    params.vowel_bottom_right = true
  } else if vowel != none {
    panic("Invalid vowel '" + vowel + "'")
  }

  if ("b",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_bottom_right = true
  } else if ("tch",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_bottom_middle = true
  } else if ("d",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_bottom_left = true
    params.consonant_bottom_right = true
  } else if ("f",).contains(consonant) {
    params.consonant_top_right = true
    params.consonant_bottom_left = true
    params.consonant_bottom_middle = true
  } else if ("g",).contains(consonant) {
    params.consonant_top_right = true
    params.consonant_bottom_middle = true
    params.consonant_bottom_right = true
  } else if ("h",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_bottom_middle = true
    params.consonant_bottom_right = true
  } else if ("juh",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_bottom_left = true
  } else if ("k",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_top_right = true
    params.consonant_bottom_right = true
  } else if ("l",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_bottom_middle = true
  } else if ("m",).contains(consonant) {
    params.consonant_bottom_left = true
    params.consonant_bottom_right = true
  } else if ("n",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_bottom_left = true
    params.consonant_bottom_right = true
  } else if ("ng",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_middle = true
    params.consonant_top_right = true
    params.consonant_bottom_left = true
    params.consonant_bottom_middle = true
    params.consonant_bottom_right = true
  } else if ("p",).contains(consonant) {
    params.consonant_top_right = true
    params.consonant_bottom_middle = true
  } else if ("r",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_top_right = true
    params.consonant_bottom_middle = true
  } else if ("s",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_top_right = true
    params.consonant_bottom_left = true
    params.consonant_bottom_middle = true
  } else if ("sh",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_right = true
    params.consonant_bottom_left = true
    params.consonant_bottom_middle = true
    params.consonant_bottom_right = true
  } else if ("t",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_right = true
    params.consonant_bottom_middle = true
  } else if ("th-sharp",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_middle = true
    params.consonant_top_right = true
    params.consonant_bottom_middle = true
  } else if ("th-soft",).contains(consonant) {
    params.consonant_top_middle = true
    params.consonant_bottom_left = true
    params.consonant_bottom_middle = true
    params.consonant_bottom_right = true
  } else if ("v",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_middle = true
    params.consonant_bottom_right = true
  } else if ("w",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_right = true
  } else if ("yuh",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_middle = true
    params.consonant_bottom_middle = true
  } else if ("z",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_middle = true
    params.consonant_bottom_middle = true
    params.consonant_bottom_right = true
  } else if ("zh",).contains(consonant) {
    params.consonant_top_left = true
    params.consonant_top_middle = true
    params.consonant_top_right = true
    params.consonant_bottom_right = true
    params.consonant_bottom_left = true
    params.consonant_bottom_right = true
  } else if consonant != none {
    panic("Invalid consonant '" + consonant + "'")
  }

  raw-rune(..params, ..args)
}

#let schema-rune(
  params_list,
  height: 1em,
) = block(
  breakable: false,
  height: height + 0.6em * 40%,
  block(
    height: height,
    width: height * 0.6,
    stroke: (paint: black, thickness: 1pt, dash: "dashed"),
  )[
    #for params in params_list {
      place(raw-rune(..params))
    }
  ],
)
