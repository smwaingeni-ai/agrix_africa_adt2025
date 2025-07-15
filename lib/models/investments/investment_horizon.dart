/// Enum representing investment horizon preferences
enum InvestmentHorizon {
  shortTerm,
  midTerm,
  longTerm,
}

/// Extension providing labels and parsing for InvestmentHorizon
extension InvestmentHorizonExtension on InvestmentHorizon {
  /// ✅ Human-readable label
  String get label {
    switch (this) {
      case InvestmentHorizon.shortTerm:
        return 'Short Term';
      case InvestmentHorizon.midTerm:
        return 'Mid Term';
      case InvestmentHorizon.longTerm:
        return 'Long Term';
    }
  }

  /// ✅ Short string value (for storage or API use)
  String get code {
    return name; // Dart >=2.15: enum.name
  }

  /// ✅ Parse from label (safe fallback)
  static InvestmentHorizon fromLabel(String label) {
    switch (label.toLowerCase()) {
      case 'short term':
        return InvestmentHorizon.shortTerm;
      case 'mid term':
        return InvestmentHorizon.midTerm;
      case 'long term':
        return InvestmentHorizon.longTerm;
      default:
        return InvestmentHorizon.shortTerm;
    }
  }

  /// ✅ Parse from raw enum name (e.g. from API/DB)
  static InvestmentHorizon fromName(String name) {
    return InvestmentHorizon.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => InvestmentHorizon.shortTerm,
    );
  }
}
