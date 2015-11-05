# Reference

## Events

### On
```
var object = {};
_.extend(object, Backbone.Events);

var en = function(name){
    console.log('hello '+name);
}

var es = function(name){
    console.log('hola '+name);
}

object.on('hello', en);
object.on('hello', es);
console.log('both events');
object.trigger('hello', 'Alex');
```

### Off
```
var object = {};
_.extend(object, Backbone.Events);

var en = function(name){
    console.log('hello '+name);
}

var es = function(name){
    console.log('hola '+name);
}

object.on('hello', en);
object.on('hello', es);
console.log('both events');
object.trigger('hello', 'Alex');

object.off('hello', en);
console.log('off en event');
object.trigger('hello', 'Alex');

object.on('hello', en);
object.off('hello');
console.log('off all events');
object.trigger('hello', 'Alex');
```

### once
```
var object = {};
_.extend(object, Backbone.Events);

var en = function(name){
    console.log('hello '+name);
}

var es = function(name){
    console.log('hola '+name);
}

object.once('hello', en);
object.on('hello', es);
console.log('both events');
object.trigger('hello', 'Alex');
console.log('only es event');
object.trigger('hello', 'Alex');
```

### listenTo
```
var book = {}, shelve = {};
_.extend(book, Backbone.Events);
_.extend(shelve, Backbone.Events);

var add = function(title) {
    console.log('new book '+title+' added to shelve');
}

var newbook = function(title) {
    console.log('new book '+title+' printed');
}

book.on('newbook', newbook);
shelve.listenTo(book, 'newbook', add);

book.trigger('newbook', 'LOTR');
```

### stopListening
```
var book = {}, shelve = {};
_.extend(book, Backbone.Events);
_.extend(shelve, Backbone.Events);

var add = function(title) {
    console.log('new book '+title+' added to shelve');
}

var newbook = function(title) {
    console.log('new book '+title+' printed');
}

book.on('newbook', newbook);
shelve.listenTo(book, 'newbook', add);
book.trigger('newbook', 'LOTR');

shelve.stopListening(book);
book.trigger('newbook', 'LOTR');
```

### Built-in Events
- "add" (model, collection, options) — when a model is added to a collection.
- "remove" (model, collection, options) — when a model is removed from a collection.
- "reset" (collection, options) — when the collection's entire contents have been replaced.
- "sort" (collection, options) — when the collection has been re-sorted.
- "change" (model, options) — when a model's attributes have changed.
- "change:[attribute]" (model, value, options) — when a specific attribute has been updated.
- "destroy" (model, collection, options) — when a model is destroyed.
- "sync" (model, resp, options) — triggers whenever a model has been successfully synced to the server.
- "error" (model, collection) — when a model's validation fails, or a save call fails on the server.
- "route:[name]" (router) — when one of a router's routes has matched.
- "all" — this special event fires for any triggered event, passing the event name as the first argument.

## Model

```
# Extending simple model
Sidebar = Backbone.Model.extend {}
console.log Sidebar
```


### Extend
```
# extending a simple model
SidebarModel = Backbone.Model.extend {
    initialize: ->
        console.log 'initialized'
}

sidebar = new SidebarModel
```

```
# extending a model a la coffeescript
class SidebarModel extends Backbone.Model
    initialize: ->
        console.log 'initialized'

sidebar = new SidebarModel
```

Calling super
```
# extending a simple model
SidebarModel = Backbone.Model.extend {
    initialize: ->
        console.log 'initialized'
  set: (attributes, options) ->
        console.log 'calling set'
        Backbone.Model.prototype.set.apply this, arguments
}

sidebar = new SidebarModel

sidebar.set 'color', 'blue'
```

### Initialize (constructor)
```
# extending a simple model
SidebarModel = Backbone.Model.extend {
    initialize: (options)->
        console.log "options #{JSON.stringify(options)}"
}

# passing an object to the constructor
sidebar = new SidebarModel {
    name: 'John'
    age: 33    
}
```

### Get
```
# extending a simple model
PersonModel = Backbone.Model.extend {
    initialize: (options)->
        console.log "options #{JSON.stringify(options)}"
}

person = new PersonModel {
    name: 'John'
    age: 33
}

person_name = person.get 'name'
person_age = person.get 'age'

console.log "my name is #{person_name} and I'm #{person_age} years old"
```

### Set
```
# extending a simple model
PersonModel = Backbone.Model.extend {
    initialize: (options)->
        console.log "options #{JSON.stringify(options)}"
}

person = new PersonModel {
    name: 'John'
    age: 33
}

print_age = (p) ->
    age = p.get 'age'
    console.log "I'm #{age} years old"

# print John age
print_age person
# change age to 34
person.set 'age', 34
# print it again
print_age person
```

Set also fires change event.
```
# extending a simple model
class PersonModel extends Backbone.Model

person = new PersonModel {
    name: 'John'
    age: 33
}

person.on 'change', ->
    console.log "something changed"

# change age to 34
person.set 'age', 34
```

