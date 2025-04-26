#import "rune-sizes.typ": rune-sizes


/// A Trunic rune is a combination of #segments.len() optional segments.
///
/// This function draws the rune by enabling each segment independently.
///
/// #gentle-clues.code(title: [Passed-down parameters])[
///   The `height` and `width` parameters are passed down to the #link(<rune-sizes>)[#show-function-name("rune-sizes") function].
/// ]
///
/// #show-lined-schemas(
///   [All segments of a normal rune (left) and a lined rune (right).],
///   arguments(
///     ..ALL-VOWEL-SEGMENTS,
///     stroke: 3pt + blue,
///   ),
///   arguments(
///     ..ALL-CONSONANT-SEGMENTS,
///     stroke: 3pt + green,
///   ),
///   (
///     invert_consonant_vowel: true,
///     stroke: 3pt + red,
///   ),
/// )
///
/// #gentle-clues.example(title: "Segment colors")[
///   In this section,
///   the #link(<segmented-rune.vowels>)[vowel segments] are drawn in #text(blue)[*blue*],
///   the #link(<segmented-rune.consonants>)[consonant segments] in #text(green)[*green*]
///   and the #link(<segmented-rune.invert_consonant_vowel>)[inversion mark segment] in #text(red)[*red*].
/// ]
///
/// -> content
#let segmented-rune(
  /// #show-segment
  /// -> bool
  vowel_top_left: false,
  /// #show-segment
  /// -> bool
  vowel_top_right: false,
  /// #show-segment
  /// -> bool
  vowel_left: false,
  /// #show-segment
  /// -> bool
  vowel_bottom_left: false,
  /// #show-segment
  /// -> bool
  vowel_bottom_right: false,
  /// #show-segment
  /// -> bool
  consonant_top_left: false,
  /// #show-segment
  /// -> bool
  consonant_top_middle: false,
  /// #show-segment
  /// -> bool
  consonant_top_right: false,
  /// #show-segment
  /// -> bool
  consonant_bottom_left: false,
  /// #show-segment
  /// -> bool
  consonant_bottom_middle: false,
  /// #show-segment
  /// -> bool
  consonant_bottom_right: false,
  /// #show-segment
  /// -> bool
  invert_consonant_vowel: false,
  /// A Trunic rune can be written in two different styles: _normal_ or _lined_.
  ///
  /// The _lined_ style adds an horizontal line to cut the rune in half.
  /// This is the default style of runes in Tunic.
  ///
  /// ```example
  /// A normal rune: #segmented-rune(..ALL-SEGMENTS, lined: false) \
  /// The same rune, but lined: #segmented-rune(..ALL-SEGMENTS, lined: true)
  /// ```
  ///
  /// -> bool
  lined: true,
  /// -> length
  height: 1em,
  /// -> length | auto
  width: auto,
  /// #block(
  ///   breakable: false,
  ///   pad(left: 10pt)[
  ///     #show-type("arguments") `(` \
  ///     #for (name, props) in (
  ///       (name: "stroke", props: (types: ("stroke",), default: "0.75pt + black")),
  ///     ) {
  ///       [#sym.space.quad #raw(name)`:`]
  ///       for type in props.types [~ #show-type(type)]
  ///       if "default" in props [~ `=` #raw(lang: "typc", props.default)]
  ///       [`,` \ ]
  ///     }
  ///     `)`
  ///   ],
  /// )
  ///
  /// `stroke` is passed to the #link("https://typst.app/docs/reference/visualize/line/#parameters-stroke")[`stroke` parameter of the #show-function-name("line") function].
  ///
  /// -> arguments
  ..args,
) = {
  let SIZES = rune-sizes(
    height: height,
    width: width,
  )
  set box(width: SIZES.width)
  set circle(width: SIZES.inversion_mark_diameter)

  let segment_stroke = stroke(args.at("stroke", default: 0.75pt + black))
  segment_stroke = stroke((
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
    baseline: SIZES.inversion_mark_diameter,
    stack(
      dir: ttb,
      box(height: SIZES.cap_height)[
        #let OFFSET = if (lined) { 17.5% } else { 25% }
        #let POINTS = (
          top_left: (0%, OFFSET),
          top_middle: (50%, 0%),
          top_right: (100%, OFFSET),
          middle_left: (0%, 50%),
          center: (50%, 50%),
          middle_right: (100%, 50%),
          middle_top_left: (0%, 50% + OFFSET),
          middle_bottom_left: (0%, 50% + OFFSET),
          center_top: if (lined) { (50%, 50% - OFFSET) } else {
            (50%, 50%)
          },
          center_bottom: if (lined) { (50%, 50% + OFFSET) } else {
            (50%, 50%)
          },
          bottom_left: (0%, 100% - OFFSET),
          bottom_middle: (50%, 100%),
          bottom_right: (100%, 100% - OFFSET),
        )

        #if (lined) {
          place(line(start: POINTS.middle_left, end: POINTS.middle_right))
        }
        #if (vowel_top_left) {
          place(line(start: POINTS.top_middle, end: POINTS.top_left))
        }
        #if (vowel_top_right) {
          place(line(start: POINTS.top_middle, end: POINTS.top_right))
        }
        #if (vowel_left) {
          if (lined) {
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
          if (lined) {
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
      box(height: SIZES.inversion_mark_diameter)[
        #if (invert_consonant_vowel) {
          align(center, circle())
        }
      ],
    ),
  )
}

///
///
/// ```example
/// Draw all vowel segments: #segmented-rune(..ALL-VOWEL-SEGMENTS)
/// ```
///
/// -> arguments
#let ALL-VOWEL-SEGMENTS = arguments(
  vowel_top_left: true,
  vowel_top_right: true,
  vowel_left: true,
  vowel_bottom_left: true,
  vowel_bottom_right: true,
)

/// ```example
/// Draw all consonant segments: #segmented-rune(..ALL-CONSONANT-SEGMENTS)
/// ```
///
/// -> arguments
#let ALL-CONSONANT-SEGMENTS = arguments(
  consonant_top_left: true,
  consonant_top_middle: true,
  consonant_top_right: true,
  consonant_bottom_left: true,
  consonant_bottom_middle: true,
  consonant_bottom_right: true,
)

/// ```example
/// Draw all segments: #segmented-rune(..ALL-SEGMENTS)
/// ```
///
/// -> arguments
#let ALL-SEGMENTS = arguments(
  ..ALL-VOWEL-SEGMENTS,
  ..ALL-CONSONANT-SEGMENTS,
  invert_consonant_vowel: true,
)


/// -> content
#let superimpose-segmented-runes(
  /// -> arguments
  ..runes,
  /// -> length
  height: 1em,
  /// -> length | auto
  width: auto,
) = {
  let SIZES = rune-sizes(height: height, width: width)
  box(height: SIZES.height, width: SIZES.width)[
    #for rune in runes.pos() {
      place(segmented-rune(..rune, height: height, width: width))
    }
  ]
}
