import 'package:ventas_db/helpers/config.dart';
import 'package:ventas_db/models/ProductDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class ProductController extends ResourceController {
  //La referencia a nuestra base de datos
  ProductController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllProducts(
      @Bind.header("authorization") String authHeader) async {
    if (!Properties.isAuthorized(authHeader)) {
      return Response.forbidden();
    }
    final productsQuery = Query<ProductDAO>(context);
    final products = await productsQuery.fetch();
    return Response.ok(products);
  }

  @Operation.get('idProduct')
  Future<Response> getProductByID(@Bind.path('idProduct') int idprod) async {
    final productQuery = Query<ProductDAO>(context)
      ..where((p) => p.idProduct).equalTo(idprod);
    final product = await productQuery.fetchOne();
    return (product == null) ? Response.notFound() : Response.ok(product);
  }

  @Operation.post()
  Future<Response> addProduct() async {
    final product = ProductDAO()
      ..read(await request.body.decode(), ignore: ['idProduct']);
    final productQuery = Query<ProductDAO>(context)..values = product;
    final addProduct = await productQuery.insert();
    return Response.ok(addProduct);
  }

  @Operation.put('idProduct')
  Future<Response> updateProduct(@Bind.path('idProduct') int idProduct) async {
    final product = ProductDAO()..read(await request.body.decode());
    final productQuery = Query<ProductDAO>(context)
      ..where((x) => x.idProduct).equalTo(idProduct)
      ..values = product;
    final updProduct = await productQuery.update();
    return Response.ok(updProduct);
  }

  @Operation.delete('idProduct')
  Future<Response> deleteProduct(@Bind.path('idProduct') int idProduct) async {
    final productQuery = Query<ProductDAO>(context)
      ..where((x) => x.idProduct).equalTo(idProduct);
    final delProduct = await productQuery.delete();
    return Response.ok(delProduct);
  }
}
