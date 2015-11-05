# Models testing

class studentModel extends Backbone.Model
  url: '/students'
  defaults:
    name: "Unknown"
    age: null

# Creating one student
studentDemo = new studentModel
  name: "John"
  age: 17

# Adding a sync listener
studentDemo.on 'sync', (model, resp) ->
  console.log 'Model has been synced ', resp

studentDemo.on 'change', (model) ->
  console.log 'Model changed data ', model

# Inserting that student
console.log 'Save model', studentDemo.attributes
studentDemo.save()

# Updating that student
console.log 'Updating student and save again'
studentDemo.set 'age', 18
studentDemo.save()

# Instantiating an existing user
studentOne = new studentModel
  id: 1

# Adding a sync listener
studentOne.on 'sync', (model, resp) ->
  console.log 'Model has been synced ', resp

# Fetching its data
console.log 'Fetching data from studentOne'
studentOne.fetch()

