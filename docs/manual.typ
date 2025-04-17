#import "/src/lib.typ" as trunic

#import "@preview/ascii-ipa:2.0.0": xsampa
#import "@preview/gentle-clues:1.2.0"
#import "@preview/tablex:0.0.9"
#import "@preview/tidy:0.4.2"
#import "@preview/tiptoe:0.3.0"


#let PACKAGE = toml("/typst.toml").package
#let DOCS = (
  trunic: tidy.parse-module(read("/src/lib.typ")),
  rune-sizes: tidy.parse-module(read("/src/rune-sizes.typ")),
  segmented-rune: tidy.parse-module(read("/src/segmented-rune.typ")),
  syllabic-rune: tidy.parse-module(read("/src/syllabic-rune.typ")),
  rune: tidy.parse-module(read("/src/rune.typ")),
)

#let show-type(type) = {
  let colors = (
    "auto": rgb("#ffd2ca"),
    arguments: rgb("#fcdfff"),
    array: rgb("#fcdfff"),
    bool: rgb("#ffecbf"),
    content: rgb("#a6ebe6"),
    dictionary: rgb("#fcdfff"),
    length: rgb("#ffecbf"),
    "none": rgb("#ffd2ca"),
    ratio: rgb("#ffecbf"),
    str: rgb("#d1ffe2"),
    stroke: gradient.linear(
      (rgb("#7cd5ff"), 0%),
      (rgb("#a6fbca"), 33%),
      (rgb("#fff37c"), 66%),
      (rgb("#ffa49d"), 100%),
    ),
  )
  let url = (
    "auto": "foundations/auto/",
    arguments: "foundations/arguments/",
    array: "foundations/array/",
    bool: "foundations/bool/",
    dictionary: "foundations/dictionary/",
    content: "foundations/content/",
    length: "layout/length/",
    "none": "foundations/none/",
    ratio: "layout/ratio/",
    str: "foundations/str/",
    stroke: "visualize/stroke/",
  )

  let content = box(
    fill: colors.at(type, default: rgb("#eff0f3")),
    outset: 2pt,
    radius: 2pt,
    raw(type),
  )
  if type in url {
    link("https://typst.app/docs/reference/" + url.at(type), content)
  } else { content }
}
#let show-function-name(fn) = text(
  fill: rgb("#4b69c6"),
  raw(if type(fn) == str { fn } else { fn.name }),
)
#let trunic-eval(source, scope: (:)) = context {
  set heading(offset: counter(heading).get().len())

  eval(
    "#import trunic: *\n" + source,
    mode: "markup",
    scope: (
      show-type: show-type,
      show-function-name: show-function-name,
      trunic: trunic,
      gentle-clues: gentle-clues,
      tablex: tablex,
      xsampa: xsampa,
    )
      + scope,
  )
}
#let render-examples(body, scope: (:)) = context {
  let size = text.size
  show raw.where(lang: "example"): this => {
    set text(size: size)
    set grid.cell(breakable: false, inset: 5pt)

    grid(
      columns: (50%,) * 2,
      rows: 1,
      [
        #raw(block: true, lang: "typ", this.text)
        #align(
          right,
          text(0.75em, gray)[Rendered example code #sym.arrow.r.long],
        )
      ],
      grid.cell(
        stroke: 1pt + gray,
        text(
          font: (),
          trunic-eval(scope: scope, this.text),
        ),
      ),
    )
  }

  body
}
#let show-parameter-list(fn) = block(
  breakable: false,
  pad(left: 10pt)[
    #show-function-name(fn)`(` \
    #for (name, props) in fn.args {
      [#sym.space.quad #raw(name)`:`]
      for type in props.types [~ #show-type(type)]
      if "default" in props [~ `=` #raw(lang: "typc", props.default)]
      [`,` \ ]
    }
    `)` #sym.arrow.r ~
    #for type in fn.return-types { show-type(type) }
  ],
)
#let show-parameter-block(fn, name, scope: (:)) = [
  #let arg = fn.args.at(name)
  The #raw(name) parameter accepts values of types ~#arg.types.map(show-type).join([, ], last: [~ or ~])~.
  #if "default" in arg [ Defaults to #raw(lang: "typc", arg.default). ]

  #render-examples(
    trunic-eval(
      arg.description,
      scope: scope,
    ),
    scope: scope,
  )
]
#let show-function(fn, scope: (:)) = {
  show-parameter-list(fn)
  render-examples(
    trunic-eval(
      fn.description,
      scope: scope,
    ),
    scope: scope,
  )
}
#let show-variable(var, scope: (:)) = [
  The #raw(var.name) variable is of type ~#show-type(var.type)~.

  #render-examples(
    trunic-eval(var.description, scope: scope),
    scope: scope,
  )
]


