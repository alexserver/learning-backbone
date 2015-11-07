# Collections testing
# At this point I'm doing sort of BDD describes, next step, do real BDD.

class studentModel extends Backbone.Model
  defaults:
    name: 'Unknown'
    age: null
    sex: ''

class studentCollection extends Backbone.Collection
  url: '/students'
  model: studentModel

collectionCreation = ->
  # Creating a collection
  students = new studentCollection
  console.log 'Collection created ', students

collectionCreationWithModels = ->
  students = new studentCollection [ 
      {name: 'John'}
      {name: 'Steve'}
      {name: 'Laura'}
    ]
  console.log 'Collection created with models ', students.toJSON()

collectionFetching = ->
  # Creating a collection
  students = new studentCollection  
  # Fetch existing students
  students.fetch
    success: (coll, data) ->
      console.log 'Collection Student - fetched ', data

collectionUnderscore = ->
  students = new studentCollection
  # Fetch students
  students.fetch()
  students.on 'sync', (coll, data) ->
    console.log 'Collection Student - Running an each method'
    coll.each (model) ->
      console.log 'Model Student: ', model.attributes
    console.log 'Collection Student - Running a map method'
    studentNames = coll.map (model) ->
      model.get 'name'
    console.log "Model Student, Name: #{name}" for name in studentNames

collectionAdd = ->
  students = new studentCollection
  students.on 'add', (model, coll) ->
    console.log "Collection Student - Model Added: #{model.get('name')}, Coll Size: #{coll.length}"
  students.add [
      {name: 'Jim Carrey'}
      {name: 'Jimmy Fallon'}
      {name: 'Will Ferrell'}
    ]

collectionRemove = ->
  students = new studentCollection
  students.add [
      {name: 'Jim Carrey'}
      {name: 'Jimmy Fallon'}
      {name: 'Will Ferrell'}
    ]
  students.on 'remove', (model, coll) ->
    console.log "Collection Student - Model Removed: #{model.get 'name'}, Coll Size: #{coll.length}"
  jim = students.find (student) ->
    (student.get 'name') == 'Jim Carrey'
  console.log 'Collection - Jim was found! ', jim
  students.remove [jim]

collectionReset = ->
  students = new studentCollection
  students.add [
    {name: 'Jim'}
    {name: 'Alonso'}
    {name: 'Patricia'}
  ]
  console.log 'Collection Student - Model Added', students.toJSON()
  students.reset()
  console.log 'Collection Student - Collection Reset', students.toJSON()

collectionUpdate = ->
  students = new studentCollection
  students.add [
    {name: 'Jim'}
    {name: 'Alonso'}
    {name: 'Patricia'}
  ]
  console.log 'Collection Student - Model Added', students.toJSON()
  students.update [
      {name: 'Jim'}
      {name: 'Lawrence'}
      {name: 'Sofia'}
    ]
  console.log 'Collection Student - Model Updated', students.toJSON()

collectionPluck = ->
  students = new studentCollection
  students.fetch
    success: (coll, data) ->
      console.log 'Collection Student - Fetch successful: ', data
      console.log "Collection Student - Model Name: #{name}" for name in coll.pluck 'name'

collectionWhere = ->
  students = new studentCollection
  students.add [
    {name: 'Jim', sex: 'M', age: 34}
    {name: 'Alonso', sex: 'M', age: 28}
    {name: 'Patricia', sex: 'F', age: 24}
  ]
  maleStudents = students.where {sex: 'M'}
  console.log "Collection Student - Select only male students: #{s.get 'name'}, #{s.get 'age'}" for s in maleStudents


collectionCreation()
collectionCreationWithModels()
collectionFetching()
collectionUnderscore()
collectionAdd()
collectionRemove()
collectionReset()
collectionUpdate()
collectionPluck()
collectionWhere()