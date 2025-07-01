const db = require("../models");
const bcrypt = require("bcryptjs");
const User = db.User;

exports.register = async (req, res) => {
  try {
    const {
      firstName, middleName, lastName,
      email, password, role, gender, industry,
      complexion, experience, description,
      contact, age
    } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);
    const photos = req.files.map(file => file.filename);

    const user = await User.create({
      firstName, middleName, lastName,
      email, password: hashedPassword, role, gender,
      industry, complexion, experience, description,
      contact, age, photos
    });

    res.status(200).json({ message: "User registered successfully", user });
  } catch (err) {
    res.status(500).json({ message: err.message || "Internal Server Error" });
  }
};
