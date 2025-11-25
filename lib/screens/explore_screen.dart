import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mova_app/widgets/filter_bottom_sheets.dart';
import 'package:mova_app/widgets/movie_card.dart';
import 'package:mova_app/widgets/search_bar.dart';
import 'package:mova_app/widgets/selected_filter_chip.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> selectedFilters = [];
  String searchQuery = "";

  List<Map<String, String>> posters = [
    {"rating": "9.8", "image": "assets/image/aouad.jpg", "title": "All Of Us Are Dead",},
    {"rating": "9.7", "image": "assets/image/joker.jpg", "title": "Joker"},
    {"rating": "9.6", "image": "assets/image/megan.jpg", "title": "Megan"},
    {"rating": "9.6", "image": "assets/image/parasite.jpg", "title": "Parasite"},
    {"rating": "9.6", "image": "assets/image/spiderman.jpg", "title": "Spiderman"},
    {"rating": "9.6", "image": "assets/image/stalker.jpg", "title": "Stalker"},
    {"rating": "9.6", "image": "assets/image/tangled.jpg", "title": "Tangled"},
    {"rating": "9.6", "image": "assets/image/tlou.jpg", "title": "The Last Of Us"},
    {"rating": "9.6", "image": "assets/image/cargo.jpg", "title": "Cargo"},
    {"rating": "9.6", "image": "assets/image/dune.jpg", "title": "Dune"},
  ];

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: FilterBottomSheet(
            selectedFilters: selectedFilters,
            onApply: (newFilters) {
              setState(() => selectedFilters = newFilters);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = posters.where((poster) {
      return poster["title"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor:Color(0xFF0E0E10),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
                onFilterTap: openFilterSheet,
              ),
              SelectedFilterChips(
                selectedFilters: selectedFilters,
                onClear: () => setState(() => selectedFilters.clear()),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/error.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Not Found',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Sorry, the keyword you entered couldn't be found. Try to check again and search with other keywords.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        itemCount: filtered.length,
                        padding: EdgeInsets.only(top: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.67,
                        ),
                        itemBuilder: (_, i) {
                          return MovieCard(
                            rating: filtered[i]["rating"]!,
                            imagePath: filtered[i]["image"]!,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
