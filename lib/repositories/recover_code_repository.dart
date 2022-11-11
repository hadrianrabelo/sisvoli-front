import 'package:http/http.dart' as http;
void main() {
  recoverCode(cpf: '62351001672');
}
  Future<int> recoverCode({cpf,token}) async {
    var url = Uri.parse(
        'http://26.132.120.62:8080/user/password-recover/response');
    var response = await http.post(url, body: {'userDocument': '$cpf', 'token': '$token'});
    //final Map<String, dynamic> map = await jsonDecode(response.body);
    var status = response.statusCode;
    return status;
  }