# app

# Version 0.0.1, this just prints to console
# Why printing in console ? because is time cheap. (faster)
# TODO > figure out how to test this thing. (jasmine ? chaijs ? sinon ?)

class studentModel extends Backbone.Model
  url: '/students'
  defaults:
    name: "Unknown"
    age: null

class studentCollection extends Backbone.Collection
  url: '/students'
  model: studentModel

# Creating a collection
students = new studentCollection

students.on 'sync', (model, resp) ->
  console.log 'Data is ', resp

# Fetch existing students
console.log 'Fetching Students from API'
students.fetch()

# Creating one student
studentOne = new studentModel
  name: "John"
  age: 17
# Adding a sync listener
studentOne.on 'sync', (model, resp) ->
  console.log 'response ', resp

# Inserting that student
studentOne.save()

# Updating that student
studentOne.set 'age', 18
studentOne.save()

# Updating the collection
students.fetch()


