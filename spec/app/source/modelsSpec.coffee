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
    # Creating one student
    student = new studentModel
      id: 4
      name: 'John New'
      age: 17
    student.fetch
      success: sinon.spy()
    expect(jQuery.ajax.calledWithMatch { url: '/students/4' }).toBe true

  it 'Should save a model', ->
    # Creating one student
    student = new studentModel
      name: 'John New'
      age: 20
      sex: 'M'
    student.save
      success: sinon.spy()
    expect jQuery.ajax.calledWithMatch 
      url: '/students'
    .toBe true
    expect jQuery.ajax.getCall(0).args[0].data
    .toEqual JSON.stringify
      name: 'John New'
      age: 20
      sex: 'M'

