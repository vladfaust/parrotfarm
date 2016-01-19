# This controller is used to show parrots and so on (currently in development)

(->

  # Super-cool Modern Coffee Controller Class Definition (SM3CD)!
  class ParrotsController

    allParrots: null # Stores all the parrots
    parrots:    []
    colors:     []
    new:        {} # Brand new parrot values
    filter:     {}

    # It's for pagination
    index:      {
      currentPage:  1
      itemsPerPage: 5
    }

    # Get all the colors
    getColors: ->
      @$http
      .get '/api/colors.json'
      .then (result)=>
        @colors = result.data

    # View helper
    getColorHexById: (colorId) ->
      (c.hex_value for c in @colors when c.id is parseInt(colorId))[0]

    # View helper
    getColorHexByName: (colorName) ->
      (c.hex_value for c in @colors when c.name is colorName)[0]

    # View helper
    getColorHexByParrotId: (parrotId) ->
      if !@allParrots then return ''
      (p.color_hex for p in @allParrots when p.id is parseInt(parrotId))[0]

    # View helper
    # getAvailableParents('female')  - returns all the mothers
    # getAvailableParents('male', 3) - returns all the fathers with color of parrot with id 3
    getAvailableParents: (sex = null, another_parent_id = null) ->
      toReturn = []
      return toReturn if !@allParrots
      for parrot in @allParrots
        if (!sex || parrot.sex == sex) && parrot.tribal && (!another_parent_id || parrot.color_id == (p for p in @allParrots when p.id is parseInt(another_parent_id))[0].color_id) && parrot.age >= 12
          toReturn.push(parrot)
      toReturn

    # Returns a list of filtered parrots
    indexFiltered: ->
      @$http
        .get '/api/parrots.json',
          params:
            name:        @filter.name,
            sex:         if @filter.sex && @filter.sex.length > 0 then @filter.sex, # avoid '' values
            age_min:     @filter.ageMin,
            age_max:     @filter.ageMax,
            tribals:     if @filter.tribal && @filter.tribal.length > 0 then @filter.tribal,  # avoid '' values
            color:       @filter.color,
            id:          @filter.id,
            descendants: @filter.descendants,
            ancestors:   @filter.ancestors,
            children:    @filter.children,
            parents:     @filter.parents
        .then(
          # Success
            (successResponse) =>
              @parrots     = successResponse.data
              @allParrots ?= successResponse.data
              @indexError  = null

          # Failure
          , (errorResponse) =>
              @indexError = errorResponse.data.error
        )

    # Returns all (!) the parrots and puts them to @allParrots
    indexAll: ->
      @$http
        .get '/api/parrots.json'
        .then(
          # Success
            (successResponse) =>
              @allParrots = successResponse.data
              @indexError = null

          # Failure
          , (errorResponse) =>
              @indexError = errorResponse.data.error
        )

    # Creates a new parrot
    create: ->
      @$http
        .post '/api/parrots.json',
          name:      @new.name,
          sex:       @new.sex,
          age:       parseInt(@new.age),
          tribal:    (if @new.tribal == 'true' then true else false),
          color_id:  parseInt(@new.color),
          mother_id: if @new.motherId then parseInt(@new.motherId),
          father_id: if @new.fatherId then parseInt(@new.fatherId)
        .then(
          # When success - clear modal
            (successResponse) =>
              @resetNew()
              @indexFiltered()

          # Else - show error
          , (errorResponse) =>
              @new.error = errorResponse.data.error
        )

    # CO
    switchTribal: (parrot) ->
      @$http
        .patch "/api/parrots/#{ parrot.id }.json",
          parrot:
            tribal: !parrot.tribal
        .then(
          # Success
            (successResponse) =>
              @indexError = null
              @indexAll()
              @indexFiltered()

          # Failure
          , (errorResponse) =>
              @indexError = errorResponse.data.error
      )

    # Resets the values in 'add new parrot' modal
    resetNew: ->
      @new.error    = null
      @new.name     = null
      @new.sex      = null
      @new.age      = null
      @new.tribal   = null
      @new.color    = ""
      @new.motherId = null
      @new.fatherId = null

    # CO
    resetFilter: (reloadParrots = false) ->
      @filter.name   = ""
      @filter.sex    = ""
      @filter.color  = ""
      @filter.ageMin = null
      @filter.ageMax = null
      @filter.tribal = ""
      @filter.id     = null
      @filter.descendants = null
      @filter.ancestors   = null
      @filter.children    = null
      @filter.parents     = null

      if reloadParrots
        @index.currentPage = 1
        @indexFiltered()

    # Forget to reference services with '@' should you not
    constructor: (@$http) ->

      # Initial empty values
      @resetFilter()
      @resetNew()

      # Load colors
      @getColors()

      # Load parrots
      @indexFiltered()

  angular
    .module('app')
    .controller('ParrotsController', [ '$http', ParrotsController ])

)()