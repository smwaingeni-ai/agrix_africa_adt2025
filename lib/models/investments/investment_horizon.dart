// lib/models/investments/investment_horizon.dart

/// Enum representing investment horizon preferences
enum InvestmentHorizon {
  shortTerm,
  midTerm,
  longTerm,
}

/// Extension providing labels and parsing for InvestmentHorizon
extension InvestmentHorizonExtension on InvestmentHorizon {
  /// User-friendly label for each enum value
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

  /// Parses a string name into an InvestmentHorizon value
  static InvestmentHorizon fromName(String name) {
    return InvestmentHorizon.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => InvestmentHorizon.shortTerm,
    );
  }
}
