class LoginResponse {
  final bool success;
  final LoginData? data;

  LoginResponse({required this.success, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponse(
        success: json['success'],
        data: json['success']
            ? LoginData(
                guid: data['SCHOOLS'][0]['PARTICIPANT']['SYS_GUID'],
                name: data['NAME'],
                surname: data['SURNAME'],
                secondName: data['SECONDNAME'],
                email: data['EMAIL'],
                schoolName: data['SCHOOLS'][0]['SCHOOL']['SHORT_NAME'],
                grade: data['SCHOOLS'][0]['PARTICIPANT']['GRADE']['NAME'])
            : null);
  }
}

class LoginData {
  final String guid, name, surname, secondName, email, schoolName, grade;
  LoginData(
      {required this.guid,
      required this.name,
      required this.surname,
      required this.secondName,
      required this.email,
      required this.schoolName,
      required this.grade});
}
