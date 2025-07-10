const express = require("express");
const app = require('./src/app');
const db = require("./src/models");
const dotenv = require("dotenv");
const path = require("path");

dotenv.config({ path: path.resolve(__dirname, ".env") });

const PORT = process.env.PORT || 8080;

// Sync database and start server
db.sequelize.sync({ alter: true }).then(() => {
  console.log("Database synced");
  app.listen(PORT, '10.246.57.205', () => {
    console.log(`Server running on http://10.246.57.205:${PORT}`);
  });
});

process.on("uncaughtException", (err) => {
  console.error("Uncaught Exception:", err);
});
