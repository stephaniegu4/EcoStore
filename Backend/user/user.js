var bcrypt = require("bcryptjs");
const mongodb = require("mongodb");

let Users = require("./userschema.js");
// Creates necessary user endpoints.
function CreateUserMethods(app, db){
    GetAllUsers(app, db);
    LoginUser(app, db);
    CheckEmailExists(app, db);
    DeleteUser(app, db);
    AddUser(app, db);
}

// Returns all Users currently in database.
function GetAllUsers(app, db){
    app.get("/GetAllUsers", (req, res, next) => {
        db.collection("Users").find().toArray((err, results) => {
            if (err) {
                res.sendStatus(500);
            } else {
                res.json(results);
            }
        });
    });
}

// Checks if email already exists in database.
function CheckEmailExists(app, db){
    app.post("/CheckEmailExists", (req, res) => {
        var email = req.body.email;

        if (!email){
            res.sendStatus(500);
        } else {
            db.collection("Users").find({email: email}).toArray((err, results) => {
                if (err) {
                    res.sendStatus(500);
                }else{
                    res.json({
                        exists: !(results.length === 0)
                    });
                }
            });
        }
    });
}

// Gets hashed password from database, given user's id.
function GetUserPassword(db, id) {
    db.collection("Users").findOne({_id: id}).then((result) => {

    });
}

// Logs in user, given username and password.
function LoginUser(app, db) {
    app.post("/LoginUser", (req, res) => {
        var username = req.body.username;
        var password = req.body.password;

        if (!username || !password) {
            res.json({
                code: 500,
                msg: "Either username or password was null."
            });
        } else {
            // Get password from db.
        }
    });
}

// Creates a new user
function AddUser(app, db){
  app.post("/AddUser", (req, res) => {
    var newUser = new Users(req.body);
    newUser.validate(function (err){
      if (err) {
        res.json({
          code: 500,
          msg: "User entry was invalid"
        });
      } else {
        bcrypt.genSalt(10, function(err, salt) {
          bcrypt.hash(req.body.password, salt, (err, hash) => {
            db.collection("Users").insertOne({
              username: req.body.username,
              password: hash,
              email: req.body.email,
              image: req.body.image,
              points: req.body.points,
              restoredAnimals: req.body.restoredAnimals
            }, (err, results) => {
              if (err){
                res.json({
                  code: 500,
                  message: "Failed to create user"
                });
              } else{
                res.sendStatus(200);
              }
            });
          });
        });
      }
    });
    });
  }

// Deletes user based on id
function DeleteUser(app, db) {
  app.post("/DeleteUser", (req, res) => {
    if( "id" in req.body) {
      var id = req.body.id;
      db.collection("Users").find({_id: id}).toArray((err, results) => {
        if (err) {
          res.sendStatus(500);
        } else if (results.length == 0){
          db.collection("Users").remove({_id: new mongodb.ObjectId(id)});
          res.json([id]);
        } else {
          res.json({
            code: 500,
            msg: "Id does not exist"
          });
        }
      });
    } else {
      res.json({
        code: 500,
        msg: "Id was null"
      });
    }
  });
}


module.exports = {
    CreateUserMethods: CreateUserMethods
};