Set doesn't fire the event when `{silent: true}` is passed as an option
```
class PersonModel extends Backbone.Model

person = new PersonModel {
    name: 'John'
    age: 33
}

person.on 'change:age', (model, age) ->
    console.log "new age #{age}"

# changing age with event fired
person.set {
        age: 34
    }
# changing age without event fired
person.set {
        age: 35
    }, {
      silent: true
    }
```

### Escape
```
class PersonModel extends Backbone.Model

person = new PersonModel
    label: 'console.log(\'xss\')'

console.log person.get ('label')
```

### Has
it returns true if the attribute is set to non-null or non-undefined value
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33

console.log 'it has age' if person.has 'age'
console.log 'it doesn\' have sex' unless person.has 'sex'
```

### Unset
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33

has_age = (p) ->
    console.log if person.has('age') then 'person has age' else 'person has not age'
    
has_age person
person.unset 'age'
has_age person
```

### Clear
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Radisson st 45'

has_attr = (p, attr) ->
    console.log if person.has(attr) then "person has #{attr}" else "person has not #{attr}"
        
# getting the list of attributes cache
attributes = for k, val of person.attributes
    k # it returns k on every iteration
    
# print has_attr for every attribute
has_attr person, k for k in attributes
# clear attributes (we have to call the function with parenthesis)
person.clear()
# print again has_attr to validate if attributes are still there
has_attr person, k for k in attributes
```

### id
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'
    id: 1
    
person2 = new PersonModel
    name: 'Michael'
    age: 35
    sex: 'M'
    address: 'Hilly Blv No 22'
    id: 2

console.log "person 1 id: #{person.id}"
console.log "person 2 id: #{person2.id}"
```

### idAttribute
```
class PersonModel extends Backbone.Model
    idAttribute: "_id"

person = new PersonModel
    _id: 1
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

person2 = new PersonModel
    _id: 2
    name: 'Michael'
    age: 35
    sex: 'M'
    address: 'Hilly Blv No 22'


console.log "person id is #{person.id}"
console.log "person 2 id is #{person2.id}"
```

### cid
Automatic id generated by backbone
```
class PersonModel extends Backbone.Model
    idAttribute: "_id"

person = new PersonModel
    _id: 1
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

person2 = new PersonModel
    _id: 2
    name: 'Michael'
    age: 35
    sex: 'M'
    address: 'Hilly Blv No 22'


console.log "person id is #{person.id}"
console.log "person 2 id is #{person2.id}"
console.log "person cid is #{person.cid}"
console.log "person 2 cid is #{person2.cid}"
```

### attributes
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'


# walking through attributes
console.log "#{key} value is #{val}" for key, val of person.attributes
```

### changed
It has a hash of the recently changed objects
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'


# change something
person.set 'age', 34
# print changed
console.log person.changed
# change something else
person.set {address: 'Hollywood', name: 'John Malkovich'}
# print changed again
console.log person.changed
```

### defaults
when defining a model, you can specify default values with this hash
```
class PersonModel extends Backbone.Model
    defaults:
        name: "no name"
        age: 18
        sex: null
        address: "unknown"

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

dummy = new PersonModel

# a function to print attributes values
print_attr = (p) ->
    console.log "#{key} value is #{val}" for key, val of p.attributes

# print person attributes
print_attr person
# print dummy attributes
print_attr dummy
```

### toJSON
Exports the data into a JSON object (Note, this is not a string, but a javascript object)
```
class PersonModel extends Backbone.Model

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

# a function to print attributes values
print_hash = (hash) ->
    console.log "#{key} value is #{val}" for key, val of hash

# print person attributes
print_hash person.attributes
# print person.toJSON hash
print_hash person.toJSON()
```

### fetch
Fires an AJAX request to the server.
The model must have `urlRoot` configured in order to know where to fetch data from.
The model will expect the response to deliver data within the body root and not within metadata.

```
class PersonModel extends Backbone.Model
    urlRoot: '/echo/json'

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

# a function to print attributes values
print_hash = (hash) ->
    console.log "#{key} value is #{val}" for key, val of hash

person.fetch
  success: (data) ->
        console.log 'hey, there was data', data
    error: (err) ->
        console.log 'error: ', err
```

### save
It saves data to the server
It does a POST if the model isNew
It does a PUT if the model already exists
```
class PersonModel extends Backbone.Model
    urlRoot: '/echo/json'

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

# a function to print attributes values
print_hash = (hash) ->
    console.log "#{key} value is #{val}" for key, val of hash

# changing some data
person.set 'age', 34

# save changes
person.save()

# save partial changes
person.save {
        name: 'John Snow'
        age: 35
    },
    {
        patch: true
    }
```

Alert on sync when the model changes
```
class PersonModel extends Backbone.Model
    urlRoot: '/echo/json'

person = new PersonModel
    name: 'John'
    age: 33
    sex: 'M'
    address: 'Central Park No 34'

# a function to print attributes values
print_hash = (hash) ->
    console.log "#{key} value is #{val}" for key, val of hash

# using .on
person.on 'sync', (model, options) ->
    console.log "model ", model
    console.log "options ", options
    
# using model sync to listen requests to the server
person.sync = (method, model) ->
    console.log "#{method} : #{JSON.stringify(model)}"

# changing some data
person.set 'age', 34

# save changes
person.save()
```

