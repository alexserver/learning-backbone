# Test Models
sinon = require 'sinon'

describe 'Backbone Models', ->

  # Creating a default Model class for all tests
  class studentModel extends Backbone.Model
    urlRoot: '/students'
    defaults:
      name: 'Unknown'
      age: null
      sex: null

  beforeEach ->
    sinon.stub(jQuery, 'ajax')
    # Creating one student
    @student = new studentModel
      name: 'John New'
      age: 17
      sex: 'M'

  afterEach ->
    jQuery.ajax.restore()

  it 'Should create a model', ->
    # Creating one student
    student = new studentModel
      name: 'John New'
      age: 17
    attrs = student.attributes
    expect(attrs).toEqual {name: 'John New', age: 17, sex: null}

  it 'Should fetch a model', () ->
    # Setting student id for fetching
    @student.set 'id', 4
    @student.fetch
      success: sinon.spy()
    expect(jQuery.ajax.calledWithMatch { url: '/students/4' }).toBe true

  it 'Should save a model', ->
    # Saving student model
    @student.save
      success: sinon.spy()
    expect jQuery.ajax.calledWithMatch 
      url: '/students'
    .toBe true
    expect jQuery.ajax.getCall(0).args[0].data
    .toEqual JSON.stringify
      name: 'John New'
      age: 17
      sex: 'M'

  it 'Should react to changes', (done)->
    @student.on 'change', (model) ->
      expect(model.previousAttributes()).not.toEqual model.attributes
      done()
    @student.set 'name', 'Marty McFly'

  it 'Should react to a specific attribute change', ->
    name_callback = sinon.spy()
    age_callback = sinon.spy()
    @student.on 'change:name', name_callback
    @student.on 'change:age', age_callback
    @student.set 'name', 'David Gilmour'
    expect(name_callback.called).toBe true
    expect(age_callback.called).toBe false
    # spy.args[0] references the arguments for the first call. 
    # So [0][0] references to the first call, first argumet: model
    expect(name_callback.args[0][0].get 'name').toEqual 'David Gilmour'

  it 'Should save an existing model', ->
    @student.set 'id', 4
    @student.set 'name', 'Ace Ventura'
    @student.save
      success: sinon.spy()
    expect jQuery.ajax.calledWithMatch
      url: '/students/4'
    .toBe true
    expect jQuery.ajax.getCall(0).args[0].data
    .toEqual JSON.stringify
      name: 'Ace Ventura'
      age: 17
      sex: 'M'
      id: 4

