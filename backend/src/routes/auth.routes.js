const express = require('express');
const router = express.Router();
const authController = require("../controllers/auth.controller");
const upload = require("../middleware/upload.middleware");

router.post('/register', upload.any(), authController.register);
router.post('/login', authController.login);

module.exports = router;

