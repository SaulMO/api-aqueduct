import 'package:ventas_db/models/OrderDAO.dart';
import 'package:ventas_db/ventas_db.dart';

class CustomerDAO extends ManagedObject<tblCustomer> implements tblCustomer {}

class tblCustomer {
  //Todos los campos de la tabla
  @primaryKey
  int idCustomer;

  String nameCustomer;
  String addCustomer;

  @Column(unique: true)
  String emailCustomer;
  String phoneCustomer;

  ManagedSet<OrderDAO> fkcustomer; //1:M -> OrdersDAO
}
