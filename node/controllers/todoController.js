const Todo = require('../models/todo');

exports.getTodos = async (req, res) => {
  try {
    const todos = await Todo.findAll();
    res.json({ todos });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch todos' });
  }
};

exports.getMyTodos = async (req, res) => {
  try {
    const todos = await Todo.findAll({ where: { userId: req.user.id } });
    res.json({ todos });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch user todos' });
  }
};

exports.addTodo = async (req, res) => {
  const { title } = req.body;
  try {
    const todo = await Todo.create({ title, userId: req.user.id });
    res.status(201).json({ todo });
  } catch (error) {
    res.status(500).json({ error: 'Failed to add todo' });
  }
};

exports.editTodo = async (req, res) => {
  const { id, title } = req.body;
  try {
    await Todo.update({ title }, { where: { id, userId: req.user.id } });
    res.json({ message: 'Todo updated' });
  } catch (error) {
    res.status(500).json({ error: 'Error updating todo' });
  }
};

exports.deleteTodo = async (req, res) => {
  const { id } = req.params; 
  try {
    const deletedCount = await Todo.destroy({ where: { id, userId: req.user.id } });
    if (deletedCount === 0) {
      return res.status(404).json({ error: 'Todo not found' });
    }
    res.json({ message: 'Todo deleted' });
  } catch (error) {
    res.status(500).json({ error: 'Error deleting todo' });
  }
};
exports.findTodoById = async (req, res) => {
  try {
    const todo = await Todo.findOne({ where: { id: req.params.id, userId: req.user.id } });
    res.json(todo);
  } catch (error) {
    res.status(500).json({ error: 'Todo not found' });
  }
};

exports.renderEditPage = async (req, res) => {
  try {
    const todo = await Todo.findOne({ where: { id: req.params.id, userId: req.user.id } });
    if (!todo) return res.status(404).json({ error: 'Todo not found' });
    res.json(todo);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch todo' });
  }
};