// lib/models/investments/investment_horizon.dart

/// Enum representing investment horizon preferences
enum InvestmentHorizon {
  shortTerm,
  midTerm,
  longTerm,
}

extension InvestmentHorizonExtension on InvestmentHorizon {
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

  static InvestmentHorizon fromName(String name) {
    return InvestmentHorizon.values.firstWhere(
      (e) => e.name == name,
      orElse: () => InvestmentHorizon.shortTerm,
    );
  }
}
