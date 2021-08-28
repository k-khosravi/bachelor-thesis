import 'api.dart';
import 'api_result.dart';

class OnlinePhaseAPI {
  Future<APIResult> getLocation(String baseUrl, dynamic body) async {
    var response;
    try {
      response = await API.post(baseUrl + '/position', body);
    }catch(err, msg) {
      response = APIResult(code: 500, error: msg.toString());
    }
    return response;
  }
}