#set document(
  title: "Manual of " + PACKAGE.name + ".typ v" + PACKAGE.version,
  author: PACKAGE.authors.map(author => author.replace(regex("\s*<.*>"), "")),
)
#show figure.caption: self => [
  *#self.supplement #context self.counter.display(self.numbering)#self.separator*
  #self.body
]
#show figure.where(kind: "rune-schema"): set figure(supplement: [Rune schema])
#set par(justify: true)
#show link: self => {
  if (
    type(self.dest) == str
      and self.dest.starts-with("https://typst.app/docs/reference/")
      and self.dest.ends-with("/")
  ) {
    self
  } else {
    underline(self)
  }
}
#show ref: underline

#show "Tunic": set text(style: "italic")
#show "Trunic": set text(style: "italic")


#align(center)[
  #text(
    size: 4em,
    weight: "semibold",
    fill: rgb("#239dad"),
    PACKAGE.name + ".typ",
  ) \
  #text(size: 1.5em)[v#PACKAGE.version]
]
#v(1fr)

This library provides functions to easily write Trunic runes in a Typst document.

#heading(numbering: none, outlined: false, depth: 6)[About Tunic & Trunic]

The video game Tunic (https://tunicgame.com) features a rune-like language called Trunic.
Most of the text in game is written in this language.

#gentle-clues.danger(title: [Tunic spoilers])[
  *Using this library requires that you understand how Trunic works.*

  Since translating Trunic is one of the last puzzles of the game,
  *this manual will effectively spoil you the solution of this puzzle*.

  Thus, if you want to solve the puzzle by yourself, you should avoid reading this manual and using this library.
]
#gentle-clues.tip(title: [More about Trunic])[
  - Tunic Wiki's page about Trunic: https://tunic.fandom.com/wiki/Tunic_Script.
  - A graphical interface to play with Trunic runes: https://aryanpingle.github.io/Runic/
]

#heading(numbering: none, outlined: false, depth: 6)[About this manual]

This manual details the library's API by going from "low-level" to "high-level" functions, explaining Trunic along the way.


#set page(numbering: "1/1")
#set heading(numbering: "I.1.")
#show heading.where(depth: 1): self => {
  colbreak(weak: true)
  self
}

#outline(depth: 2)


#let rune-sizes = DOCS.rune-sizes.functions.find(fn => (
  fn.name == "rune-sizes"
))
= Sizes of a rune: the #show-function-name(rune-sizes) function <rune-sizes>

