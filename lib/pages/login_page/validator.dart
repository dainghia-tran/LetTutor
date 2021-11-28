String? emailValidator(String? value) {
  if (value == null) {
    return null;
  }

  if (value.isEmpty) {
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
