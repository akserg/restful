//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Context shared by message body interceptors that can be used to wrap
 * calls to [MessageBodyReader.readFrom] and [MessageBodyWriter.writeTo]. 
 * The getters and setters in this context class correspond to the parameters in
 * the aforementioned methods.
 */
class ApplicationContext {

	/**
	 * Reference to Application
	 */  
  final Application application;
  
  /**
   * Specified application path.
   */
  String applicationPath = "";
  
  /**
   * Map of ServiceContext's
   */
  final Map<String, ServiceContext> _serviceContexts = new Map<String, ServiceContext>();
  
  /**
   * Create an instance of ApplicationContext to wrap [Application].
   */
  ApplicationContext(Application this.application);
  
  /**
   * Register [ServiceContext].
   */
  void register(ServiceContext serviceContext) {
    assert(serviceContext != null);
    if (_serviceContexts.containsKey(serviceContext.servicePath)) {
      throw new Exception("Service for ${serviceContext.servicePath} exists");
    } else {
      _serviceContexts[applicationPath + serviceContext.servicePath] = serviceContext;
    }
  }
  
  /**
   * Service HttpRequest [request] with [uri].
   */
  bool service(String method, HttpRequest request) {
    _serviceContexts.keys.forEach((String servicePath){
      if (request.uri.path.startsWith(servicePath)) {
        ServiceContext serviceContext = _serviceContexts[servicePath];
        return serviceContext.service(method, servicePath, request);
      }
    });
    return false;
  }
}