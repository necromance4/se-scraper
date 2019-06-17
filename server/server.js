var express = require('express');
var run = require("../run.js");
var app = express();

app.get('/', function (req, res) {
    run.run( function(cb) {
        res.send(cb);    
    });
});

app.listen(8000, function () {
    console.log('Express app listening on port 8000!');
});
