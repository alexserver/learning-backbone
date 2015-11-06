# Models testing
# At this point I'm doing sort of BDD describes, next step, do real BDD.

class studentModel extends Backbone.Model
  urlRoot: '/students'
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

modelFetchingExisting = ->
  # Creating one student with existing id
  studentDemo = new studentModel
    id: 4
  studentDemo.fetch
    success: (model, data) ->
      console.log "Model id:#{studentDemo.id} fetched: ", data

modelUpdating = ->
  # Creating one student
  studentDemo = new studentModel
    id: 4
  # Adding listener to sync
  studentDemo.on 'sync', (model)->
    console.log "Model has been sync", @attributes
  # Fetching data
  studentDemo.fetch
    success: (model, data)->
      console.log "Model id:#{studentDemo.id} fetched for updating: ", data
      # Updating the student. // Callback Hell !!
      studentDemo.set 'name', 'George from the Jungle'
      studentDemo.save()

## MAIN processes
modelCreation()
modelFetchingExisting()
modelUpdating()