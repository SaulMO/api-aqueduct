import 'package:ventas_db/controllers/CategoryController.dart';
import 'package:ventas_db/controllers/CustomerController.dart';
import 'package:ventas_db/controllers/OrderController.dart';
import 'package:ventas_db/controllers/OrderDetailController.dart';
import 'package:ventas_db/controllers/ProductController.dart';
import 'package:ventas_db/controllers/RestrictedController.dart';
import 'package:ventas_db/controllers/SignupController.dart';
import 'ventas_db.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class VentasDbChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistent = PostgreSQLPersistentStore.fromConnectionInfo(
        'saul', 'muser1997', 'localhost', 5432, 'ventas_db');
    context = ManagedContext(dataModel, persistent);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    /*router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });*/
    router
        .route("category/[:idCategory]")
        .link(() => CategoryController(context));
    router
        .route("customer/[:idCustomer]")
        .link(() => CustomerController(context));
    router.route("order/[:idOrder]").link(() => OrderController(context));
    router
        .route("orderDetail/[:idOrderDetail]")
        .link(() => OrderDetailController(context));
    router
        .route("/product/[:idProduct]")
        .link(() => ProductController(context));
    router.route("/signup").link(() => SignupController());
    router.route("/restricted").link(() => RestrictedController());

    return router;
  }
}
