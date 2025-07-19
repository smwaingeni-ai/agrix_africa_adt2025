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
  String get code => toString().split('.').last;

  /// Parse from code string (enum name).
  static InvestorStatus fromCode(String code) {
    return InvestorStatus.values.firstWhere(
      (e) => e.code.toLowerCase() == code.toLowerCase(),
      orElse: () => InvestorStatus.indifferent,
    );
  }

  /// Parse from UI label.
  static InvestorStatus fromLabel(String label) {
    final normalized = label.trim().toLowerCase();
    if (normalized == 'open' || normalized == 'open to investment') {
      return InvestorStatus.open;
    } else if (normalized == 'not open') {
      return InvestorStatus.notOpen;
    } else {
      return InvestorStatus.indifferent;
    }
  }

  /// Parse from any string (label or code).
  static InvestorStatus fromString(String value) {
    return fromLabel(value); // Fallback handled inside fromLabel
  }
}
