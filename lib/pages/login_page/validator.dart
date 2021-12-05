String? emailValidator(String? value) {
  if (value == null) {
    return null;
  }

  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (!emailValid) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null) {
    return null;
  }

  if (value.isEmpty) {
    return 'Enter a valid password';
  } else {
    return null;
  }
}
