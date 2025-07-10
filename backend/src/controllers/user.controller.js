exports.getProfile = (req, res) => {
  const user = req.user; // this was added in verifyToken
  res.status(200).json({
    message: "Protected profile accessed",
    user: user,
  });
};
