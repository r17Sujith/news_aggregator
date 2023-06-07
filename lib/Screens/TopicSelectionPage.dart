
import 'package:flutter/material.dart';
import 'package:twenty4_hours/Model/DTO/FavoriteSelectionDTO.dart';
import 'package:twenty4_hours/Screens/LandingPage.dart';
import 'package:twenty4_hours/Utils/SharedPreference.dart';
import 'package:twenty4_hours/Utils/UtilityMethods.dart';
class TopicSelectionPage extends StatefulWidget {
  const TopicSelectionPage({Key? key}) : super(key: key);

  @override
  State<TopicSelectionPage> createState() => _TopicSelectionPageState();
}

class _TopicSelectionPageState extends State<TopicSelectionPage> {

  late List<FavoriteSelectionDto> topics = <FavoriteSelectionDto>[];
  List<String> selectedFavorites = [];


  @override
  void initState() {
    for (var element in sharedPrefs.sectionList!) {
      topics.add(FavoriteSelectionDto(section: element,isSelected: false));
    }
    if (sharedPrefs.favoriteSections!=null&&sharedPrefs.favoriteSections!.isNotEmpty) {
      for(var favSection in sharedPrefs.favoriteSections!){
        for (var element in topics) {
          print("${element.section} = ${favSection[0].toUpperCase()}${favSection.substring(1)}");
          if(element.section == "${favSection[0].toUpperCase()}${favSection.substring(1)}"){
            element.isSelected = true;
          }
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
          ),
          Positioned(
            top: 20,
            left: 10,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Select Your Interested Topics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            bottom: 80, // Adjust bottom padding for button
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(topics[index].section!),
                    trailing: Checkbox(
                      value: topics[index].isSelected,
                      onChanged: (value) {
                        setState(() {
                          topics[index].isSelected = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green, // Set text color
                padding: const EdgeInsets.symmetric(vertical: 16), // Set vertical padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Set button border radius
                ),
              ),
              onPressed: () {
                _handleContinue();
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
  void _handleContinue(){
    sharedPrefs.favoritesSelected = true;
    List<String> sections = [];
    for (var element in topics) {
      if(element.isSelected!){
        sections.add(element.section!.toLowerCase());
      }
    }
    if (sections.isNotEmpty) {
      sharedPrefs.favoriteSections= sections;
    } else {
      UtilityMethods.createSnackBar(context, "Please select at least one Topic");
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => const LandingPage()),(route) => false);
  }
}
