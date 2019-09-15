var bcrypt = require("bcryptjs");
const mongodb = require("mongodb");

// Creates necessary user endpoints.
function CreateUserMethods(app, db){
    GetAllUsers(app, db);
    LoginUser(app, db);
    CheckEmailExists(app, db);
    IncrementUserPoints(app, db);
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
function GetUserPassword(db, email) {
    db.collection("Users").findOne({email: email}).then((result) => {
        return {
            hi: "hi"
        };
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


module.exports = {
    CreateUserMethods: CreateUserMethods
};
