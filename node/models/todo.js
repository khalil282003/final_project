const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('./index');
const User = require('./user');

const Todo = sequelize.define('Todo', {
  title: {
    type: DataTypes.STRING,
    allowNull: false
  },
  completed: {
    type: DataTypes.BOOLEAN,
    defaultValue: false
  }
});

Todo.belongsTo(User, { foreignKey: 'userId' });

module.exports = Todo;