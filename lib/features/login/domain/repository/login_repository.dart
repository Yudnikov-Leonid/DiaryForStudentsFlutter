import 'package:edu_diary/features/login/domain/entity/login_result.dart';

abstract class LoginRepository {
  Future<LoginResult> login(String login, String password);
}