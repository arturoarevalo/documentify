
Documentify = require "../src/documentify"

schema = require "schemify"



model = schema.of
    a: schema.integer.default 1
    b: schema.integer.default 2
    c: schema.integer.default 3
    d: schema.string.default "abc"

doc = new Documentify { contentModel : model }


a = doc.createNew "doc-1", "aarevalo"
console.log a.versions
