part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends LoginState {}

class CountryState extends LoginState {
  final Country? country;

  CountryState({required this.country});

  @override
  List<Object?> get props => [country];
}
