import 'package:edu_diary/features/login/domain/entity/login_result.dart';
import 'package:edu_diary/features/login/domain/usecases/login.dart';
import 'package:edu_diary/features/login/presentation/bloc/login_event.dart';
import 'package:edu_diary/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitialState()) {
    on<LoginHideErrorsEvent>(_onLoginHideError);
    on<LoginLoginEvent>(_onLogin);
  }

  void _onLoginHideError(LoginHideErrorsEvent event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }

  void _onLogin(LoginLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final result = await loginUseCase(params: (event.login, event.password));
    if (result is LoginSuccess) {
      emit(LoginSuccessState());
    } else if (result is LoginEmailFail) {
      emit(LoginLoginError(result.message));
    } else if (result is LoginPasswordFail) {
      emit(LoginPasswordError(result.message));
    } else if (result is LoginFail) {
      emit(LoginFailureState(result.message));
    }
  }
}