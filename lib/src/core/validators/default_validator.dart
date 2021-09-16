class DefaultValidator {
  static String? required(String? val, [String? label]) {
    if (val == null) {
      return "This field is required";
    }
    if (val.isEmpty && label != null) {
      return "$label is required";
      /* return () {
        if (val.isEmpty) {
          return "$label field is required";
        }
        return null;
      }; */
    }
    if (val.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? email(String email) {
    RegExp pattern = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    bool isMatch = pattern.hasMatch(email);

    if (!isMatch) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static String? Function() minLength(String val, int length, [String? label]) {
    return () {
      if (val.length < length) {
        if (label!.isNotEmpty) {
          return "$label should be minimum of $length characters";
        } else {
          return "The field should be minimum of $length characters";
        }
      }
      return null;
    };
  }
}
