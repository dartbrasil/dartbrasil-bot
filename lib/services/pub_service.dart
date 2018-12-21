import 'package:teledart/model.dart';

String searchPackage(Message message) {
  String formattedMessage = message.text.substring(8).split(' ').join('+');
  return 'https://pub.dartlang.org/packages?q=$formattedMessage';
}
