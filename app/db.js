/*
  DB Mock
  This populates itself from a JSON file, and makes changes in memory only.
 */

var db = exports;
var uuid = require('uuid');
var _ = require('lodash');
var data = require('./data.json');

var getCollection = function(collectionName) {
  if (!data.hasOwnProperty(collectionName)) {
    data[collectionName] = [];
  }
  return data[collectionName];
}

db.getAll = function(collection) {
  return getCollection(collection).slice();
};

db.getOne = function(collection, attrs) {
  var coll = getCollection(collection);
  return _.find(coll, attrs);
};

db.save = function(collection, doc) {
  var coll = getCollection(collection);
  var existingDoc;
  if (doc.id) {
    existingDoc = _.find(coll, {id: doc.id});
    existingDoc = _.extend(existingDoc, doc);
  } else {
    doc.id = uuid.v4();
    coll.push(doc);
  }
  console.log('=== Saving File ===', doc);
  console.log('=== Collection Size ===', coll.length);
  return doc;
};

db.del = function(collection, doc) {
  var coll = getCollection(collection);
  var docIndex = _.findIndex(coll, {id: doc.id});
  if (docIndex >= 0) {
    _.pullAt(coll, docIndex);
  }
  console.log('=== Destroying File ===', doc);
  console.log('=== Collection Size ===', coll.length);
};

db.flush = function(collection) {
  var coll = getCollection(collection);
  //empty array.
  coll.length = 0; // The right way -> https://davidwalsh.name/empty-array
};