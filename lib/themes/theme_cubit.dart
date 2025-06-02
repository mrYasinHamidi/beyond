import 'package:beyond/themes/app_theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeCubit extends HydratedCubit<AppTheme> {
  ThemeCubit() : super(AppTheme.light);

  changeTheme() {
    switch (state) {
      case AppTheme.light:
        emit(AppTheme.dark);
        break;
      case AppTheme.dark:
        emit(AppTheme.light);
        break;
    }
  }

  @override
  AppTheme? fromJson(Map<String, dynamic> json) => json['current_theme'];

  @override
  Map<String, dynamic>? toJson(AppTheme state) => {'current_theme': state};

  @disposeMethod
  @override
  Future<void> close() {
    return super.close();
  }
}
