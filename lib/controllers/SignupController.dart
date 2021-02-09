import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:ventas_db/helpers/config.dart';
import 'package:ventas_db/ventas_db.dart';

class SignupController extends ResourceController {
  @Operation.post()
  Future<Response> signup() async {
    final String token = _sign_token();
    return Response.ok(token);
  }

  String _sign_token() {
    final claimSet = JwtClaim(
        issuer: 'PATMServer',
        subject: '2020',
        issuedAt: DateTime.now(),
        maxAge: const Duration(hours: 2));
    const String secret = Properties.jwtSecret;
    return issueJwtHS256(claimSet, secret);
  }
}
