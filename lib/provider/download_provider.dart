import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadProvider extends ChangeNotifier {
  List<Map<String, String>> downloadList = [];

  DownloadProvider() {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("downloads");

    if (saved != null) {
      final decoded = json.decode(saved);

      // convert semua value ke string biar ga error JsonMap
      downloadList = (decoded as List)
          .map((e) => Map<String, String>.from(
                e.map((key, value) =>
                    MapEntry(key.toString(), value.toString())),
              ))
          .toList();
    } else {
      downloadList = [
        {
          "duration": "1h 42m 33s",
          "image": "assets/image/aouad.jpg",
          "title": "Lightyear",
          "fileSize": "1.4 GB",
        },
        {
          "duration": "1h 56m 49s",
          "image": "assets/image/cargo.jpg",
          "title": "Top Gun: Maverick",
          "fileSize": "1.3 GB",
        },
        {
          "duration": "2h 28m 32s",
          "image": "assets/image/dune.jpg",
          "title": "Thor: Love & Thunder",
          "fileSize": "928.3 MB",
        },
        {
          "duration": "56m 43s",
          "image": "assets/image/joker.jpg",
          "title": "Stranger Things 4: Episode 1",
          "fileSize": "827.6 MB",
        },
        {
          "duration": "2h 49m 56s",
          "image": "assets/image/spiderman.jpg",
          "title": "Avatar: The Way of Water",
          "fileSize": "1.9 GB",
        },
      ];
    }

    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("downloads", json.encode(downloadList));
  }

  void deleteItem(Map<String, String> item) {
    downloadList.remove(item);
    saveData();
    notifyListeners();
  }
}
