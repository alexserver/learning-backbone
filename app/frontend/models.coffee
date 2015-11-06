# Models testing

class studentModel extends Backbone.Model
  url: '/students'
  defaults:
    name: "Unknown"
    age: null

modelCreation = ->
  # Creating one student
  studentDemo = new studentModel
    name: "John New"
    age: 17
  # Sync listener, for when a request has been done to API
  studentDemo.on 'sync', (model, resp) ->
    console.log 'Model has been synced ', resp
  # Change listener, for when an attribute has changed
  studentDemo.on 'change', (model) ->
    console.log 'Model changed data ', model
  # Inserting that student
  console.log 'Save model', studentDemo.attributes
  studentDemo.save()

modelUpdating = ->
  # Creating one student
  studentDemo = new studentModel
    id: 4
  # Sync listener, for when a request has been done to API
  studentDemo.on 'sync', (model, resp) ->
    console.log 'Model has been synced ', resp
  # Fetching data
  studentDemo.fetch
    success: (data)->
      console.log data
  # Updating that student
  # console.log 'Updating student and save again'
  # studentDemo.set
  #   name: 'George from the jungle'
  # studentDemo.save()

## MAIN processes
modelCreation()
modelUpdating()