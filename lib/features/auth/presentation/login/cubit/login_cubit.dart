import 'package:beyond/core/widgets/phone_field.dart';
import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:beyond/features/auth/domain/use_cases/get_countries.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final GetCountries _getCountries;

  LoginCubit({required GetCountries getCountries}) : _getCountries = getCountries, super(InitialState());

  final phoneController = PhoneFieldController();
  final countryCodeController = TextEditingController(text: '+');

  List<Country>? _countries;
  Country? selectedCountry;

  @PostConstruct()
  void initialize() async {
    final result = await _getCountries.call();

    _countries = result.fold((l) => null, (r) => r);

    selectedCountry = await _countries?.findUserCountry();

    emit(CountryState(country: selectedCountry));
  }

  void phoneNumberInserted(String number) {
    String removeLast(String s) => s.isNotEmpty ? s.substring(0, s.length - 1) : s;

    if (number.isEmpty) {
      phoneController.setText(removeLast(phoneController.rawText));
    } else {
      phoneController.setText(phoneController.rawText + number);
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    countryCodeController.dispose();
    return super.close();
  }
}
