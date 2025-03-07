class BaseRequest{
    late String token;
    late int sequence;
    late String url;

    BaseRequest(String token, int sequence, String url){
        this.token = token;
        this.sequence = sequence;
        this.url = url;
    }

    Map<String, dynamic> toJson() => {
        'token': token,
        'sequence': sequence,
        'url': url
    };
}