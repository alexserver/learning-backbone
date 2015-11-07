/*
  API
  It mimics a RESTful API but with fake data.

  TODO: use at least sqlite
*/

var express = require('express');
var query = require('simple-object-query');
var app = express();
var data = require('./data.json');
var _ = require('lodash');
var parser = require('body-parser');
var server;
var path = require('path');
var db = require('./db');

app.use(express.static(path.join(__dirname, '/public')));

// For parsing request bodies in POST
app.use(parser.json());
app.use(parser.urlencoded({ extended: true }));

// Show students
app.get('/students', function(req, res) {
  var docs = db.getAll('student');
  res.json(docs);
});

// View student
app.get('/students/:id', function(req, res) {
  var doc = db.getOne('student', {id: req.params.id});
  res.json(doc);
});

// Create student
app.post('/students', function(req, res) {
  //no validation since we're learning backbone, not API design, YOLO.
  var doc = req.body;
  doc = db.save('student', doc); //wth ??
  res.status(201).json(doc);
});

// Update student
app.put('/students/:id', function(req, res) {
  //no validation since we're learning backbone, not API design, YOLO.
  db.save('student', req.body);
  res.json({});
});

// Destroy student
app.delete('/students/:id', function(req, res) {
  //no validation. YOLO
  db.del('student', {id: req.params.id});
  res.json({});
});

// Show subjects
app.get('/subjects', function(req, res) {
  var docs = db.getAll('subjects');
  res.json(docs);
});

// View subject
app.get('/subjects/:id', function(req, res) {
  var subject = query.where(data.subject, {id: parseInt(req.params.id)});
  if (subject.length > 0) {
    res.json(subject[0]);
  } else {
    res.status(500).end();
  }
});

server = app.listen(3000, function() {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});