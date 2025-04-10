// LTeX: enabled=false

#let rune(
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
  horizontal: true,
  stroke: 0.75pt + black,
) = box(width: 0.6em, height: 1em)[
  #let stroke = (
    paint: stroke.paint,
    thickness: stroke.thickness,
    cap: if (stroke.cap == auto) { "round" } else { stroke.cap },
    join: if (stroke.join == auto) { "round" } else { stroke.join },
    dash: stroke.dash,
    miter-limit: stroke.miter-limit,
  )
  #set line(stroke: stroke)
  #set circle(stroke: stroke)

  #let OFFSET = if (horizontal) { 17.5% } else { 25% }
  #let POINTS = (
    top_left: (0%, OFFSET),
    top_middle: (50%, 0%),
    top_right: (100%, OFFSET),
    middle_left: (0%, 50%),
    center: (50%, 50%),
    middle_right: (100%, 50%),
    middle_top_left: (0%, 50% + OFFSET),
    middle_bottom_left: (0%, 50% + OFFSET),
    center_top: if (horizontal) { (50%, 50% - OFFSET) } else { (50%, 50%) },
    center_bottom: if (horizontal) { (50%, 50% + OFFSET) } else { (50%, 50%) },
    bottom_left: (0%, 100% - OFFSET),
    bottom_middle: (50%, 100%),
    bottom_right: (100%, 100% - OFFSET),
  )

  #if (horizontal) {
    place(line(start: POINTS.middle_left, end: POINTS.middle_right))
  }
  #if (vowel_top_left) {
    place(line(start: POINTS.top_middle, end: POINTS.top_left))
  }
  #if (vowel_top_right) {
    place(line(start: POINTS.top_middle, end: POINTS.top_right))
  }
  #if (vowel_left) {
    if (horizontal) {
      place(line(start: POINTS.top_left, end: POINTS.middle_left))
      place(line(start: POINTS.middle_bottom_left, end: POINTS.bottom_left))
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
    place(line(start: POINTS.center_top, end: POINTS.top_middle))
  }
  #if (consonant_top_right) {
    place(line(start: POINTS.center_top, end: POINTS.top_right))
  }
  #if (consonant_bottom_left) {
    place(line(start: POINTS.center_bottom, end: POINTS.bottom_left))
  }
  #if (consonant_bottom_middle) {
    if (horizontal) {
      place(line(start: POINTS.center_top, end: POINTS.center))
      place(line(start: POINTS.center_bottom, end: POINTS.bottom_middle))
    } else {
      place(line(start: POINTS.center_top, end: POINTS.bottom_middle))
    }
  }
  #if (consonant_bottom_right) {
    place(line(start: POINTS.center_bottom, end: POINTS.bottom_right))
  }
  #if (invert_vowel_consonant) {
    let (dx, dy) = POINTS.bottom_middle
    let width = 40%
    place(dx: dx - width / 2, dy: dy, circle(width: width))
  }
]
