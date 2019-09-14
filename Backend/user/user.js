// Creates necessary user endpoints.
function CreateUserMethods(app, db){
    GetAllUsers(app, db);
    LoginUser(app, db);
    CheckEmailExists(app, db);
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


module.exports = {
    CreateUserMethods: CreateUserMethods
};
