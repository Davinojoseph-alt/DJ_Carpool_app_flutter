class TripCreateParams {
  final String partnerName;
  final String partnerKey;
  final String travelerName;
  final String travelerPassword;
  final String email;
  final String homeCity;
  final String homeCountry;
  final double olat;
  final double olon;
  final String workCity;
  final String workCountry;
  final double dlat;
  final double dlon;
  final String regularSchedule;
  final List<int> travelDays;
  final String car;

  TripCreateParams({
    required this.partnerName,
    required this.partnerKey,
    required this.travelerName,
    required this.travelerPassword,
    required this.email,
    required this.homeCity,
    required this.homeCountry,
    required this.olat,
    required this.olon,
    required this.workCity,
    required this.workCountry,
    required this.dlat,
    required this.dlon,
    required this.regularSchedule,
    required this.travelDays,
    required this.car,
  });
}
