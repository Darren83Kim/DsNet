import '../BaseResponse.dart';

class ResCreateUser extends BaseResponse {
  // 필요한 추가 필드가 있으면 여기에 추가

  ResCreateUser({int resultCode = 0}) : super(resultCode: resultCode);

  factory ResCreateUser.fromJson(Map<String, dynamic> json) {
    return ResCreateUser(
      resultCode: json['resultCode'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'resultCode': resultCode,
      };
}