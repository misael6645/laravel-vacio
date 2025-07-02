<h1>Bienvenido, {{ $user['name'] }}</h1>
<p>Correo: {{ $user['email'] }}</p>

<a href="{{ route('logout') }}">Cerrar sesión</a>
