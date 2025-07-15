/// Enum indicating an investor's openness to invest.
enum InvestorStatus {
  open,
  indifferent,
  notOpen,
}

/// Extension for readable labels and utility methods for InvestorStatus.
extension InvestorStatusExtension on InvestorStatus {
  /// Human-readable label for display in UI
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

  /// Short name/code for storage or transmission
  String get code => name; // e.g. 'open', 'indifferent', 'notOpen'

  /// Parses a code or name into InvestorStatus (e.g. from DB/API)
  static InvestorStatus fromName(String name) {
    return InvestorStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => InvestorStatus.indifferent,
    );
  }

  /// Parses from label (more user-friendly UI fallback)
  static InvestorStatus fromLabel(String label) {
    switch (label.trim().toLowerCase()) {
      case 'open to investment':
        return InvestorStatus.open;
      case 'not open':
        return InvestorStatus.notOpen;
      case 'indifferent':
      default:
        return InvestorStatus.indifferent;
    }
  }
}
