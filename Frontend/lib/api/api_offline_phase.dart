import 'api.dart';
import 'api_result.dart';

class OfflinePhaseAPI {
  Future<APIResult> postPoints(String baseUrl, dynamic body) async {
    var response;
    try{
      response = API.post(baseUrl + '/points', body);
    } catch(err, msg) {
      response = APIResult(code: 500, error: msg.toString());
    }
    return response;
  }
}