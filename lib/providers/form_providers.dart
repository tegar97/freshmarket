import 'package:flutter/cupertino.dart';
import 'package:freshmarket/models/validationModels.dart';

class FormProvider extends ChangeNotifier {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel _phone = ValidationModel(null, null);
  ValidationModel _name = ValidationModel(null, null);
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get phone => _phone;
  ValidationModel get name => _name;

  
}
