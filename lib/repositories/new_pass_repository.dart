import 'package:http/http.dart' as http;
void main() {
  newPass(cpf: '62351001672');
}
  Future<int> newPass({cpf,token,newPassword}) async {
    var url = Uri.parse(
        'http://26.132.120.62:8080/user/password-recover/update-password');
    var response = await http.post(url, body: {
      'userDocument': '$cpf',
      'token': '$token',
      'newPassword': '$newPassword'
    });
    //final Map<String, dynamic> map = await jsonDecode(response.body);
    var status = response.statusCode;
    return status;
  }