/// Enum indicating an investor's openness to invest.
enum InvestorStatus {
  open,
  notOpen,
  indifferent,
}

/// Extension providing readable labels and utility methods for InvestorStatus.
extension InvestorStatusExtension on InvestorStatus {
  /// Human-readable label for UI display.
  String get label {
    switch (this) {
      case InvestorStatus.open:
        return 'Open';
      case InvestorStatus.notOpen:
        return 'Not Open';
      case InvestorStatus.indifferent:
        return 'Indifferent';
    }
  }

  /// Short name for storage (e.g. 'open', 'notOpen', 'indifferent').
  String get code => name;

  /// Parse from code string (enum name).
  static InvestorStatus fromName(String name) {
    return InvestorStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => InvestorStatus.indifferent,
    );
  }

  /// Parse from UI label.
  static InvestorStatus fromLabel(String label) {
    switch (label.trim().toLowerCase()) {
      case 'open':
      case 'open to investment':
        return InvestorStatus.open;
      case 'not open':
        return InvestorStatus.notOpen;
      case 'indifferent':
      default:
        return InvestorStatus.indifferent;
    }
  }

  /// Parse from any string (label or code).
  static InvestorStatus fromString(String value) {
    try {
      return fromLabel(value);
    } catch (_) {
      return fromName(value);
    }
  }
}
