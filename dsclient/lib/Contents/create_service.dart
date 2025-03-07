import 'dart:convert';
import 'package:dsclient/Packets/BaseResponse.dart';
import 'package:dsclient/main.dart';
import 'package:http/http.dart' as http;
import '../Packets/Create/ReqCreateUser.dart';
import '../Packets/Create/ResCreateUser.dart';

class CreateService {
  Future<ResCreateUser> createUser(ReqCreateUser createRequest) async {
    final url = Uri.parse(lootUrl + createRequest.url);
    print('Request URL: $url'); // 디버그를 위해 URL 출력
    print('Request Body: ${jsonEncode(createRequest.toJson())}'); // 디버그를 위해 요청 본문 출력

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(createRequest.toJson()),
    );

    print('Response Status Code: ${response.statusCode}'); // 디버그를 위해 상태 코드 출력
    print('Response Body: ${response.body}'); // 디버그를 위해 응답 본문 출력

    if (response.statusCode == 200) {
      return ResCreateUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create account');
    }
  }
}