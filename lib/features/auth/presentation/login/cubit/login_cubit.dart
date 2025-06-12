import 'package:beyond/core/widgets/phone_field.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  final phoneController = PhoneFieldController();
  final countryCodeController = TextEditingController(text: '+');

  phoneNumberInserted(String number) {
    String removeLast(String s) => s.isNotEmpty ? s.substring(0, s.length - 1) : s;

    if (number.isEmpty) {
      phoneController.setText(removeLast(phoneController.rawText));
    } else {
      phoneController.setText(phoneController.rawText + number);
    }
  }
}
