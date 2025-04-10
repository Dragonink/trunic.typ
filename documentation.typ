#import "trunic.typ"

#let TITLE = "Trunic documentation"
#set document(title: TITLE)
#set page(numbering: "1/1")

#show link: set text(blue)
#show link: underline

#let SCHEMA_SIZE = 64pt
#let SCHEMA_THICKNESS = 3pt

#let schema-rune(params_list) = {
  set text(size: SCHEMA_SIZE)

  trunic.schema-rune(params_list.map((params) => {
    let segment_stroke = stroke(params.at("stroke", default: (:)))
    let segment_stroke = stroke((
      paint: segment_stroke.paint,
      thickness: if segment_stroke.thickness == auto { SCHEMA_THICKNESS } else { segment_stroke.thickness },
      cap: segment_stroke.cap,
      join: segment_stroke.join,
      dash: segment_stroke.dash,
      miter-limit: segment_stroke.miter-limit,
    ))

    arguments(..params, stroke: segment_stroke)
  }))
}

#let rune-table(param, rune_list, rune) = [
  #let print-id(id) = id.split("/").map((id) => [*#raw("\"" + id + "\"", lang: "typc")*])

  The #raw(param) parameter accepts any of the following values:
  #rune_list.map(((id, ipa)) => print-id(id)).flatten().join(", ", last: " or ").

  #grid(
    columns: 5,
    gutter: 1em,
    ..rune_list.map(((id, ipa)) => block(
      breakable: false,
      width: 100%,
      inset: (x: 1em, y: 0.5em),
      stroke: 1pt + black,
      radius: 5pt,
      align(center, stack(
        dir: ttb,
        spacing: 0.5em,
        text(size: SCHEMA_SIZE, rune(id.split("/").first())),
        print-id(id).join("/"),
        ipa,
      ))
    )),
  )
]


#align(center, text(size: 3em)[*#TITLE*])

= `rune` function <rune>

The `rune` function draws a single rune by choosing the vowel and consonant.

== `vowel` parameter <rune.vowel>

#rune-table(
  "vowel",
  (
    ("a", "æ"),
    ("ah", "ɑɹ"),
    ("aw", "ɑ"),
    ("ay/ei", "eɪ"),
    ("eh", "ɛ"),
    ("ee", "i"),
    ("ear", "ɪɹ"),
    ("uh", "ə"),
    ("air", "ɛɹ"),
    ("ee-sharp", "ɪ"),
    ("aye", "aɪ"),
    ("uhr", "ɝ"),
    ("oh", "oʊ"),
    ("oi", "ɔɪ"),
    ("oo-long", "u"),
    ("oo-short", "ʊ"),
    ("ow", "aʊ"),
    ("oar/our", "ɔɹ/ʊɹ"),
  ),
  (vowel) => trunic.rune(vowel, none, stroke: SCHEMA_THICKNESS),
)

== `consonant` parameter <rune.consonant>

#rune-table(
  "consonant",
  (
    ("b", "b"),
    ("tch", "tʃ"),
    ("d", "d"),
    ("f", "f"),
    ("g", "ɡ"),
    ("h", "h"),
    ("juh", "dʒ"),
    ("k", "k"),
    ("l", "l/ɫ"),
    ("m", "m"),
    ("n", "n"),
    ("ng", "ŋ"),
    ("p", "p"),
    ("r", "ɹ"),
    ("s", "s"),
    ("sh", "ʃ"),
    ("t", "t"),
    ("th-sharp", "θ"),
    ("th-soft", "ð"),
    ("v", "v"),
    ("w", "w"),
    ("yuh", "j"),
    ("z", "z"),
    ("zh", "ʒ"),
  ),
  (consonant) => trunic.rune(none, consonant, stroke: SCHEMA_THICKNESS),
)

== Other parameters

- *`invert_vowel_consonant`* is a boolean flag that enables the #link(<raw-rune.invert>)[inversion flag segment] (defaults to ```typc false```)
- *`ligatures`* is a boolean flag that enables the ligature form of the rune (defaults to ```typc true```)
- *`stroke`* is the #link("https://typst.app/docs/reference/visualize/stroke/")[```typc stroke```] parameter used to draw the segments (defaults to ```typc 0.75pt + black```)

