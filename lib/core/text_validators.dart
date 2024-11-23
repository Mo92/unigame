const String INVALID_MAIL_ERROR = 'Diese E-Mail Adresse ist ungültig.';
const String MANDATORY = 'Dieses Feld darf nicht leer sein.';
const String NOT_VALID = 'Ungültige Eingabe.';
const String PASSWORD_TOO_WEAK =
    'Dein Passwort ist zu schwach, achte auf folgende Kriterien:\nMindestens 8 Zeichen \nMindestens 1 Buchstabe(n) \nMindestens 1 Zahl(en)';

class Validators {
  static String? isValidMail(String? value) {
    if (value == null || value.isEmpty) {
      return MANDATORY;
    }

    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : INVALID_MAIL_ERROR;
  }

  static String? required(String? value) =>
      (value != null && value.isEmpty) ? MANDATORY : null;

  static String? isPostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return MANDATORY;
    }

    if (value.length > 5) {
      return NOT_VALID;
    }

    return RegExp(r"^[0-9]*$").hasMatch(value) ? null : NOT_VALID;
  }

  static String? passwordRequirements(String? value) {
    if (value == null || value.isEmpty) {
      return MANDATORY;
    }

    return RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value)
        ? null
        : PASSWORD_TOO_WEAK;
  }
}
