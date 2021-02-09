import 'package:ventas_db/models/OrderDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class OrderController extends ResourceController {
  //La referencia a nuestra base de datos
  OrderController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllOrders() async {
    final ordersQuery = Query<OrderDAO>(context);
    final orders = await ordersQuery.fetch();
    return Response.ok(orders);
  }

  @Operation.get('idOrder')
  Future<Response> getOrder(@Bind.path('idOrder') int idord) async {
    final orderQuery = Query<OrderDAO>(context)
      ..where((p) => p.idOrder).equalTo(idord);
    final order = await orderQuery.fetchOne();
    return order != null ? Response.ok(order) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addOrder() async {
    final order = OrderDAO()
      ..read(await request.body.decode(), ignore: ['idOrder']);
    final orderQuery = Query<OrderDAO>(context)..values = order;
    final addOrder = await orderQuery.insert();
    return Response.ok(addOrder);
  }

  @Operation.put('idOrder')
  Future<Response> updateOrder(@Bind.path('idOrder') int idOrder) async {
    final order = OrderDAO()..read(await request.body.decode());
    final orderQuery = Query<OrderDAO>(context)
      ..where((x) => x.idOrder).equalTo(idOrder)
      ..values = order;
    final updOrder = await orderQuery.update();
    return Response.ok(updOrder);
  }

  @Operation.delete('idOrder')
  Future<Response> deleteOrder(@Bind.path('idOrder') int idOrder) async {
    final orderQuery = Query<OrderDAO>(context)
      ..where((x) => x.idOrder).equalTo(idOrder);
    final delOrder = await orderQuery.delete();
    return Response.ok(delOrder);
  }
}
