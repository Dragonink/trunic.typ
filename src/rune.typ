#import "syllabic-rune.typ": syllabic-rune, VOWELS, CONSONANTS


#let SYLLABLES = (:)
#{
  for vowel in VOWELS.map(vowel => vowel.keys).flatten() {
    SYLLABLES.insert(vowel, arguments(vowel, none))
    for consonant in CONSONANTS.map(consonant => consonant.keys).flatten() {
      SYLLABLES.insert(
        consonant + vowel,
        arguments(vowel, consonant),
      )
      SYLLABLES.insert(
        vowel + consonant,
        arguments(vowel, consonant, invert_consonant_vowel: true),
      )
    }
  }
  for consonant in CONSONANTS.map(consonant => consonant.keys).flatten() {
    SYLLABLES.insert(consonant, arguments(none, consonant))
  }
}

/// Draws the rune by converting the given `syllable` to an argument set of `vowel`, `consonant` and `invert_consonant_vowel`, and giving them to the #link(<syllabic-rune>)[#show-function-name("syllabic-rune") function].
///
/// #gentle-clues.code(title: [Passed-down parameters])[
///   The `lined`, `height`, `width` and `..args` parameters are passed down to the #link(<syllabic-rune>)[#show-function-name("syllabic-rune") function].
/// ]
///
/// -> content
#let rune(
  /// ```example
  /// A single vowel: #rune("æ") \
  /// A single consonant: #rune("b") \
  /// A combination of both, with the inversion mark segment inferred: #rune("bæ") #rune("æb")
  /// ```
  ///
  /// -> str
  syllable,
  /// -> bool
  lined: true,
  /// -> length
  height: 1em,
  /// -> length | auto
  width: auto,
  /// -> arguments
  ..args,
) = syllabic-rune(
  ..SYLLABLES.at(syllable),
  lined: lined,
  height: height,
  width: width,
  ..args,
)
