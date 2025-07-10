const express = require("express");
const app = express();
const authRoutes = require('./routes/auth.routes');
const userRoutes = require("./routes/user.routes");



app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve uploaded images
app.use("/uploads", express.static("uploads"));

// Make route like: /api/auth/register
app.use("/api/auth", authRoutes);
app.use("/api/users", userRoutes);

module.exports = app;
