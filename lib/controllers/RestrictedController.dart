import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:ventas_db/helpers/config.dart';
import 'package:ventas_db/ventas_db.dart';

class RestrictedController extends ResourceController {
  @Operation.get()
  Future<Response> restricted(
      @Bind.header("authorization") String authHeader) async {
    if (!_isAuthorized(authHeader)) {
      return Response.forbidden();
    }
    return Response.ok('Aqui Mostrara el resultado de la petición');
  }

  bool _isAuthorized(String authHeader) {
    final parts = authHeader.split(' ');
    if (parts == null || parts.length != 2 || parts[0] != 'Bearer') {
      return false;
    }
    return _isValidToken(parts[1]);
  }

  bool _isValidToken(String token) {
    const key = Properties.jwtSecret;
    try {
      verifyJwtHS256Signature(token, key);
      return true;
    } on JwtException {
      print('invalid token');
    }
    return false;
  }
}
