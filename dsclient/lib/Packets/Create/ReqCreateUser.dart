import '../BaseRequest.dart';

class ReqCreateUser extends BaseRequest {
  late String userName;
  late String userPass;
  late int charType = 1;

  ReqCreateUser({required this.userName, required this.userPass})
      : super('', 0, 'api/CreateUser'); 

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'userName': userName,
        'userPass': userPass,
        'charType': charType,
      };
}