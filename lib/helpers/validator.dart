class Validator {
  String email(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Por favor, ingrese su email';
    else
      return null;
  }

  String password(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Por favor, ingrese su contraseña';
    else
      return null;
  }

  String name(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Por favor, completar su nombre';
    else
      return null;
  }

  String notEmpty(String value) {
    Pattern pattern = r'^\S+$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Por favor, ingrese algo';
    else
      return null;
  }

  String dni(String value) {
    Pattern pattern = r'^\d{8}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Por favor, ingrese un DNI válido';
    else
      return null;
  }
}
