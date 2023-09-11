import 'package:hortifrute/src/constants/endpoints.dart';
import 'package:hortifrute/src/services/http_manager.dart';

class AuthRepository{

  final HttpManager _httpManager = HttpManager();
  Future signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    if(result['result'] != null){
      print('Signin funcionu!');
      print(result['result']);
    } else {
      print('Signin não funcionou!');
      print(result['error']);
    }
  }
}