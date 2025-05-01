#import "/src/lib.typ" as trunic


#let PACKAGE = toml("/typst.toml").package

#set page(width: 1280pt, height: 640pt, margin: 2em)
#set text(size: 6em)
#show: body => align(center + horizon, body)

#let TYPST-COLOR = rgb("#239dad")

#text(size: 3em, weight: "semibold", fill: TYPST-COLOR, PACKAGE.name + ".typ") \
TRUNIC
#trunic.word("taɪ.p.s.t", stroke: 3pt + TYPST-COLOR)
#trunic.word("laɪ.b.ɹə.ɹi", stroke: 3pt)

