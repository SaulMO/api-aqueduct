import 'package:ventas_db/models/OrderDetailDAO.dart';
import 'package:ventas_db/ventas_db.dart';
import 'package:ventas_db/models/CustomerDAO.dart';

class OrderDAO extends ManagedObject<tblOrder> implements tblOrder {}

class tblOrder {
  //Todos los campos de la tabla
  @primaryKey
  int idOrder;
  @Column(indexed: true)
  DateTime dateOrder;
  @Column(indexed: true)
  DateTime shippedDate;

  @Relate(#fkcustomer)
  CustomerDAO idCustomer;

  ManagedSet<OrderDetailDAO> fkorder;
}
