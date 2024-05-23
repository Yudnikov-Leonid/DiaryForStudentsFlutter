import 'package:edu_diary/core/presentation/validation.dart';
import 'package:edu_diary/core/presentation/validation_exceptions.dart';
import 'package:edu_diary/core/usecase/usecase.dart';
import 'package:edu_diary/features/login/domain/entity/login_result.dart';
import 'package:edu_diary/features/login/domain/repository/login_repository.dart';

class LoginUseCase implements UseCase<LoginResult, (String, String)?> {
  final LoginRepository _repository;
  final UiValidator loginUiValidator;
  final UiValidator passwordUiValidator;
  LoginUseCase(this._repository,
      {required this.loginUiValidator, required this.passwordUiValidator});

  @override
  Future<LoginResult> call({(String, String)? params}) async {
    try {
      loginUiValidator.isValid(params!.$1);
      passwordUiValidator.isValid(params.$2);
      return _repository.login(params.$1, params.$2);
    } on LoginException catch(e) {
      return LoginEmailFail(e.message);
    } on PasswordException catch (e) {
      return LoginPasswordFail(e.message);
    }
  }
}
