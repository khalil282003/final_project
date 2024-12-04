const express = require('express');
const todoController = require('../controllers/todoController');
const authMiddleware = require('../middleware/authMiddleware');

const router = express.Router();

router.get('/', authMiddleware, todoController.getTodos);
router.get('/mytodos', authMiddleware, todoController.getMyTodos);
router.post('/add', authMiddleware, todoController.addTodo);
router.post('/edit', authMiddleware, todoController.editTodo);
router.delete('/delete/:id', authMiddleware, todoController.deleteTodo);
router.get('/:id', authMiddleware, todoController.findTodoById);
router.get('/edit/:id', authMiddleware, todoController.renderEditPage);

module.exports = router;


