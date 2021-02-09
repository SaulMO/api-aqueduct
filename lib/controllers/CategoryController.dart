import 'package:ventas_db/helpers/config.dart';
import 'package:ventas_db/models/CategoryDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class CategoryController extends ResourceController {
  //La referencia a nuestra base de datos
  CategoryController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCategories(
      @Bind.header("authorization") String authHeader) async {
    if (!Properties.isAuthorized(authHeader)) {
      return Response.forbidden();
    }
    final categoriesQuery = Query<CategoryDAO>(context);
    final categories = await categoriesQuery.fetch();
    return Response.ok(categories);
  }

  @Operation.get('idCategory')
  Future<Response> getCategory(@Bind.path('idCategory') int idcatego) async {
    final categoryQuery = Query<CategoryDAO>(context)
      ..where((p) => p.idCategory).equalTo(idcatego);
    final category = await categoryQuery.fetchOne();
    return category != null ? Response.ok(category) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addCategory() async {
    final category = CategoryDAO()
      ..read(await request.body.decode(), ignore: ['idCategory']);
    final categoryQuery = Query<CategoryDAO>(context)..values = category;
    final addCategory = await categoryQuery.insert();
    return Response.ok(addCategory);
  }

  @Operation.put('idCategory')
  Future<Response> updateCategory(
      @Bind.path('idCategory') int idCategory) async {
    final category = CategoryDAO()..read(await request.body.decode());
    final categoryQuery = Query<CategoryDAO>(context)
      ..where((x) => x.idCategory).equalTo(idCategory)
      ..values = category;
    final updCategory = await categoryQuery.update();
    return Response.ok(updCategory);
  }

  @Operation.delete('idCategory')
  Future<Response> deleteCategory(
      @Bind.path('idCategory') int idCategory) async {
    final categoryQuery = Query<CategoryDAO>(context)
      ..where((x) => x.idCategory).equalTo(idCategory);
    final delCategory = await categoryQuery.delete();
    return Response.ok(delCategory);
  }
}
