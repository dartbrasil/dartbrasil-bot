class PubService {
  static String searchPackage(String message) {
    String formattedMessage = message.substring(8).split(' ').join('+');
    return 'https://pub.dartlang.org/packages?q=$formattedMessage';
  }
}