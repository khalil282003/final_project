<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required|string|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $user = User::create([
            'username' => $request->username,
            'password' => Hash::make($request->password),
        ]);

        return response()->json(['message' => 'User registered'], 201);
    }

    public function login(Request $request)
    {
        $credentials = $request->only('username', 'password');

        try {
            if (!$token = JWTAuth::attempt($credentials)) {
                return response()->json(['error' => 'Unauthorized'], 401);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => 'Could not create token'], 500);
        }

        return response()->json(compact('token'));
    }

    public function logout()
    {
        JWTAuth::invalidate(JWTAuth::getToken());
        return response()->json(['message' => 'Logged out'], 200);
    }
}

// namespace App\Http\Controllers;

// use App\Models\User;
// use Illuminate\Http\Request;
// use Illuminate\Support\Facades\Hash;

// class AuthController extends Controller
// {
//     public function register(Request $request)
//     {
//         $request->validate([
//             'username' => 'required|string|unique:users',
//             'password' => 'required|string|min:6',
//         ]);

//         try {
//             $user = User::create([
//                 'username' => $request->username,
//                 'password' => Hash::make($request->password),
//             ]);

//             return response()->json(['message' => 'User registered'], 201);
//         } catch (\Exception $e) {
//             return response()->json(['error' => 'Registration failed: ' . $e->getMessage()], 500);
//         }
//     }

//     public function login(Request $request)
//     {
//         $request->validate([
//             'username' => 'required|string',
//             'password' => 'required|string',
//         ]);

//         try {
//             $user = User::where('username', $request->username)->first();

//             if (!$user || !Hash::check($request->password, $user->password)) {
//                 return response()->json(['error' => 'Invalid credentials'], 401);
//             }

//             return response()->json(['message' => 'Login successful']);
//         } catch (\Exception $e) {
//             return response()->json(['error' => 'Login failed: ' . $e->getMessage()], 500);
//         }
//     }

//     public function logout(Request $request)
//     {
//         // Logout logic (if needed)
//         return response()->json(['message' => 'Logged out']);
//     }
// }