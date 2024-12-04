<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TodoController extends Controller
{
    public function getTodos()
    {
        $todos = Todo::all();
        return response()->json(['todos' => $todos]);
    }

    public function getMyTodos()
    {
        $todos = Auth::user()->todos;
        return response()->json(['mytodos' => $todos]);
    }

    public function addTodo(Request $request)
    {
        $request->validate(['title' => 'required|string']);

        $todo = Todo::create([
            'title' => $request->title,
            'user_id' => Auth::id(),
        ]);

        return response()->json(['todo' => $todo], 201);
    }

    public function editTodo(Request $request)
    {
        $request->validate(['id' => 'required|integer', 'title' => 'required|string']);
        $todo = Todo::find($request->id);

        if ($todo && $todo->user_id === Auth::id()) {
            $todo->update(['title' => $request->title]);
            return response()->json(['message' => 'Todo updated']);
        }

        return response()->json(['error' => 'Todo not found or not authorized'], 404);
    }

    public function deleteTodo($id)
    {
        $todo = Todo::find($id);

        if ($todo && $todo->user_id === Auth::id()) {
            $todo->delete();
            return response()->json(['message' => 'Todo deleted']);
        }

        return response()->json(['error' => 'Todo not found or not authorized'], 404);
    }
}