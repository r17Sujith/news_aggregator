import 'package:twenty4_hours/Api/ApiEndPoints.dart';
import 'package:twenty4_hours/Api/ApiKeyStrings.dart';
import 'package:twenty4_hours/Api/ApiKeys.dart';
import 'package:twenty4_hours/Api/DioHTTPClient.dart';
import 'package:twenty4_hours/Model/NewsResponse.dart';

class GuardianNewsService {
  DioHttpClient httpClient = DioHttpClient();


  Future<Response?> getSectionAndFavorites(int page,String orderBy,[String? searchQuery]) async {
    Map<String,dynamic> queries ={ApiKeyStrings.apiKey: ApiKeys.apiKey, ApiKeyStrings.page: page,"order-by":orderBy.toLowerCase(),
      "show-elements":"image","show-fields":"thumbnail,starRating,publication","page-size":30};
    if(searchQuery!=null&&searchQuery.length>1) {
      queries.addAll({"q": searchQuery});
    }
   final response = await httpClient.getRequest(ApiEndPoints.search, queries);
   if(response.statusCode == 200){
     final incomingData = NewsResponse.fromJson(response.data);
     return incomingData.response;
   }
   throw Exception('Some arbitrary error');
  }


  Future<Response?> getSection(String orderBy,int page,String section) async {
    Map<String,dynamic> queries ={ApiKeyStrings.apiKey: ApiKeys.apiKey, ApiKeyStrings.page: page,"section": section.toLowerCase(),"order-by":orderBy.toLowerCase(),
      "show-elements":"image","show-fields":"thumbnail,starRating,publication","page-size":30};

   final response = await httpClient.getRequest(ApiEndPoints.search, queries);
   if(response.statusCode == 200){
     final incomingData = NewsResponse.fromJson(response.data);
     return incomingData.response;
   }
   throw Exception('Some arbitrary error');
  }
}