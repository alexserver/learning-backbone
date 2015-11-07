# Test Models

Backbone = require 'backbone'

describe 'A suite', ->
  it 'contains spec with an expectation', ->
    expect(true).toBe true

describe 'Models', ->

  # Creating a default Model class for all tests
  class studentModel extends Backbone.Model
    urlRoot: '/students'
    defaults:
      name: 'Unknown'
      age: null

  it 'Should create a model', ->
    # Creating one student
    studentDemo = new studentModel
      name: 'John New'
      age: 17
    attrs = studentDemo.attributes
    expect(attrs).toEqual {name: 'John New', age: 17}
