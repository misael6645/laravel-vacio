<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MicrosoftAuthController;



Route::get('/', function () {
    return view('welcome');
});

Route::get('/',[MicrosoftAuthController::class,'signInForm'])->name('sign.in');
Route::get('/not-found',[MicrosoftAuthController::class,'notFound'])->name('not.found');
Route::get('microsoft-oAuth',[MicrosoftAuthController::class,'microsoftOAuth'])->name('microsoft.oAuth');
Route::get('auth/azure/callback',[MicrosoftAuthController::class,'microsoftOAuthCallback'])->name('microsoft.oAuth.callback');
Route::get('/dashboard', [MicrosoftAuthController::class, 'dashboard'])->name('dashboard');
Route::get('/logout', [MicrosoftAuthController::class, 'logout'])->name('logout');
