
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:twenty4_hours/Model/DTO/UserInteractedSections.dart';
import 'package:twenty4_hours/Utils/SharedPreference.dart';

abstract class UtilityMethods{
  /*Method to show snack bar*/
  static createSnackBar(BuildContext scaffoldContext, var message) {
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text(message), backgroundColor: Colors.red));
  }

  // storing topic/section & num of times interacted to learn & recommend data to user
  static storeNumOfClicksOnSections(String section){
    List<UserInteractedSections> userInteraction = <UserInteractedSections>[];
    if(sharedPrefs.interactedSections !=null && sharedPrefs.interactedSections!.isNotEmpty){
      List<UserInteractedSections> storedUserInteraction =   <UserInteractedSections>[];
      storedUserInteraction = jsonToUserInteractedSection();

      bool isMatching = false;
      for(var element in storedUserInteraction){
        if(element.section==section){
          isMatching=true;
          element.numOfClicks=element.numOfClicks!+1;
        }
      }
      if(!isMatching){
        storedUserInteraction.add(UserInteractedSections(section: section, numOfClicks: 1,));
      }
      sharedPrefs.interactedSections=jsonEncode(storedUserInteraction);
    } else{
      userInteraction.add(UserInteractedSections(section: section, numOfClicks: 1));
      sharedPrefs.interactedSections=jsonEncode(userInteraction);
    }
  }

  static List<UserInteractedSections> jsonToUserInteractedSection() {
    List<dynamic> parsedJson = jsonDecode(sharedPrefs.interactedSections!);
    List<UserInteractedSections> storedUserInteraction = parsedJson.map((item) {
      return UserInteractedSections(
        section: item['section'],
        numOfClicks: item['numOfClicks'],
      );
    }).toList();
    return storedUserInteraction;
  }
}