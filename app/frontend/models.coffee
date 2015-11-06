# Models testing
# At this point I'm doing sort of BDD describes, next step, do real BDD.

class studentModel extends Backbone.Model
  urlRoot: '/students'
  defaults:
    name: "Unknown"
    age: null

newId = null

modelCreation = ->
  # Creating one student
  studentDemo = new studentModel
    name: "John New"
    age: 17
  # Sync listener, for when a request has been done to API
  studentDemo.on 'sync', (model, data) ->
    console.log 'Model has been synced for insertion', data
  # Inserting that student
  studentDemo.save {},
    success: (model, data) ->
      console.log "Model has been saved ", data
      newId = data.id
      

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
    console.log "Model has been sync for fetching/updating", @attributes
  # Fetching data
  studentDemo.fetch
    success: (model, data)->
      console.log "Model id:#{studentDemo.id} fetched for updating: ", data
      # Updating the student. // Callback Hell !!
      studentDemo.set 'name', 'George from the Jungle'
      studentDemo.save()

modelDestroying = ->
  # Creating one student
  studentDemo = new studentModel
    id: 4
  # Adding listener to sync
  studentDemo.on 'sync', (model, data) ->
    console.log "Model has been synced for destroying", data
  # Deleting the model previously created
  studentDemo.destroy()

## MAIN processes
modelCreation()
modelFetchingExisting()
modelUpdating()
modelDestroying()