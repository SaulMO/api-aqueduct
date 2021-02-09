import 'package:ventas_db/models/ProductDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class CategoryDAO extends ManagedObject<tblCategory> implements tblCategory {}

class tblCategory {
  //Todos los campos de la tabla
  @primaryKey
  int idCategory;

  @Column(unique: true)
  String nameCategory;

  //Indica que se manda la llave primaria 1:M, es decir uno a muchos
  ManagedSet<ProductDAO> fkcategory;
}
