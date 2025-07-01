const { Sequelize } = require('sequelize');
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../../.env') });

// ✅ Initialize Sequelize with .env credentials
const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: 'mysql',
    logging: false,
  }
);

// ✅ Create the db object to export
const db = {};

// ✅ Add Sequelize and sequelize instance
db.Sequelize = Sequelize;
db.sequelize = sequelize;

// ✅ Import and add your models here
db.User = require('./user.model')(sequelize, Sequelize); // Add other models similarly

module.exports = db;
