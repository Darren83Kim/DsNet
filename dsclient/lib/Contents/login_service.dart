import 'dart:convert';
import 'package:dsclient/Packets/BaseResponse.dart';
import 'package:dsclient/main.dart';
import 'package:http/http.dart' as http;
import '../Packets/Login/ReqLogin.dart';

class LoginService {
  Future<BaseResponse> login(ReqLogin loginRequest) async {
    final url = Uri.parse(lootUrl + loginRequest.url);
    print('Request URL: $url'); // 디버그를 위해 URL 출력
    print('Request Body: ${jsonEncode(loginRequest.toJson())}'); // 디버그를 위해 요청 본문 출력

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginRequest.toJson()),
    );

    print('Response Status Code: ${response.statusCode}'); // 디버그를 위해 상태 코드 출력
    print('Response Body: ${response.body}'); // 디버그를 위해 응답 본문 출력

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}