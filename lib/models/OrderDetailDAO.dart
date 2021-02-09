import 'package:ventas_db/ventas_db.dart';
import 'package:ventas_db/models/OrderDAO.dart';
import 'package:ventas_db/models/ProductDAO.dart';

class OrderDetailDAO extends ManagedObject<tblOrderDetail>
    implements tblOrderDetail {}

class tblOrderDetail {
  //Todos los campos de la tabla
  @primaryKey
  int idDetail;

  double price;
  double discount;
  int quantity;

  @Relate(#fkorder)
  OrderDAO idOrder;

  @Relate(#fkproduct)
  ProductDAO idProduct;
}
