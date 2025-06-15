String formatDate(String isoDate) {
  try {
    final date = DateTime.parse(isoDate);
    return "${date.day}/${date.month}/${date.year}";
  } catch (_) {
    return isoDate;
  }
}
