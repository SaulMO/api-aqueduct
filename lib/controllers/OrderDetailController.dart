import 'package:ventas_db/models/OrderDetailDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class OrderDetailController extends ResourceController {
  //La referencia a nuestra base de datos
  OrderDetailController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllOrderDetails() async {
    final orderDetailsQuery = Query<OrderDetailDAO>(context);
    final orderDetails = await orderDetailsQuery.fetch();
    return Response.ok(orderDetails);
  }

  @Operation.get('idDetail')
  Future<Response> getOrderDetail(@Bind.path('idDetail') int iddeta) async {
    final orderDetailQuery = Query<OrderDetailDAO>(context)
      ..where((p) => p.idDetail).equalTo(iddeta);
    final orderDetail = await orderDetailQuery.fetchOne();
    return orderDetail != null ? Response.ok(orderDetail) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addOrderDetail() async {
    final orderDetail = OrderDetailDAO()
      ..read(await request.body.decode(), ignore: ['idDetail']);
    final orderDetailQuery = Query<OrderDetailDAO>(context)
      ..values = orderDetail;
    final addOrderDetail = await orderDetailQuery.insert();
    return Response.ok(addOrderDetail);
  }

  @Operation.put('idDetail')
  Future<Response> updateOrderDetail(
      @Bind.path('idDetail') int idOrderDetail) async {
    final orderDetail = OrderDetailDAO()..read(await request.body.decode());
    final orderDetailQuery = Query<OrderDetailDAO>(context)
      ..where((x) => x.idDetail).equalTo(idOrderDetail)
      ..values = orderDetail;
    final updOrderDetail = await orderDetailQuery.update();
    return Response.ok(updOrderDetail);
  }

  @Operation.delete('idDetail')
  Future<Response> deleteOrderDetail(
      @Bind.path('idDetail') int idOrderDetail) async {
    final orderDetailQuery = Query<OrderDetailDAO>(context)
      ..where((x) => x.idDetail).equalTo(idOrderDetail);
    final delOrderDetail = await orderDetailQuery.delete();
    return Response.ok(delOrderDetail);
  }
}
