/// Computes the sizes of a rune, given its #link(<rune-sizes.height>)[height] and #link(<rune-sizes.width>)[width].
///
/// The returned value has the following structure:
/// #block(
///   breakable: false,
///   pad(left: 10pt)[
///     #show-type("dictionary") `(` \
///     #for name in rune-sizes().keys() [
///       #sym.space.quad #raw(name)`:` ~#show-type("length")`,` \
///     ]
///     `)`
///   ],
/// )
///
/// #rune-schema
///
/// The `inversion_mark_diameter` and `cap_height` values are computed as follows:
/// $
///   #raw("inversion_mark_diameter") &= #raw("height") times 20% \
///   #raw("cap_height") &= #raw("height") - #raw("inversion_mark_diameter")
/// $
///
/// -> dictionary
#let rune-sizes(
  /// Height of the rune.
  ///
  /// ```example
  /// The same rune with different heights: \
  /// #segmented-rune(..ALL-SEGMENTS, height: 1em)
  /// #segmented-rune(..ALL-SEGMENTS, height: 2em)
  /// #segmented-rune(..ALL-SEGMENTS, height: 3em)
  /// ```
  ///
  /// -> length
  height: 1em,
  /// Width of the rune. \
  /// If the value ```typc auto``` is given, the effective value will be computed as follows:
  /// $
  ///   #raw("width") = #raw("cap_height") times 60%
  /// $
  ///
  /// ```example
  /// The same rune with different widths: \
  /// #segmented-rune(..ALL-SEGMENTS, width: 1em) \
  /// #segmented-rune(..ALL-SEGMENTS, width: 2em) \
  /// #segmented-rune(..ALL-SEGMENTS, width: 3em)
  /// ```
  ///
  /// -> length | auto
  width: auto,
) = {
  let inversion_mark_diameter = height * 20%
  let cap_height = height - inversion_mark_diameter
  if width == auto {
    width = cap_height * 60%
  }

  (
    height: height,
    width: width,
    cap_height: height - inversion_mark_diameter,
    inversion_mark_diameter: inversion_mark_diameter,
  )
}

