import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  final phoneController = TextEditingController();

  phoneNumberInserted(String number) {
    String removeLast(String s) => s.isNotEmpty ? s.substring(0, s.length - 1) : s;

    if (number.isEmpty) {
      phoneController.text = removeLast(phoneController.text);
    } else {
      phoneController.text += number;
    }
  }
}
