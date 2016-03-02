#

schema = require "schemify"


class Workflow
    constructor: (@states = []) ->
        @initialState = @states[0]

    isValidState: (state) -> state in @states


class Storage

    constructor: ->
        @idField = "_id"

    insertResource: (id, resource, callback) ->



class Documentify

    @DefaultHeaderModel = schema.of
        name: schema.string.required
        description: schema.string.default ""

    @DefaultWorkflow = new Workflow ["draft", "published"]

    constructor: (options = {}) ->
        @storage = options.storage or new Storage()
        @models =
            header: options.headerModel or Documentify.DefaultHeaderModel
            content: options.contentModel or schema.any
        @workflow = options.workflow or Documentify.DefaultWorkflow
        @initialVersion = "1.0.0"

        @versionModel = schema.of
            data: @models.content
            user: schema.string.required
            date: schema.any
            differences: schema.array.required.default([]).of schema.any

        @resourceModel = schema.of
            header: @models.header
            versions: schema.any




    createNew: (id, user, header, callback) ->

        versions = {}
        for state in @workflow.states
            versions[state] = null
        
        versions[@workflow.initialState] = @versionModel.createNew
            data: @models.content.createNew()
            user: user
            date: new Date()

        resource =
            header: @models.header.createNew header
            versions: versions

        resource[@storage.idField] = id

        return resource



module.exports = Documentify
