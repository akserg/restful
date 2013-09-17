//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * REST server class.
 */
class RestServer {
  
  /**
   * [RequestResolver] instance.
   */
  final RequestResolver requestResolver = new RequestResolver();
  
  /**
   * [ResourceParser] instance.
   */
  final ResourceParser resourceParser = new ResourceParser();
  
  /**
   * [ResourceInvoker] instance.
   */
  final ResourceInvoker resourceInvoker = new ResourceInvoker();
  
  /**
   * [ResponseWriter] instance.
   */
  final ResponseWriter responseWriter = new ResponseWriter();
  
  /**
   * Set of REST resources.
   */
  final Set<Resource> resources = new Set<Resource>();
  
  /**
   * Create an instance of REST Server and initialise with set of [resources].
   */
  RestServer(List resources) {
    logger.info("Starting REST Server");
    assert(resources != null);
    _initialise(resources);
  }
  
  /**
   * Initialise REST Server with [instances]
   */
  void _initialise(List instances) {
    resources.addAll(resourceParser.parse(instances));
  }
  
  /**
   * Process [request]. 
   */
  service(HttpRequest request) {
    logger.fine("Service ${request.method} on ${request.uri.path}");
    // Find resource to process request's path
    Resource resource = requestResolver.resolve(request, resources);
    // Invoke resource's method
    dynamic result = resourceInvoker.invoke(request, resource);
    // Write result back to response
    responseWriter.write(request, resource, result);
  }
}