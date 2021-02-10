//This class will be used to validate the Applications TextFormFields
class Validator {

  //This is for validating the Email
  static String validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);

    if(value.trim().isEmpty){
      return 'Field cannot be empty.';
    }else if (!regex.hasMatch(value.trim()))
      return 'Please enter a valid email address.';
    else
      return null;

  }

  static String password;
//This is for validating the Password
  static String validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);

    password = value.trim();
    if(value.trim().isEmpty){
      return 'Field cannot be empty.';
    }else if (!regex.hasMatch(value.trim()))
      return 'Password must be at least 6 characters.';
    else
      return null;

  }

  //This is for validating the phone number
  static String validateNumber(String value) {
    Pattern pattern = r'^(?:[0])?[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    if(value.trim().isEmpty){
      return 'This field cannot be left empty.';
    } else if (!regex.hasMatch(value.trim()))
      return 'Please enter a valid phone number.';
    else
      return null;

  }

  //This is for validating the name
  static String validateName(String value) {
    Pattern pattern = r"^[\d \w \s]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim()))
      return 'Please enter your name.';
    else
      return null;
  }

  //This is for validating the Surname
  static String validateSurname(String value) {
    Pattern pattern = r"^[a-zA-Z]+[a-zA-Z]*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim()))
      return 'Please enter your surname.';
    else
      return null;
  }
}