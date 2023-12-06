import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
/* ------ token -------- */
const accessTokenKeyLS = 'ACESS_TOKEN';
const refreshTokenKeyLS = 'REFRESH_TOKEN';

/*----- user profile -------*/
const Map<String, String> userInfo = {};
const lastNameLS = 'FIRST_NAME';
const firstNameLS = 'LAST_NAME';
const nickLS = 'USER_NAME';
const emailLS = 'USER_EMAIL';
const birthdayLS = 'AGE';
const phoneNumberLS = 'PHONE_NUMBER';
const genderLs = 'GENDER';
