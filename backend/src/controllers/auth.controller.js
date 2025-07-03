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

    // Check if user already exists
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ message: "Email already registered" });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Handle photos
    const photos = req.files?.map(file => file.filename) || [];

    // Save to DB
    const user = await User.create({
      firstName,
      middleName,
      lastName,
      email,
      password: hashedPassword,
      role,
      gender,
      industry,
      complexion,
      experience,
      description,
      contact,
      age,
      photos, // Ensure your User model supports ARRAY or TEXT (stringified array)
    });

    // Send response
    res.status(201).json({
      message: "User registered successfully",
      user: {
        id: user.id,
        firstName: user.firstName,
        email: user.email,
        role: user.role,
        photos: user.photos,
      },
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err.message || "Internal Server Error" });
  }
};