#show-function(
  rune-sizes,
  scope: (
    rune-schema: {
      let SIZES = trunic.rune-sizes(height: 6em)
      let SPACING = 1em
      let HEIGHT_X = 2 * (SIZES.width + SPACING)
      let TOTAL_HEIGHT_X = HEIGHT_X + 2em
      let INVERSION_Y = 2.5em
      let WIDTH_Y = SIZES.total_height + 3em

      align(
        center,
        figure(
          kind: "rune-schema",
          caption: [Sizes of a normal rune (left) and a lined rune (right)],
          box(
            height: 12em,
            width: TOTAL_HEIGHT_X + 2em,
          )[
            #for dx in (
              0pt,
              SIZES.width,
              SIZES.width + SPACING,
              2 * SIZES.width + SPACING,
            ) {
              place(
                dx: dx,
                line(
                  start: (0pt, 0pt),
                  end: (0pt, WIDTH_Y),
                  stroke: (paint: green, dash: "dashed"),
                ),
              )
            }
            #for dx in (0pt, SIZES.width + SPACING) {
              place(
                dx: dx,
                dy: WIDTH_Y,
                tiptoe.line(
                  length: SIZES.width,
                  stroke: green,
                  tip: tiptoe.straight,
                  toe: tiptoe.straight,
                ),
              )
            }
            #place(
              dx: SIZES.width - 7pt,
              dy: WIDTH_Y + 6pt,
              text(green)[`width`],
            )

            #place(
              stack(
                dir: ltr,
                spacing: SPACING,
                trunic.segmented-rune(
                  ..arguments(..trunic.ALL-SEGMENTS, lined: false),
                  height: SIZES.height,
                ),
                trunic.segmented-rune(
                  ..trunic.ALL-SEGMENTS,
                  height: SIZES.height,
                ),
              ),
            )

            #for dy in (0pt, SIZES.height) {
              place(
                dy: dy,
                line(
                  length: HEIGHT_X,
                  stroke: (paint: blue, dash: "dashed"),
                ),
              )
            }
            #place(
              dx: HEIGHT_X,
              tiptoe.line(
                start: (0pt, 0pt),
                end: (0pt, SIZES.height),
                stroke: blue,
                tip: tiptoe.straight,
                toe: tiptoe.straight,
              ),
            )
            #place(
              dx: HEIGHT_X - 0.75em,
              dy: SIZES.height / 2,
              rotate(90deg, text(blue)[`height`]),
            )

            #place(
              dy: SIZES.total_height,
              line(length: HEIGHT_X, stroke: (paint: red, dash: "dashed")),
            )
            #for dx in (
              (SIZES.width - SIZES.inversion_mark_diameter) / 2,
              (SIZES.width + SIZES.inversion_mark_diameter) / 2,
              SIZES.width
                + SPACING
                + (SIZES.width - SIZES.inversion_mark_diameter) / 2,
              SIZES.width
                + SPACING
                + (SIZES.width + SIZES.inversion_mark_diameter) / 2,
            ) {
              place(
                dx: dx,
                dy: SIZES.height,
                line(
                  start: (0pt, 0pt),
                  end: (0pt, INVERSION_Y),
                  stroke: (paint: red, dash: "dashed"),
                ),
              )
            }
            #place(
              dx: HEIGHT_X,
              dy: SIZES.height,
              tiptoe.line(
                start: (0pt, 0pt),
                end: (0pt, SIZES.inversion_mark_diameter),
                stroke: red,
                tip: tiptoe.straight,
                toe: tiptoe.straight,
              ),
            )
            #for dx in (
              (SIZES.width - SIZES.inversion_mark_diameter) / 2,
              SIZES.width
                + SPACING
                + (SIZES.width - SIZES.inversion_mark_diameter) / 2,
            ) {
              place(
                dx: dx,
                dy: SIZES.height + INVERSION_Y,
                tiptoe.line(
                  length: SIZES.inversion_mark_diameter,
                  stroke: red,
                  tip: tiptoe.straight,
                  toe: tiptoe.straight,
                ),
              )
            }
            #place(
              dy: SIZES.height + INVERSION_Y + 0.5em,
              box(fill: white, text(red)[`inversion_mark_diameter`]),
            )

            #place(
              dx: HEIGHT_X,
              line(
                length: TOTAL_HEIGHT_X - HEIGHT_X,
                stroke: (paint: purple, dash: "dashed"),
              ),
            )
            #place(
              dx: HEIGHT_X,
              dy: SIZES.total_height,
              line(
                length: TOTAL_HEIGHT_X - HEIGHT_X,
                stroke: (paint: purple, dash: "dashed"),
              ),
            )
            #place(
              dx: TOTAL_HEIGHT_X,
              tiptoe.line(
                start: (0pt, 0pt),
                end: (0pt, SIZES.total_height),
                stroke: purple,
                tip: tiptoe.straight,
                toe: tiptoe.straight,
              ),
            )
            #place(
              dx: TOTAL_HEIGHT_X - 2em,
              dy: SIZES.total_height / 2,
              rotate(90deg, text(purple)[`total_height`]),
            )
          ],
        ),
      )
    },
  ),
)

#block(breakable: false)[
  == Height of a rune: the `height` parameter <rune-sizes.height>

  #show-parameter-block(rune-sizes, "height")
]

#block(breakable: false)[
  == Width of a rune: the `width` parameter <rune-sizes.width>

  #show-parameter-block(rune-sizes, "width")
]

#let segmented-rune = DOCS.segmented-rune.functions.find(fn => (
  fn.name == "segmented-rune"
))
= Structure of a rune: the #show-function-name(segmented-rune) function <segmented-rune>

#let show-lined-schemas(caption, ..runes) = {
  let runes = (
    arguments(
      ..trunic.ALL-VOWEL-SEGMENTS,
      stroke: (thickness: 1pt, paint: blue, dash: "dotted"),
    ),
    arguments(
      ..trunic.ALL-CONSONANT-SEGMENTS,
      stroke: (thickness: 1pt, paint: green, dash: "dotted"),
    ),
    arguments(
      invert_consonant_vowel: true,
      stroke: (thickness: 1pt, paint: red, dash: "dotted"),
    ),
    ..runes.pos(),
  )

  align(
    center,
    figure(
      kind: "rune-schema",
      caption: caption,
      stack(
        dir: ltr,
        spacing: 1em,
        trunic.superimpose-segmented-runes(
          ..runes.map(args => arguments(..args, lined: false)),
          height: 6em,
        ),
        trunic.superimpose-segmented-runes(
          ..runes,
          (stroke: 3pt + black),
          height: 6em,
        ),
      ),
    ),
  )
}

