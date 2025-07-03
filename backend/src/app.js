const express = require("express");
const app = express();
const authRoutes = require('./routes/auth.routes');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve uploaded images
app.use("/uploads", express.static("uploads"));

// Make route like: /api/auth/register
app.use("/api/auth", authRoutes);

module.exports = app;
