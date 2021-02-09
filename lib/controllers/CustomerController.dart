import 'package:ventas_db/models/CustomerDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class CustomerController extends ResourceController {
  //La referencia a nuestra base de datos
  CustomerController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCustomers() async {
    final customersQuery = Query<CustomerDAO>(context);
    final customers = await customersQuery.fetch();
    return Response.ok(customers);
  }

  @Operation.get('idCustomer')
  Future<Response> getCustomer(@Bind.path('idCustomer') int idcust) async {
    final customerQuery = Query<CustomerDAO>(context)
      ..where((p) => p.idCustomer).equalTo(idcust);
    final customer = await customerQuery.fetchOne();
    return customer != null ? Response.ok(customer) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addCustomer() async {
    final customer = CustomerDAO()
      ..read(await request.body.decode(), ignore: ['idCustomer']);
    final customerQuery = Query<CustomerDAO>(context)..values = customer;
    final addCustomer = await customerQuery.insert();
    return Response.ok(addCustomer);
  }

  @Operation.put('idCustomer')
  Future<Response> updateCustomer(
      @Bind.path('idCustomer') int idCustomer) async {
    final customer = CustomerDAO()..read(await request.body.decode());
    final customerQuery = Query<CustomerDAO>(context)
      ..where((x) => x.idCustomer).equalTo(idCustomer)
      ..values = customer;
    final updCustomer = await customerQuery.update();
    return Response.ok(updCustomer);
  }

  @Operation.delete('idCustomer')
  Future<Response> deleteCustomer(
      @Bind.path('idCustomer') int idCustomer) async {
    final customerQuery = Query<CustomerDAO>(context)
      ..where((x) => x.idCustomer).equalTo(idCustomer);
    final delCustomer = await customerQuery.delete();
    return Response.ok(delCustomer);
  }
}
