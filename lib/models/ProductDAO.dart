import 'package:ventas_db/models/OrderDetailDAO.dart';
import 'package:ventas_db/ventas_db.dart';
import 'package:ventas_db/models/CategoryDAO.dart';

class ProductDAO extends ManagedObject<tblProduct> implements tblProduct {}

class tblProduct {
  //Todos los campos de la tabla
  @primaryKey
  int idProduct;
  @Column(unique: true)
  String nameProduct;

  double price;
  int stock;
  bool discontinued;

  @Relate(#fkcategory)
  CategoryDAO idCategory;

  ManagedSet<OrderDetailDAO> fkproduct;
}
