#import "segmented-rune.typ": segmented-rune

#import "@preview/ascii-ipa:2.0.0": xsampa


#let VOWELS = (
  (
    keys: ("æ",),
    segments: ("top_left", "top_right", "left"),
  ),
  (
    keys: ("ɑɹ", "ɑːr"),
    segments: (
      "top_left",
      "top_right",
      "bottom_left",
      "bottom_right",
    ),
  ),
  (keys: ("ɑ", "ɔ", "ɑː", "ɒ"), segments: ("top_left", "left")),
  (keys: ("eɪ",), segments: ("top_left",)),
  (keys: ("ɛ",), segments: ("left", "bottom_left", "bottom_right")),
  (
    keys: ("i", "iː"),
    segments: ("top_left", "left", "bottom_left", "bottom_right"),
  ),
  (keys: ("ɪɹ", "ɪr", "ɪər"), segments: ("top_left", "left", "bottom_right")),
  (keys: ("ə", "ʌ"), segments: ("top_left", "top_right")),
  (keys: ("ɛɹ", "ær", "ɛr", "ɛər"), segments: ("left", "bottom_right")),
  (keys: ("ɪ",), segments: ("bottom_left", "bottom_right")),
  (keys: ("aɪ",), segments: ("top_right",)),
  (
    keys: ("ɝ", "ər", "ɜːr", "ʌr", "ʊr"),
    segments: ("top_right", "left", "bottom_left", "bottom_right"),
  ),
  (
    keys: ("oʊ",),
    segments: ("top_left", "top_right", "left", "bottom_left", "bottom_right"),
  ),
  (keys: ("ɔɪ",), segments: ("bottom_left",)),
  (
    keys: ("u", "uː"),
    segments: ("top_left", "top_right", "left", "bottom_left"),
  ),
  (keys: ("ʊ",), segments: ("left", "bottom_left")),
  (keys: ("aʊ",), segments: ("bottom_right",)),
  (
    keys: ("ɔɹ", "ʊɹ", "ɒr", "ɔːr"),
    segments: ("top_left", "top_right", "left", "bottom_right"),
  ),
)

#let CONSONANTS = (
  (keys: ("b",), segments: ("top_middle", "bottom_right")),
  (keys: ("tʃ",), segments: ("top_left", "bottom_middle")),
  (keys: ("d",), segments: ("top_middle", "bottom_left", "bottom_right")),
  (keys: ("f",), segments: ("top_right", "bottom_left", "bottom_middle")),
  (keys: ("ɡ",), segments: ("top_right", "bottom_middle", "bottom_right")),
  (keys: ("h",), segments: ("top_middle", "bottom_middle", "bottom_right")),
  (keys: ("dʒ",), segments: ("top_middle", "bottom_left")),
  (keys: ("k",), segments: ("top_middle", "top_right", "bottom_right")),
  (keys: ("l", "ɫ"), segments: ("top_middle", "bottom_middle")),
  (keys: ("m",), segments: ("bottom_left", "bottom_right")),
  (keys: ("n",), segments: ("top_left", "bottom_left", "bottom_right")),
  (
    keys: ("ŋ",),
    segments: (
      "top_left",
      "top_middle",
      "top_right",
      "bottom_left",
      "bottom_middle",
      "bottom_right",
    ),
  ),
  (keys: ("p",), segments: ("top_right", "bottom_middle")),
  (keys: ("ɹ",), segments: ("top_middle", "top_right", "bottom_middle")),
  (
    keys: ("s",),
    segments: ("top_middle", "top_right", "bottom_left", "bottom_middle"),
  ),
  (
    keys: ("ʃ",),
    segments: (
      "top_left",
      "top_right",
      "bottom_left",
      "bottom_middle",
      "bottom_right",
    ),
  ),
  (keys: ("t",), segments: ("top_left", "top_right", "bottom_middle")),
  (
    keys: ("θ",),
    segments: ("top_left", "top_middle", "top_right", "bottom_middle"),
  ),
  (
    keys: ("ð",),
    segments: ("top_middle", "bottom_left", "bottom_middle", "bottom_right"),
  ),
  (keys: ("v",), segments: ("top_left", "top_middle", "bottom_right")),
  (keys: ("w",), segments: ("top_left", "top_right")),
  (keys: ("j",), segments: ("top_left", "top_middle", "bottom_middle")),
  (
    keys: ("z",),
    segments: ("top_left", "top_middle", "bottom_middle", "bottom_right"),
  ),
  (
    keys: ("ʒ",),
    segments: (
      "top_left",
      "top_middle",
      "top_right",
      "bottom_left",
      "bottom_right",
    ),
  ),
)

/// Draws a *valid* rune by setting the #link(<syllabic-rune.vowel>)[vowel part], the #link(<syllabic-rune.consonant>)[consonant part] and the inversion mark.
///
/// #gentle-clues.warning(title: [Panics])[
///   Panics if the given `vowel` or `consonant` is unknown.
/// ]
///
/// -> content
#let syllabic-rune(
  /// Any IPA or X-SAMPA value in the following table is accepted:
  /// #columns(2, tablex.tablex(
  ///   columns: 3,
  ///   align: center + horizon,
  ///   repeat-header: true,
  ///   [*Rune (normal & lined)*], [*IPA*], [*X-SAMPA*],
  ///   ..VOWELS
  ///     .map(def => def.keys.enumerate().map(((i, key)) => (
  ///       if i == 0 {
  ///         tablex.rowspanx(def.keys.len(), stack(
  ///           dir: ltr,
  ///           spacing: 10pt,
  ///           syllabic-rune(key, none, lined: false, height: 2em),
  ///           syllabic-rune(key, none, height: 2em),
  ///         ))
  ///       } else { () },
  ///       key,
  ///       xsampa(key, reverse: true),
  ///     )))
  ///     .flatten()
  /// ))
  ///
  /// -> str | none
  vowel,
  /// Any IPA or X-SAMPA value in the following table is accepted:
  /// #columns(2, tablex.tablex(
  ///   columns: 3,
  ///   align: center + horizon,
  ///   repeat-header: true,
  ///   [*Rune (normal & lined)*], [*IPA*], [*X-SAMPA*],
  ///   ..CONSONANTS
  ///     .map(def => def.keys.enumerate().map(((i, key)) => (
  ///       if i == 0 {
  ///         tablex.rowspanx(def.keys.len(), stack(
  ///           dir: ltr,
  ///           spacing: 10pt,
  ///           syllabic-rune(none, key, lined: false, height: 2em),
  ///           syllabic-rune(none, key, height: 2em),
  ///         ))
  ///       } else { () },
  ///       key,
  ///       xsampa(key, reverse: true),
  ///     )))
  ///     .flatten()
  /// ))
  ///
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
    let vowel_def = VOWELS.find(def => (
      def.keys.contains(vowel) or def.keys.contains(xsampa(vowel))
    ))
    if vowel_def != none {
      for segment in vowel_def.segments {
        params.at("vowel_" + segment) = true
      }
    } else {
      panic("Invalid vowel '" + vowel + "'")
    }
  }
  if consonant != none {
    let consonant_def = CONSONANTS.find(def => (
      def.keys.contains(consonant) or def.keys.contains(xsampa(consonant))
    ))
    if consonant_def != none {
      for segment in consonant_def.segments {
        params.at("consonant_" + segment) = true
      }
    } else {
      panic("Invalid consonant '" + consonant + "'")
    }
  }

  segmented-rune(
    ..params,
    invert_vowel_consonant: invert_vowel_consonant,
    lined: lined,
    height: height,
    width: width,
  )
}

