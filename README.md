#Restful

Restful is a library built specifically to enable you to build correct REST web services on Dart.

* [Home](https://github.com/akserg/restful)
* [Issues](https://github.com/akserg/restful/issues)

##License
Copyright (c) 2013 Sergey Akopkokhyants Licensed under the Apache 2.0 License.

### URL specification
URL is a specific character string that constitutes a reference to an internet resouirce:
[sheme] :// [domain] : [port] / [path] ? [queryString] # [fragmentIdentifier] 

### REST annotations
- DELETE
- GET
- HEAD
- PUT
- POST
- ApplicationPath(path)
- Path(path)
- PathParam(param)
- Produces(value)

### Application vs. Services

The main concept of Restful is that developer might implement set of applications to process client requests splitted by reachable path. Main role here play Application and Services.    

### Application
Application is the class the list all Services. Aplication could be annotated with [ApplicationPath] specifying resource to access to all services located underneath application path.
Application class is abstract so inherited class must add instantiated services to set.
 
<pre class="syntax brush-javascript">
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
</pre>

### Service
Service is a class processing all requests underneath [Application path]. Service class could be annotated with [Path] annotation.
If [Path] exists on both the class and method, the relative path to the resource method is a concatenation of the class and method.

<pre class="syntax brush-javascript">
/**
 * Customer service process REST request to 
 * ['{path_application_resource}/customers].
 */
@Path("/customers")
class CustomerService {

  Map<int, Customer> _customerDB = new Map<int, Customer>();
  int _idCounter = 1;
  
  /**
   * Return customer as string by specified [id].
   */
  @GET
  @Path("/user/{id}")
  @Produces("text/plain")
  String getCustomerString(@PathParam("id") int id) {
    Customer customer = _customerDB[id];
    if (customer == null) {
      throw new RestException(HttpStatus.NOT_FOUND);
    }
    return customer.toString();
  }
}
</pre>

### Service method vs. Resource
Each public method of Service annotated with [REST annotations] will to map to certain kind of HTTP method.
If class has [Path] annotation then method doesn't need to have a [Path] annotation you are mapping. 
You can have more than one HTTP method as long as they can be distinguished from other methods.

<pre class="syntax brush-javascript">
...
  /**
   * Return customer as string by specified [id].
   */
  @GET
  @Path("/user/{id}")
  @Produces("text/plain")
  String getCustomerString(@PathParam("id") int id) {
    Customer customer = _customerDB[id];
    if (customer == null) {
      throw new RestException(HttpStatus.NOT_FOUND);
    }
    return customer.toString();
  }
...
</pre>

### Path annotation
The [Path] could have a simple path. It doesn't support regular expressions yet.

### PathParam annotation
The parameter annotation [PathParam] allows developer to map variable URI path fragments into method call.
[PathParam] doesn't support regular expressions yet.

<pre class="syntax brush-javascript">
...
  @GET
  @Path("/book/{isbn}")
  String getBook(@PathParam("isbn") String id) {
    // search my database and get a string representation and return it
  }
...
</pre>

### PathSegment annotations
The [PathSegment] is set of matrix parameters described as an arbitrary set of name-value pairs embedded in a uri path segment.
Not implemented yet. 

### QueryParam annotation
The [QueryParam] annotation allows map a URI query string parameter or url form encoded parameter to method invocation.

<pre class="syntax brush-javascript">
GET /books?num=5
</pre>

<pre class="syntax brush-javascript">
...
  @GET
  String getBooks(@QueryParam("num") int num) {
  ...
  }
...
</pre>

### HeaderParam annotation
The header parameter annotation [HeaderParam] allows developer to map a request HTTP header to method invocation.
[HeaderParam] doesn't support regular expressions yet.

<pre class="syntax brush-javascript">
GET /books?num=5
</pre>

<pre class="syntax brush-javascript">
...
  @GET
  String getBooks(@HeaderParam("From") String from) {
    // search my database and get a string representation and return it
  }
...
</pre>
