class Validator {
  Validator._();

  static String? validateEmptyField(String fieldName, String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return "fieldName";
    }
    return null;
  }

  static String? validateEmailField(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return fieldName;
    }

    final emailRegExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!emailRegExp.hasMatch(value)) {
      return "Invalid email address";
    }

    return null;
  }

  static String? validatePasswordField(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return fieldName;
    }

    if (value.length <= 5) {
      return "password must have 6 (char / num) or more";
    }

    return null;
  }
}
