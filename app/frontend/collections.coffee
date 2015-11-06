# Collections testing
# At this point I'm doing sort of BDD describes, next step, do real BDD.

collectionCreation = ->
  # class studentModel extends Backbone.Model
  #   url: '/students'
  #   defaults:
  #     name: "Unknown"
  #     age: null

  class studentCollection extends Backbone.Collection
    url: '/students'

  # Creating a collection
  students = new studentCollection
  console.log 'Collection created ', students

collectionFetching = ->
  class studentCollection extends Backbone.Collection
    url: '/students'

  # Creating a collection
  students = new studentCollection  

  # Fetch existing students
  console.log 'Fetching Students Collection from API'
  students.fetch {
    success: (model, data)->
      console.log 'Students Collection: ', data
  }

collectionCreation()
collectionFetching()
