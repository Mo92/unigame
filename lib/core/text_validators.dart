const String errorMandatory = 'Dieses Feld darf nicht leer sein.';

class Validators {
  static String? required(String? value) =>
      (value != null && value.isEmpty) ? errorMandatory : null;
}
