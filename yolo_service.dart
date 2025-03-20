import 'package:http/http.dart' as http;
import 'dart:convert';

class YoloService {
  final String raspberryPiIP;

  YoloService(this.raspberryPiIP);

  Future<List<dynamic>> fetchDetections() async {
    try {
      final response = await http.get(Uri.parse('http://$raspberryPiIP:5000/detections'));

      if (response.statusCode == 200) {
        List detections = jsonDecode(response.body)["detections"];

        // ترتيب الكائنات من اليسار إلى اليمين بناءً على موقع x
        detections.sort((a, b) => a["x"].compareTo(b["x"]));

        return detections;
      } else {
        throw Exception("خطأ في الاتصال بالسيرفر: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("تعذر الاتصال بالخادم!");
    }
  }
}
