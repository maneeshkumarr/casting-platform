module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define("User", {
    firstName: { type: DataTypes.STRING, allowNull: false },
    middleName: { type: DataTypes.STRING },
    lastName: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING, allowNull: false, unique: true },
    password: { type: DataTypes.STRING, allowNull: false },
    role: { type: DataTypes.STRING },
    gender: { type: DataTypes.STRING },
    age: { type: DataTypes.INTEGER },
    industry: { type: DataTypes.STRING },
    complexion: { type: DataTypes.STRING },
    experience: { type: DataTypes.STRING },
    description: { type: DataTypes.TEXT },
    contact: { type: DataTypes.STRING },
    photos: { type: DataTypes.JSON }, // store filenames as array
  });

  return User;
};
