import 'package:http/http.dart' as http;

// Log in user
Future<http.Response> loginUser(username, password) async {
  var url = 'http://10.0.2.2:3000/api/users/login';
  return await http
      .post(url, body: {'username': username, 'password': password});
}

// Register user
Future<http.Response> registerUser(username, password) async {
  var url = 'http://10.0.2.2:3000/api/users/register';
  return await http
      .post(url, body: {'username': username, 'password': password});
}
