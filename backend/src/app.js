const express = require("express");
const app = express();
const authRoutes = require("./auth.routes");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/uploads", express.static("uploads"));
app.use("/api", authRoutes);

module.exports = app;
