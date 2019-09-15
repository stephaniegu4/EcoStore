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
    IncrementUserPoints(app, db);
    AddRestoredAnimal(app, db);
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

// Logs in user, given username and password.
function LoginUser(app, db) {
    app.post("/LoginUser", (req, res) => {
        var email = req.body.email;
        var password = req.body.password;

        if (!email || !password) {
            res.json({
                code: 500,
                msg: "Either username or password was null."
            });
        } else {
            db.collection("Users").find({ email: email }).toArray((err, result) => {
                var numMatches = result.length;
                if (numMatches === 1) {
                    var matchedPassword = result[0].password;

                    bcrypt.compare(password, matchedPassword, (err, result2) => {
                        if (result2) {
                            res.json({
                                code: 200,
                                msg: "Successfully logged in",
                                userData: result[0]
                            });
                        } else {
                            res.json({
                                code: 403,
                                msg: "Password is incorrect"
                            });
                        }
                    });
                } else {
                    res.json({
                        code: 500,
                        msg: "No user was found with that username."
                    });
                }
            });
        }
    });
}

// Increments user's points
function IncrementUserPoints(app, db){
    app.post("/IncrementUserPoints", (req, res) => {
        var id = req.body.id;

        if (!id) {
            res.json({
                code: 400,
                msg: "Given user ID was invalid."
            });
        } else {

            try {
                db.collection("Users").find({_id: new mongodb.ObjectID(id)}).toArray((err, result) => {
                    if (err){
                        res.json({
                            code: 500,
                            msg: "There was an error fetching user data."
                        });
                    } else if (result.length === 0) {
                        res.json({
                            code: 400,
                            msg: "A user with the given ID could not be found."
                        });
                    } else {
                        var userToUpdate = result[0];
                        var prevPoints = userToUpdate.points;

                        db.collection("Users")
                            .findOneAndUpdate({_id: new mongodb.ObjectID(id)}, {$set: {"points": prevPoints + 1}})
                            .then(updatedDoc => {
                                if (updatedDoc) {
                                  res.json({
                                      code: 200,
                                      msg: "Points successfully updated",
                                      updatedPoints: updatedDoc.value.points
                                  });
                                } else {
                                    res.json({
                                        code: 400,
                                        msg: "Cound not find user with given ID"
                                    });
                                }
                              })
                              .catch(err => {
                                  res.json({
                                      code: 500,
                                      msg: err.msg
                                  });
                              });
                    }
                });
            } catch (err) {
                res.json({
                    code: 500,
                    msg: "An invalid user ID was given."
                });
            }
        }
    });
}

// Adds animal to user's restored animal collection.
function AddRestoredAnimal(app, db){
    app.post("/AddRestoredAnimal", (req, res) => {
        var id = req.body.id;
        var animalID = Number(req.body.animalID);
        if (!id || !animalID) {
            res.json({
                code: 400,
                msg: "The given inputs were not valid."
            });
        } else {
            try {
                db.collection("Users").find({_id: new mongodb.ObjectID(id)}).toArray((err, result) => {
                    if (err){
                        res.json({
                            code: 500,
                            msg: "There was an error fetching user data."
                        });
                    } else if (result.length === 0) {
                        res.json({
                            code: 400,
                            msg: "A user with the given ID could not be found."
                        });
                    } else {
                        var userToUpdate = result[0];
                        var prevAnimals = userToUpdate.restoredAnimals;

                        if (prevAnimals.indexOf(animalID) != -1){
                            res.json({
                                code: 400,
                                msg: "This animal already belongs to the user."
                            });
                            return;
                        }

                        prevAnimals.push(animalID);
                        console.log(prevAnimals); 

                        db.collection("Users")
                            .findOneAndUpdate({_id: new mongodb.ObjectID(id)}, {$set: {"restoredAnimals": prevAnimals}})
                            .then(updatedDoc => {
                                if (updatedDoc) {
                                  res.json({
                                      code: 200,
                                      msg: "Animals successfully updated",
                                      updatedAnimals: prevAnimals
                                  });
                                } else {
                                    res.json({
                                        code: 400, 
                                        msg: "Could not find user with given ID"
                                    });
                                }
                              })
                              .catch(err => {
                                  res.json({
                                      code: 500,
                                      msg: err.msg
                                  });
                              });
                    }
                });
            } catch (err) {
                res.json({
                    code: 500,
                    msg: "An invalid user ID was given."
                });
            }
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
