// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/auth/data/data_source/auth_data_source.dart';
import '../themes/theme_cubit.dart' as _i965;
import '../translation/language_cubit.dart' as _i134;
import 'app_injection.dart' as _i108;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i134.LanguageCubit>(
      () => _i134.LanguageCubit(),
      dispose: (i) => i.close(),
    );
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i965.ThemeCubit>(
      () => _i965.ThemeCubit(),
      dispose: (i) => i.close(),
    );
    gh.singleton<AuthDataSource>(
      () => AuthDataSource(firebaseAuth: gh<FirebaseAuth>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i108.RegisterModule {}
