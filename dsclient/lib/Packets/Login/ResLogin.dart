import '../BaseResponse.dart';

class ResLogin extends BaseResponse {
  // 필요한 추가 필드가 있으면 여기에 추가
  String? token;

  ResLogin({int resultCode = 0, this.token}) : super(resultCode: resultCode);

  factory ResLogin.fromJson(Map<String, dynamic> json) {
    return ResLogin(
      resultCode: json['resultCode'],
      token: json['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'resultCode': resultCode,
        'token': token,
      };
}