const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth.middleware");

// ✅ Protected test route
router.get("/profile", verifyToken, (req, res) => {
  res.json({
    message: "This is protected data",
    user: req.user,
  });
});

module.exports = router;
