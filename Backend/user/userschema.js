const mongoose = require("mongoose");

let UserSchema = new mongoose.Schema({
  name:{
    type: String,
    required: true
  },
  password:{
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  image: {
    type: String,
    required: true
  },
  points: {
    type: Number,
    required: true
  },
  restoredAnimals:[
    {
      type: Number,
      required: true
    }
  ]
});
module.exports = mongoose.model("Users", UserSchema);
