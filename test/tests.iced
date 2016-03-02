documentify = require "../src/documentify"
assert = require "assert"

describe "string schema", () ->

    describe "without default value", () ->

        describe "validates as expected", () ->

            check = (param) ->
                schema.string.check param

            it "empty (NULL) values", (done) ->
                assert.strictEqual true, check null
                done()

