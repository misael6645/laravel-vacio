<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

use Illuminate\Support\Facades\Storage;
use myPHPnotes\Microsoft\Auth;
use App\Models\User;

class MicrosoftAuthController extends Controller
{
    public function signInForm()
    {

        if (Session::has('user')) {
            return redirect('/dashboard');
        }
        return view('front.sign-in');
    }

    public function notFound()
    {
        return view('errors.not_authorized', ['email' => session('email')]);
    }

    public function microsoftOAuth()
    {
        $microsoft = new Auth(env('TENANT_ID'), env('CLIENT_ID'), env('CLIENT_SECRET'), env('CALLBACK_URL'), ["User.Read"]);

        $url = $microsoft->getAuthUrl();

        return redirect($url);
    }

    public function microsoftOAuthCallback(Request $request)
    {
        $microsoft = new Auth(env('TENANT_ID'), env('CLIENT_ID'), env('CLIENT_SECRET'), env('CALLBACK_URL'), ["User.Read"]);

        $tokens = $microsoft->getToken($request->code);

        $accessToken = $tokens->access_token;

        $microsoft->setAccessToken($accessToken);

        $user = new \myPHPnotes\Microsoft\Models\User($microsoft);
        // $user = new User($microsoft);

        $name = $user->data->getDisplayName();
        $email = $user->data->getUserPrincipalName();
        // $localUser = User::where('email', $email)->first();

        // if ($localUser) {
            Session::put('user', [
                'name' => $name,
                'email' => $email
            ]);

            return redirect('/dashboard');
        // }

        // return redirect('/not-found')->with('email', $email);
    }

    public function dashboard()
    {
        if (!Session::has('user')) {
            return redirect('/');
        }

        $user = Session::get('user');
        return view('front.dashboard', compact('user'));
    }

    public function logout()
    {
        Session::forget('user');
        return view('front.sign-in');
    }
}
