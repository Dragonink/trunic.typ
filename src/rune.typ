#let VOWELS = (
  "a": ("top_left", "top_right", "left"),
  "ah": (
    "top_left",
    "top_right",
    "bottom_left",
    "bottom_right",
  ),
  "aw": ("top_left", "left"),
  "ay": ("top_left",),
  "eh": ("left", "bottom_left", "bottom_right"),
  "ee": ("top_left", "left", "bottom_left", "bottom_right"),
  "ear": ("top_left", "left", "bottom_right"),
  "uh": ("top_left", "top_right"),
  "air": ("left", "bottom_right"),
  "ee-sharp": ("bottom_left", "bottom_right"),
  "aye": ("top_right",),
  "uhr": ("top_right", "left", "bottom_left", "bottom_right"),
  "oh": ("top_left", "top_right", "left", "bottom_left", "bottom_right"),
  "oi": ("bottom_left",),
  "oo-long": ("top_left", "top_right", "left", "bottom_left"),
  "oo-short": ("left", "bottom_left"),
  "ow": ("bottom_right",),
  "oar": ("top_left", "top_right", "left", "bottom_right"),
)
// #VOWELS += (
// "ei": VOWELS.ay,
// "our": VOWELS.oar,
// )

#let CONSONANTS = (
  "b": ("top_middle", "bottom_right"),
  "tch": ("top_left", "bottom_middle"),
  "d": ("top_middle", "bottom_left", "bottom_right"),
  "f": ("top_right", "bottom_left", "bottom_middle"),
  "g": ("top_right", "bottom_middle", "bottom_right"),
  "h": ("top_middle", "bottom_middle", "bottom_right"),
  "juh": ("top_middle", "bottom_left"),
  "k": ("top_middle", "top_right", "bottom_right"),
  "l": ("top_middle", "bottom_middle"),
  "m": ("bottom_left", "bottom_right"),
  "n": ("top_left", "bottom_left", "bottom_right"),
  "ng": (
    "top_left",
    "top_middle",
    "top_right",
    "bottom_left",
    "bottom_middle",
    "bottom_right",
  ),
  "p": ("top_right", "bottom_middle"),
  "r": ("top_middle", "top_right", "bottom_middle"),
  "s": ("top_middle", "top_right", "bottom_left", "bottom_middle"),
  "sh": (
    "top_left",
    "top_right",
    "bottom_left",
    "bottom_middle",
    "bottom_right",
  ),
  "t": ("top_left", "top_right", "bottom_middle"),
  "th-sharp": ("top_left", "top_middle", "top_right", "bottom_middle"),
  "th-soft": ("top_middle", "bottom_left", "bottom_middle", "bottom_right"),
  "v": ("top_left", "top_middle", "bottom_right"),
  "w": ("top_left", "top_right"),
  "yuh": ("top_left", "top_middle", "bottom_middle"),
  "z": ("top_left", "top_middle", "bottom_middle", "bottom_right"),
  "zh": (
    "top_left",
    "top_middle",
    "top_right",
    "bottom_left",
    "bottom_right",
  ),
)

/// Draws a *valid* rune by setting the vowel part, the consonant part and the inversion mark.
/// -> content
#let rune(
  /// -> str | none
  vowel,
  /// -> str | none
  consonant,
  /// -> bool
  invert_vowel_consonant: false,
  /// -> bool
  lined: true,
  /// -> length
  height: 1em,
  /// -> length | auto
  width: auto,
  /// -> arguments
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
  )

  if vowel != none {
    assert(vowel in VOWELS, message: "Invalid vowel '" + vowel + "'")
    for segment in VOWELS.at(vowel) {
      params.at("vowel_" + segment) = true
    }
  }
  if consonant != none {
    assert(
      consonant in CONSONANTS,
      message: "Invalid consonant '" + consonant + "'",
    )
    for segment in CONSONANTS.at(consonant) {
      params.at("consonant_" + segment) = true
    }
  }

  raw-rune(
    ..params,
    invert_vowel_consonant: invert_vowel_consonant,
    lined: lined,
    height: height,
    width: width,
  )
}

