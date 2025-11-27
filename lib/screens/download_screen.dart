import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mova_app/widgets/bottom_navbar.dart'; // Pastikan path ini benar

class DownloadScreen extends StatefulWidget {
  DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadState();
}

class _DownloadState extends State<DownloadScreen> {
  int currentIndex = 3;
  String searchQuery = "";
  List<Map<String, String>> downloadList = [
    {
      "duration": "1h 42m 33s",
      "image": "assets/image/aouad.jpg",
      "title": "All Of Us Are Dead",
      "fileSize": "1.4 GB"
    },
    {
      "duration": "1h 56m 49s",
      "image": "assets/image/cargo.jpg",
      "title": "Cargo",
      "fileSize": "1.3 GB"
    },
    {
      "duration": "2h 28m 32s",
      "image": "assets/image/dune.jpg",
      "title": "Dune",
      "fileSize": "928.3 MB"
    },
    {
      "duration": "56m 43s",
      "image": "assets/image/joker.jpg",
      "title": "Joker",
      "fileSize": "827.6 MB"
    },
    {
      "duration": "2h 49m 56s",
      "image": "assets/image/spiderman.jpg",
      "title": "Spiderman",
      "fileSize": "1.9 GB"
    },
    {
      "duration": "Duration Here",
      "image": "assets/image/stalker.jpg",
      "title": "Stalker",
      "fileSize": "Size Here"
    },
  ];

  // logika buat ngehapus dari downlaod, atau delete
  void _deleteDownload(int index) {    
    List<Map<String, String>> filteredList = downloadList.where((item) {
      return item["title"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    if (index >= 0 && index < filteredList.length) {
      final itemToDelete = filteredList[index];
      
      final originalIndex = downloadList.indexOf(itemToDelete);

      if (originalIndex != -1) {
        setState(() {
          downloadList.removeAt(originalIndex);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${itemToDelete["title"]} removed from downloads."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  List<Map<String, String>> get _filteredDownloadList {
    if (searchQuery.isEmpty) {
      return downloadList;
    }
    return downloadList.where((item) {
      return item["title"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    final displayedList = _filteredDownloadList;

    return Scaffold(
      backgroundColor: Color(0xFF0E0E10),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/image/logo.png", width: 34),
                      SizedBox(width: 10),
                      Text(
                        "Download",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white54),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search your movie...",
                          hintStyle: TextStyle(color: Colors.white38),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),              
               if (searchQuery.isNotEmpty) 
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8.0),
                   child: Text(
                     "${displayedList.length} results found for \"$searchQuery\"",
                     style: TextStyle(color: Colors.white70, fontSize: 14),
                   ),
                 ),

              Expanded(
                child: displayedList.isEmpty
                    ? _buildEmpty()
                    : _buildDownloadList(displayedList),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: currentIndex),
    );
  }

  Widget _buildDownloadList(List<Map<String, String>> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item["image"]!,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 120,
                    ),
                  ),
                  Icon(
                    Icons.play_circle_fill,
                    color: Colors.white.withValues(alpha: 0.8), // Warna putih transparan
                    size: 40,
                  ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        item["duration"]!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item["fileSize"]!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _deleteDownload(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white38,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/emptyred.json", width: 230, height: 230),
          SizedBox(height: 14),
          Text(
            searchQuery.isEmpty ? "No Downloads Yet" : "No Results Found", 
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            searchQuery.isEmpty ? "Download your favorite movies or series to watch offline" : "Try searching something else",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}