import 'package:isar/isar.dart';

part 'article_isar.g.dart';

@collection
class ArticleIsar {
  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String urlToImage;
  late String author;
}