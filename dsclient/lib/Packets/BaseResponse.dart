class BaseResponse {
  int resultCode;

  BaseResponse({this.resultCode = 0});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      resultCode: json['resultCode'],
    );
  }
}