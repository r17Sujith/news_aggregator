
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String keyFavorites = "key_Favorites";
  String keySections = "key_Sections";
  String keyFavoritesSelected = "key_FavoritesSelected";
  String keyInteractedSections = "key_InteractedSections";

  static late SharedPreferences _sharedPrefs;

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  List<String>? get favoriteSections => _sharedPrefs.getStringList(keyFavorites);

  set favoriteSections(List<String>? value) {
    _sharedPrefs.setStringList(keyFavorites, value!);
  }

  String? get interactedSections => _sharedPrefs.getString(keyInteractedSections);

  set interactedSections(String? value) {
    _sharedPrefs.setString(keyInteractedSections, value!);
  }

  bool? get favoritesSelected => _sharedPrefs.getBool(keyFavoritesSelected);

  set favoritesSelected(bool? value) {
    _sharedPrefs.setBool(keyFavoritesSelected, value!);
  }

  List<String>? get sectionList => [
    'World news',
    'Business',
    'Global',
    'Sport',
    'Fashion',
    'Food',
    'Politics',
    'Film',
    'Media',];

  removeKey(String key) {
    _sharedPrefs.remove(key);
  }
}



final sharedPrefs = SharedPrefs();