#show-function(
  segmented-rune,
  scope: (
    show-lined-schemas: show-lined-schemas,
    segments: trunic.ALL-SEGMENTS.named(),
  ),
)

== Vowel segments: the `vowel_*` parameters <segmented-rune.vowels>

#let vowel-segments = (
  segmented-rune.args.keys().filter(name => name.starts-with("vowel_"))
)

The vowel segments are the #vowel-segments.len() outer segments of the rune.

#for segment in vowel-segments {
  block(breakable: false, width: 100%)[
    === The #raw(segment) parameter #label("segmented-rune." + segment)

    #let params = (stroke: 3pt + blue)
    #params.insert(segment, true)
    #show-parameter-block(
      segmented-rune,
      segment,
      scope: (
        show-segment: show-lined-schemas(
          [The #raw(segment) segment in a normal rune (left) and a lined rune (right).],
          params,
        ),
      ),
    )
  ]
}

== Consonant segments: the `consonant_*` parameters <segmented-rune.consonants>

#let consonant-segments = (
  segmented-rune.args.keys().filter(name => name.starts-with("consonant_"))
)

The consonant segments are the #consonant-segments.len() inner segments of the rune.

#for segment in consonant-segments {
  block(breakable: false, width: 100%)[
    === The #raw(segment) parameter #label("segmented-rune." + segment)

    #let params = (stroke: 3pt + green)
    #params.insert(segment, true)
    #show-parameter-block(
      segmented-rune,
      segment,
      scope: (
        show-segment: show-lined-schemas(
          [The #raw(segment) segment in a normal rune (left) and a lined rune (right).],
          params,
        ),
      ),
    )
  ]
}

#block(breakable: false, width: 100%)[
  == Inversion mark segment: the `invert_consonant_vowel` parameter <segmented-rune.invert_consonant_vowel>

  #show-parameter-block(
    segmented-rune,
    "invert_consonant_vowel",
    scope: (
      show-segment: show-lined-schemas(
        [The `invert_consonant_vowel` segment in a normal rune (left) and a lined rune (right).],
        (invert_consonant_vowel: true, stroke: 3pt + red),
      ),
    ),
  )
]

#block(breakable: false)[
  == Lined rune: the `lined` parameter <segmented-rune.lined>

  #show-parameter-block(segmented-rune, "lined")
]

#block(breakable: false)[
  == Rest parameters <segmented-rune.rest>

  #show-parameter-block(segmented-rune, "..args")
]

== Helper constants <segmented-rune.consts>

#for var in DOCS.segmented-rune.variables {
  show-variable(var)
}

#let syllabic-rune = DOCS.syllabic-rune.functions.find(fn => (
  fn.name == "syllabic-rune"
))
= Composition of a rune: the #show-function-name(syllabic-rune) function <syllabic-rune>

#show-function(syllabic-rune)

== Vowel table: the `vowel` parameter <syllabic-rune.vowel>

#show-parameter-block(syllabic-rune, "vowel")

== Consonant table: the `consonant` parameter <syllabic-rune.consonant>

#show-parameter-block(syllabic-rune, "consonant")

#block(breakable: false)[
  == Inversion mark segment: the `invert_consonant_vowel` parameter <syllabic-rune.invert_consonant_vowel>

  #show-parameter-block(
    syllabic-rune,
    "invert_consonant_vowel",
  )
]

#let rune = DOCS.rune.functions.find(fn => fn.name == "rune")
= Easily writing a rune: the #show-function-name(rune) function <rune>

#show-function(rune)

#block(breakable: false)[
  == The `syllable` parameter <rune.syllable>

  #show-parameter-block(rune, "syllable")
]

#let trunic-word = DOCS.trunic.functions.find(fn => fn.name == "trunic-word")
= Easily writing a word in Trunic: the #show-function-name(trunic-word) function <trunic-word>

#show-function(trunic-word)

#block(breakable: false)[
  == The `syllables` parameter <trunic-word.syllables>

  #show-parameter-block(trunic-word, "syllables")
]

#let trunic = DOCS.trunic.functions.find(fn => fn.name == "trunic")
= Easily writing text in Trunic: the #show-function-name(trunic) function <trunic>

#show-function(trunic)

#block(breakable: false)[
  == The `words` parameter <trunic-word.words>

  #show-parameter-block(trunic, "words")
]
