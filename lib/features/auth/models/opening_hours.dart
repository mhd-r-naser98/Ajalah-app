class OpeningHour {
  final String day;
  final String? open;
  final String? close;

  OpeningHour({required this.day, this.open, this.close});

  factory OpeningHour.fromJson(Map<String, dynamic> json) {
    return OpeningHour(
      day: json['day'],
      open: json['open'],
      close: json['close'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'open': open, 'close': close};
  }
}
