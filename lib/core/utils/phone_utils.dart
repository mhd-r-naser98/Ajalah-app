import 'package:intl_phone_number_input/intl_phone_number_input.dart';

Future<PhoneNumber> parsePhoneNumber(String fullNumber) async {
  return await PhoneNumber.getRegionInfoFromPhoneNumber(fullNumber);
}
