class Validate {
  static getMsg(String field, String value) {
    final RegExp _regex = RegExp(r"^[a-zA-Z0-9\-\.\,\;\:\'\(\)\s]+$");

    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'The $field cannot be empty';
    } else if (!_regex.hasMatch(value)) {
      return 'The $field cannot contain special characters';
    } else if (value.length < 10) {
      return 'The $field must be at least 10 characters long';
    }

    return null;
  }

  static getDateTimeMsg(String field, String value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Please, select a $field';
    }

    return null;
  }
}
