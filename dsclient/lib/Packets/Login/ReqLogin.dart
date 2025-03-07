import '../BaseRequest.dart';

class ReqLogin extends BaseRequest {
  late String userName;
  late String userPass;

  ReqLogin({required this.userName, required this.userPass})
      : super('', 0, 'api/Login'); 

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'userName': userName,
        'userPass': userPass,
      };
}