#pagebreak()
= `raw-rune` function <raw-rune>

The `raw-rune` function draws a single rune by toggling each segment.

#align(center, stack(
  dir: ltr,
  spacing: 1em,
  schema-rune((
    (
      vowel_top_left: true,
      vowel_top_right: true,
      vowel_left: true,
      vowel_bottom_left: true,
      vowel_bottom_right: true,
      ligatures: false,
      stroke: blue,
    ),
    (
      consonant_top_left: true,
      consonant_top_middle: true,
      consonant_top_right: true,
      consonant_bottom_left: true,
      consonant_bottom_middle: true,
      consonant_bottom_right: true,
      ligatures: false,
      stroke: green,
    ),
    (
      invert_vowel_consonant: true,
      ligatures: false,
      stroke: red,
    ),
  )),
  schema-rune((
    (
      vowel_top_left: true,
      vowel_top_right: true,
      vowel_left: true,
      vowel_bottom_left: true,
      vowel_bottom_right: true,
      stroke: blue,
    ),
    (
      consonant_top_left: true,
      consonant_top_middle: true,
      consonant_top_right: true,
      consonant_bottom_left: true,
      consonant_bottom_middle: true,
      consonant_bottom_right: true,
      stroke: green,
    ),
    (
      invert_vowel_consonant: true,
      stroke: red,
    ),
    (
      stroke: black,
    ),
  )),
  {
    set box(baseline: -0.3em, width: 2em)
    set line(length: 100%)
    align(left, stack(
      dir: ttb,
      spacing: 0.5em,
      [#box(line(stroke: (paint: blue, thickness: 3pt, cap: "round"))) Vowel group],
      [#box(line(stroke: (paint: green, thickness: 3pt, cap: "round"))) Consonant group],
      [#box(baseline: 0.35em, align(center, circle(width: 64pt * 0.6 * 0.4, stroke: 3pt + red))) Invert vowel & consonant],
    ))
  },
))

A rune is the combination of 12 segments, split into 3 groups.

#let schema-segments(segments, paint) = align(center)[
  #for sublist in segments {
    block(breakable: false, stack(
      dir: ltr,
      spacing: 2em,
      ..sublist.map((segment) => {
        let segment_dict = (:)
        segment_dict.insert(segment, true)

        let pattern_dict = (:)
        for segment in segments.flatten() {
          pattern_dict.insert(segment, true)
        }

        stack(
          dir: ttb,
          spacing: 1em,
          raw(segment),
          stack(
            dir: ltr,
            spacing: 1em,
            schema-rune((
              pattern_dict + (
                ligatures: false,
                stroke: (paint: paint, thickness: 1pt, dash: "dashed"),
              ),
              segment_dict + (ligatures: false, stroke: paint,),
            )),
            schema-rune((
              pattern_dict + (stroke: (paint: paint, thickness: 1pt, dash: "dashed"),),
              segment_dict + (stroke: paint,),
              (stroke: black,),
            )),
          ),
        )
      }),
    ))
  }
]

== Vowel group <raw-rune.vowel>

#let vowel_segments = (
  ("vowel_top_left", "vowel_top_right"),
  ("vowel_left", "vowel_bottom_left", "vowel_bottom_right"),
)
The vowel group contains #vowel_segments.flatten().len() segments:
#schema-segments(vowel_segments, blue)

== Consonant group <raw-rune.consonant>

#let consonant_segments = (
  ("consonant_top_left", "consonant_top_middle", "consonant_top_right"),
  ("consonant_bottom_left", "consonant_bottom_middle", "consonant_bottom_right"),
)
The consonant group contains #consonant_segments.flatten().len() segments:
#schema-segments(consonant_segments, green)

== `invert_vowel_consonant` parameter <raw-rune.invert>

The inversion flag is a single segment that swaps the pronunciation of the vowel and the consonant:
#schema-segments((("invert_vowel_consonant",),), red)
