/// Enum indicating an investor's openness to invest.
enum InvestorStatus {
  open,
  notOpen,
  indifferent,
}

/// Extension for readable labels and utility methods for InvestorStatus.
extension InvestorStatusExtension on InvestorStatus {
  /// ✅ Human-readable label for display in UI
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

  /// ✅ Short name/code for storage or transmission
  String get code => name; // e.g. 'open', 'notOpen', 'indifferent'

  /// ✅ Parse from enum name string (e.g. from DB/API)
  static InvestorStatus fromName(String name) {
    return InvestorStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => InvestorStatus.indifferent,
    );
  }

  /// ✅ Parse from user-friendly label (fallback for UI selection)
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

  /// ✅ General parsing from either label or name
  static InvestorStatus fromString(String value) {
    try {
      return fromLabel(value);
    } catch (_) {
      return fromName(value);
    }
  }
}
