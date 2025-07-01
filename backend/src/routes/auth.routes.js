const express = require('express');
const router = express.Router();
const authController = require("../controllers/auth.controller");
const upload = require("../middleware/upload.middleware");

router.post('/register', upload.array('photos', 3), authController.register);

module.exports = router;

