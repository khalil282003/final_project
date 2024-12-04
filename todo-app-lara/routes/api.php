<?php
use App\Http\Controllers\AuthController;
use App\Http\Controllers\TodoController;
use Illuminate\Support\Facades\Route;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);

Route::group(['middleware' => ['jwt.auth']], function () {
    Route::get('/todos', [TodoController::class, 'getTodos']);
    Route::get('/mytodos', [TodoController::class, 'getMyTodos']);
    Route::post('/add', [TodoController::class, 'addTodo']);
    Route::post('/edit', [TodoController::class, 'editTodo']);
    Route::delete('/delete/{id}', [TodoController::class, 'deleteTodo']);
});