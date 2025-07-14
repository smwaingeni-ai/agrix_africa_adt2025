// lib/models/investment_horizon.dart

/// Enum representing various investment time horizons.
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
}
