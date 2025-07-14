/// Enum indicating an investor's openness to invest.
enum InvestorStatus {
  open,
  indifferent,
  notOpen,
}

/// Extension for readable labels and utility methods for InvestorStatus.
extension InvestorStatusExtension on InvestorStatus {
  /// Returns a human-readable label for each enum value.
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

  /// Parses a string name into the corresponding enum value.
  static InvestorStatus fromName(String name) {
    return InvestorStatus.values.firstWhere(
      (e) => e.name == name,
      orElse: () => InvestorStatus.indifferent,
    );
  }
}
