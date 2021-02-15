enum PasswordValidationResults {
  VALID,
  TOO_SHORT,
  EMPTY_PASSWORD,
}

enum EmailValidationResults {
  VALID,
  NON_VALID,
  EMPTY,
}
enum NameValidationResults {
  SHORT,
  LONG,
  VALID,
  NON_VALID,
  EMPTY,
}

class Validator {
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  static final RegExp numberRegExp = RegExp(r'\d');

  static PasswordValidationResults validatePassword(String password) {
    if (password.isEmpty) {
      return PasswordValidationResults.EMPTY_PASSWORD;
    }
    if (password.length < 6) {
      return PasswordValidationResults.TOO_SHORT;
    }
    return PasswordValidationResults.VALID;
  }

  static EmailValidationResults validateEmail(String email) {
    if (email.isEmpty) {
      return EmailValidationResults.EMPTY;
    }
    if (!emailRegExp.hasMatch(email)) {
      return EmailValidationResults.NON_VALID;
    }
    return EmailValidationResults.VALID;
  }

  static NameValidationResults validateName(String name) {
    if (name.isEmpty) {
      return NameValidationResults.EMPTY;
    }
    if (name.length <= 2) {
      return NameValidationResults.SHORT;
    }
    if (name.length >= 16) {
      return NameValidationResults.LONG;
    }
    if (!nameRegExp.hasMatch(name)) {
      return NameValidationResults.NON_VALID;
    }
    return NameValidationResults.VALID;
  }
}
