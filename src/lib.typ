#import "rune-sizes.typ": rune-sizes
#import "segmented-rune.typ": (
  segmented-rune,
  ALL-VOWEL-SEGMENTS,
  ALL-CONSONANT-SEGMENTS,
  ALL-SEGMENTS,
  superimpose-segmented-runes,
)
#import "syllabic-rune.typ": syllabic-rune, VOWELS, CONSONANTS
#import "rune.typ": rune


/// Writes a word in Trunic by splitting the given `syllables` and giving each of them to the #link(<rune>)[#show-function-name("rune") function].
///
/// #gentle-clues.code(title: [Passed-down parameters])[
/// The `lined`, `height`, `width` and `..args` parameters are passed down to the #link(<rune>)[#show-function-name("rune") function].
/// ]
///
/// -> content
#let word(
  /// Each given syllable is used to construct a single rune.
  ///
  /// If the type of the given `syllables` is ~#show-type("str")~,
  /// then the value is converted to an ~#show-type("array")~ by splitting it over fullstops ```typc "."```.
  ///
  /// ```example
  /// TUNIC \
  /// #word("si.k.ɹɪ.t") // SECRET
  /// #word(("ɫɛ", "dʒɛ", "n", "d")) // LEGEND
  /// ```
  ///
  /// -> str | array
  syllables,
  /// -> bool
  lined: true,
  /// -> length
  height: 1em,
  /// -> length | auto
  width: auto,
  /// -> arguments
  ..args,
) = {
  if type(syllables) == str {
    syllables = syllables.split(".")
  }
  for syllable in syllables {
    rune(syllable, lined: lined, height: height, width: width, ..args)
  }
}

/// Writes a text in Trunic by splitting the given `words` and giving each of them to the #link(<word>)[#show-function-name("word") function].
///
/// #gentle-clues.code(title: [Passed-down parameters])[
/// The `lined`, `height`, `width` and `..args` parameters are passed down to the #link(<word>)[#show-function-name("word") function].
/// ]
///
/// -> content
#let trunic(
  /// Each given word is used to construct a single word.
  ///
  /// If the type of the given `words` is ~#show-type("str")~,
  /// then the value is converted to an ~#show-type("array")~ by splitting it over spaces ```typc " "```.
  ///
  /// ```example
  /// TUNIC \
  /// // SECRET LEGEND
  /// #trunic("si.k.ɹɪ.t ɫɛ.dʒɛ.n.d")
  /// ```
  ///
  /// -> str | array
  words,
  /// -> bool
  lined: true,
  /// -> length
  height: 1em,
  /// -> length | auto
  width: auto,
  /// -> arguments
  ..args,
) = {
  if type(words) == str {
    words = words.split(" ")
  }
  for w in words [
    #word(w, lined: lined, height: height, width: width, ..args)
  ]
}
