

import 'package:flutter/cupertino.dart';
import 'package:twenty4_hours/Model/DTO/UserInteractedSections.dart';
import 'package:twenty4_hours/Model/NewsResponse.dart';
import 'package:twenty4_hours/Service/GuardianNewsService.dart';
import 'package:twenty4_hours/Utils/SharedPreference.dart';
import 'package:twenty4_hours/Utils/UtilityMethods.dart';


class GuardianNewsProvider extends ChangeNotifier{

  int _page = 1 , _sectionPage = 1,_favoritePage=1,_topPicksPage=1;

  int get page => _page;
  int get sectionPage => _sectionPage;
  int get favoritePage => _favoritePage;
  int get topPicksPage => _topPicksPage;

  final guardianNewsService = GuardianNewsService();

  bool isLoading = false;
  bool isSectionLoading = false;
  bool isFavoriteLoading = false;
  bool isTopPicksLoading = false;

  List<Results> _news = <Results>[] , _sectionNews = <Results>[],_favoriteSections = <Results>[],_topPicksSection = <Results>[];

  List<Results> get news => _news;
  List<Results> get sectionNews => _sectionNews;
  List<Results> get favoriteSection => _favoriteSections;
  List<Results> get topPicksSection => _topPicksSection;

  Future<void> getTopPicks(String orderBy,[bool? refresh]) async {
    if(sharedPrefs.interactedSections!=null&&sharedPrefs.interactedSections!.isNotEmpty){
      List<UserInteractedSections> storedUserInteraction =   <UserInteractedSections>[];
      storedUserInteraction = UtilityMethods.jsonToUserInteractedSection();
      storedUserInteraction.sort((a, b) => b.numOfClicks!.compareTo(a.numOfClicks!));
      late String q;
      List<String> data =[];
      if(storedUserInteraction.length > 5){
        for(var element in storedUserInteraction.getRange(0, 5)){
          data.add(element.section!);
        }
        q = data.join(",");
      } else{
        for(var element in storedUserInteraction){
          data.add(element.section!);
        }
        q = data.join(",");
      }

      // to stop multiple api calls while scrolling
      if(isTopPicksLoading) return;

      if (_topPicksPage > 1) {
        isTopPicksLoading = true;
        notifyListeners();
      }

      if(refresh!=null&&refresh){
        _topPicksPage= 1;
        _topPicksSection.clear();
        notifyListeners();
      }

      await guardianNewsService.getSectionAndFavorites(_topPicksPage,orderBy,q).then((response){
        if (response!.pages! > _topPicksPage||response.pages==0) {
          _topPicksPage = _topPicksPage + 1;
        }
        addNewsDataToList(response.results!,false,false,true);
      });
      isTopPicksLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFavorites(String orderBy,[bool? refresh]) async {
    if(sharedPrefs.favoriteSections!=null&&sharedPrefs.favoriteSections!.isNotEmpty){
      String q = sharedPrefs.favoriteSections!.join(",");
      // to stop multiple api calls while scrolling
      if(isFavoriteLoading) return;
      if (_favoritePage > 1) {
        isFavoriteLoading = true;
        notifyListeners();
      }

      if(refresh!=null&&refresh){
        _favoritePage= 1;
        _favoriteSections.clear();
        notifyListeners();
      }


      await guardianNewsService.getSectionAndFavorites(_favoritePage,orderBy,q).then((response){
        if (response!.pages! > _favoritePage||response.pages==0) {
          _favoritePage = _favoritePage + 1;
        }
        addNewsDataToList(response.results!,false,true,false);
      });
      isFavoriteLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllNews(String orderBy,[String? searchQuery,bool? isSearch]) async {

    // to stop multiple api calls while scrolling
    if(isLoading) return;

    if (_page > 1) {
      isLoading = true;
      notifyListeners();
    }
    if(isSearch!=null&&isSearch){
      _page = 1;
      _news.clear();
      notifyListeners();
    }

    await guardianNewsService.getSectionAndFavorites(_page,orderBy,searchQuery).then((response){
      if (response!.pages! > _page||response.pages==0) {
        _page = _page + 1;
      }
      addNewsDataToList(response.results!,false,false,false);
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> getNewsSection(String orderBy,String section,[bool? isTabClick,]) async {
    // to stop multiple api calls while scrolling
    if(isSectionLoading) return;

    if (_sectionPage > 1) {
      isSectionLoading = true;
      notifyListeners();
    }
    if(isTabClick!){
      _sectionPage= 1;
      _sectionNews.clear();
      notifyListeners();
    }

    await guardianNewsService.getSection(orderBy,_sectionPage,section).then((response){
      if (response!.pages! > _sectionPage||response.pages==0) {
        _sectionPage = _sectionPage + 1;
      }
      addNewsDataToList(response.results!,true,false,false);
    });

    isSectionLoading = false;
    notifyListeners();
  }

  void addNewsDataToList(List<Results> results,bool isSection,bool isFavorites,bool isTopPicks) {
    if (isSection) {
      _sectionNews.addAll(results);
    }else if(isFavorites){
      _favoriteSections.addAll(results);
    } else if(isTopPicks){
      _topPicksSection.addAll(results);
    }else{
      _news.addAll(results);
    }
    notifyListeners();
  }

}