import 'package:ajalah/app/localization/locals/country_names_en.dart';

String getFlagUrl(String countryName) {
  final code = countryCode[countryName]?.toLowerCase();
  return code != null
      ? 'https://flagcdn.com/48x36/$code.png'
      : 'assets/icon/Flags.png';
}
