class LocalGeocoder {
  static final Map<String, Map<String, String>> dummyGeocodeData = {
    "ZIM": {
      "17.8,31.0": "Mt Hampden, Harare District",
      "17.9,30.9": "Chinhoyi, Mashonaland West",
    },
    "ZMB": {
      "-15.4,28.3": "Lusaka, Lusaka Province",
      "-13.0,28.6": "Ndola, Copperbelt",
    },
    "KEN": {
      "-1.3,36.8": "Nairobi, Nairobi County",
      "0.5,37.5": "Meru, Meru County",
    },
  };

  /// 🔹 Reverse geocode using dummy offline data
  static Map<String, String> reverseGeocode(double lat, double lng, String countryCode) {
    final key = "${lat.toStringAsFixed(1)},${lng.toStringAsFixed(1)}";
    final countryData = dummyGeocodeData[countryCode];

    if (countryData != null && countryData.containsKey(key)) {
      final result = countryData[key]!;
      final parts = result.split(", ");
      return {
        'locality': parts[0],
        'district': parts.length > 1 ? parts[1] : 'Unknown',
      };
    }

    return {'locality': 'Unknown', 'district': 'Unknown'};
  }
}
