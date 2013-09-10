part of shoping_application;

/**
 * Customer service process REST request to 
 * ['{path_application_resource}/customers].
 */
@Path("/customers")
class CustomerService {

  Map<int, Customer> _customerDB = new Map<int, Customer>();
  int _idCounter = 1;
  
  /**
   * Return customer as string by specied [id].
   */
  @GET
  @Path("{id}")
  @Produces("text/plain")
  String getCustomerString(@PathParam("id") int id) {
    Customer customer = _customerDB[id];
    if (customer == null) {
      throw new RestException(HttpStatus.NOT_FOUND);
    }
    return customer.toString();
  }
}