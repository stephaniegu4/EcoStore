// Dependencies.
var express = require("express");
var app = express();
var bodyParser = require('body-parser');
var bcrypt = require("bcryptjs");
app.use(bodyParser());
const mongodb = require("mongodb");
const MongoClient = require("mongodb").MongoClient;
const mongoose = require("mongoose");
let config = require("./config/config.json");

var user = require('./user/user.js');

// Starts application.
function AppStart() {
    app.use(bodyParser.urlencoded({ // Middleware
        extended: true
    }));
    app.use(bodyParser.json());

    // Connect to MongoDB.
    MongoClient.connect(
        config.connString,
        { useNewUrlParser: true },
        (err, client) => {
            if (err) return console.log(err);

            // Access ShelterData database.
            var db = client.db("EcoStore");

            // Sample GET method (make into sep. function later)
            user.CreateUserMethods(app, db);

            const port = process.env.PORT || 8000;
            // Start server.
            app.listen(port, () => {
                console.log("Server started on localhost:" + port + ".");
            })
        });
}

AppStart();