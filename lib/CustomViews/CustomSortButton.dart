import 'package:flutter/material.dart';
import 'package:twenty4_hours/Utils/ScreenUtility.dart';

class SortButton extends StatefulWidget {
  final String currentSortOption;
  final Function(String) onSortOptionSelected;

  const SortButton({super.key,
    required this.currentSortOption,
    required this.onSortOptionSelected,
  });

  @override
  _SortButtonState createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  bool _isPopupOpen = false;

  Widget _buildPopup() {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Positioned(
      bottom: 20,
      right: 20,
      child: AnimatedOpacity(
        opacity: _isPopupOpen ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: ScreenUtility.calculateWidth(width*150),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const ['Newest', 'Relevance', 'Oldest'].map((option) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _isPopupOpen = false;
                  });
                  widget.onSortOptionSelected(option);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: widget.currentSortOption == option
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isPopupOpen = false;
            });
          },
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        _buildPopup(),
        Positioned(
          bottom: 20,
          right: 20,
          child: AnimatedOpacity(
            opacity: _isPopupOpen ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  setState(() {
                    _isPopupOpen = true;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}