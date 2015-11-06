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

app.use(express.static(path.join(__dirname, '/public')));

// For parsing request bodies in POST
app.use(parser.json());
app.use(parser.urlencoded({ extended: true }));

// Show students
app.get('/students', function(req, res) {
  res.json(data.student);
});

// View student
app.get('/students/:id', function(req, res) {
  var student = query.where(data.student, { id: parseInt(req.params.id) } );
  if (student.length > 0) {
    res.json(student[0]);
  } else {
    res.status(500).end();
  }
});

// Create student
app.post('/students', function(req, res) {
  //no validation since we're learning backbone, not API design, YOLO.
  var student = req.body;
  student.id = data.student.length + 1;
  data.student.push(student);
  res.status(201).json(student);
});

// Update student
app.put('/students/:id', function(req, res) {
  //no validation since we're learning backbone, not API design, YOLO.
  var student = query.where(data.student, {id: parseInt(req.params.id)});
  student = _.extend(student, req.body);
  res.json({});
});

app.delete('/students/:id', function(req, res) {
  //no validation. YOLO
  var student_id = _.findIndex(data.student, {id: parseInt(req.params.id)});
  if (student_id) {
    _.pullAt(data.student, student_id);
    res.json({});
  } else {
    res.status(500);
  }
});

// Show subjects
app.get('/subjects', function(req, res) {
  res.json(data.subject);
});

// View subject
app.get('/subjects/:id', function(req, res) {
  var subject = query.where(data.subject, { id: parseInt(req.params.id) } );
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