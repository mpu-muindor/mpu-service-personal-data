<?php

use Illuminate\Container\Container;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use \Faker\Generator;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('public')->group(static function () {
    // Публичное API. Не требует авторизации с помощью Auth-Token
});

Route::post('getBasicInfo', static function (Request $request) {
    $token = $request->header('Auth-Token');
    $faker = Container::getInstance()->make(Generator::class);;
    $faker->seed($token);
    return response()->json([
        'first_name' => $faker->firstName,
        'second_name' => $faker->lastName,
        'birthday' => $faker->date('Y-m-d', '30 years ago'),
        'phone' => $faker->phoneNumber,
        'sex' => null,
        'type' => ['student', 'professor', 'employer'][$faker->numberBetween(0,2)]
    ]);

});
