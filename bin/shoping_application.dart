library shoping_application;

import "dart:io";
import 'package:restful/restful.dart';

part 'shoping_service.dart';
part 'customer.dart';

/**
 * Rest based shopping application.
 * All resources of that application under [/resource].  
 */
@ApplicationPath("/resource")
class ShoppingApllication extends Application {
  
  /**
   * Return set of services.
   */
  Set get services => new Set.from([
    new CustomerService()                                  
  ]);
}