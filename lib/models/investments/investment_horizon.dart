/// Enum representing investment horizon preferences
enum InvestmentHorizon {
  shortTerm,
  midTerm,
  longTerm,
}

/// Extension providing labels and parsing for InvestmentHorizon
extension InvestmentHorizonExtension on InvestmentHorizon {
  /// ✅ Human-readable label (for UI)
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

  /// ✅ Enum name (e.g., for API or DB storage)
  String get code {
    return name; // Dart >= 2.15
  }

  /// ✅ Parse from human-readable label (fallback-safe)
  static InvestmentHorizon fromLabel(String label) {
    switch (label.trim().toLowerCase()) {
      case 'short term':
        return InvestmentHorizon.shortTerm;
      case 'mid term':
        return InvestmentHorizon.midTerm;
      case 'long term':
        return InvestmentHorizon.longTerm;
      default:
        return InvestmentHorizon.shortTerm; // fallback
    }
  }

  /// ✅ Parse from enum name string (API/DB input)
  static InvestmentHorizon fromName(String name) {
    return InvestmentHorizon.values.firstWhere(
      (e) => e.name.toLowerCase() == name.trim().toLowerCase(),
      orElse: () => InvestmentHorizon.shortTerm,
    );
  }

  /// ✅ Convenience: Parse from either label or name
  static InvestmentHorizon fromString(String value) {
    try {
      return fromLabel(value);
    } catch (_) {
      return fromName(value);
    }
  }
}
