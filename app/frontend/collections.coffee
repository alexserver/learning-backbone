# Collections testing

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
