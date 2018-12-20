import 'package:dotenv/dotenv.dart' show load, env;

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void start() {
  load();
  TeleDart teledart = new TeleDart(new Telegram(env['TG_TOKEN']), new Event());

  teledart.startFetching();

  // You can listen to messages like this
  teledart
    .onMessage(entityType: 'bot_command', keyword: 'start')
    .listen((message) {
      teledart.telegram.sendMessage(message.from.id, 'Como vai? Sou o bot do Dart Brasil no Telegram.');
    });

  // You can even filter streams even more diverse with stream processing methods
  // See: https://www.dartlang.org/tutorials/language/streams#methods-that-modify-a-stream
  teledart
      .onMessage(keyword: 'dart')
      .where((Message message) => message.text.contains('telegram'))
      .listen((message) {
    teledart.replyPhoto(
        message,
//            new io.File('example/dart_bird_catchs_telegram.png'),
        'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dart_bird_catchs_telegram.png',
        caption: 'This is how the Dart Bird and Telegram are met');
  });

  // Inline mode
  teledart.onInlineQuery().listen((inlineQuery) {
    List<InlineQueryResult> results = [
      new InlineQueryResultArticle()
        ..id = 'ping'
        ..title = 'ping'
        ..input_message_content = (new InputTextMessageContent()
          ..message_text = '*pong*'
          ..parse_mode = 'markdown'),
      new InlineQueryResultArticle()
        ..id = 'ding'
        ..title = 'ding'
        ..input_message_content = (new InputTextMessageContent()
          ..message_text = '_dong_'
          ..parse_mode = 'markdown')
    ];
    teledart.answerInlineQuery(inlineQuery, results);
  });
}
