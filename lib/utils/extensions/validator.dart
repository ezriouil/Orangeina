class Validator {
  Validator._();

  static String? validateCustomField(String? value, String validCustomFieldError1) {
    if (value == null || value.isEmpty || value.length < 2) { return validCustomFieldError1; }
    return null;
  }

  static String? validateEmailField(String? value, String validEmailError1, String validEmailError2) {
    if (value == null || value.isEmpty) { return validEmailError1; }
    final emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegExp.hasMatch(value)) { return validEmailError2; }
    return null;
  }

  static String? validatePasswordField(String? value, String validPasswordError1, String validPasswordError2, String validPasswordError3, String validPasswordError4) {
    if (value == null || value.isEmpty) { return validPasswordError1; }
    else if (value.length < 5) { return validPasswordError2;}
    else if (value.length < 7) { return validPasswordError3; }
    else if (value.length > 20) { return validPasswordError4;}
    return null;
  }

  static String? validateMobilePhone(String? value, String validMobilePhoneError1, String validMobilePhoneError2) {
    String pattern = r'(^(?:[+0]9)?[0-9]{9,11}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) { return validMobilePhoneError1; }
    else if (!regExp.hasMatch(value)) { return validMobilePhoneError2; }
    return null;
  }

  static String? validateAge(String? value, String? validAgeError1,String validAgeError2,String validAgeError3,String validAgeError4) {
    String pattern = r'(^(?:[+0]9)?[0-9]{2,3}$)';
    RegExp regExp = RegExp(pattern);
     if (value!.isEmpty) { return validAgeError1; }
     else if (!regExp.hasMatch(value)) { return validAgeError2; }
     else if (int.parse(value) < 18) { return validAgeError3; }
     else if (int.parse(value) > 70) { return validAgeError4; }
     return null;
  }
}


