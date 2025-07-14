// lib/models/investor_status.dart

/// Enum indicating an investor's openness to invest.
enum InvestorStatus {
  open,
  indifferent,
  notOpen,
}

extension InvestorStatusExtension on InvestorStatus {
  String get label {
    switch (this) {
      case InvestorStatus.open:
        return 'Open to Investment';
      case InvestorStatus.indifferent:
        return 'Indifferent';
      case InvestorStatus.notOpen:
        return 'Not Open';
    }
  }
}
