function CreateUserMethods(app, db){
    app.get("/Users", (req, res, next) => {
        db.collection("Users").find().toArray((err, results) => {
            if (err) {
                res.sendStatus(500);
            } else {
                res.json(results);
            }
        });
    });
}


module.exports = {
    CreateUserMethods: CreateUserMethods
};
