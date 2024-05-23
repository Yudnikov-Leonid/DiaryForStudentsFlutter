import 'package:edu_diary/core/service/edu_user.dart';
import 'package:edu_diary/features/login/data/data_sources/login_data_source.dart';
import 'package:edu_diary/features/login/domain/entity/login_result.dart';
import 'package:edu_diary/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final EduUser _eduUser;
  final LoginDataSource _dataSource;
  LoginRepositoryImpl(this._eduUser, this._dataSource);

  @override
  Future<LoginResult> login(String login, String password) async {
    try {
      final data = await _dataSource.login(login, password);
      _eduUser.save(
          data.data!.email,
          "${data.data!.surname} ${data.data!.name} ${data.data!.secondName}",
          data.data!.guid,
          'SRJTDhppUiI',
          data.data!.schoolName,
          data.data!.grade);
      return LoginSuccess();
    } catch (e) {
      return LoginFail(e.toString());
    }
  }
}
