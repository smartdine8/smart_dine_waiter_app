String workFirstLaterCap (String str) {
  str = str.replaceAll('_', ' ').splitMapJoin( RegExp(r'\w+'),
      onMatch: (m) => m.group(0)!.substring(0, 1).toUpperCase() +
      m.group(0)!.substring(1).toLowerCase(),

  onNonMatch: (n) => ' '
  );
  return str;

  }