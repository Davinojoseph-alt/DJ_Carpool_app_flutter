const GOOGLE_API_KEY = "AIzaSyBCVlmNRb1ezX1iqTK6iACdjE9hWPostRk";

class LocationHelper {
  static String generateLocationPreviewImage({
    required double? latitude,
    required double? longitude,
  }) {
    String url =
        "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
    return url;
  }
}
