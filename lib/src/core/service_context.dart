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
  
  final Application application;
  
  ApplicationContext(Application this.application);
  
  bool process(HttpRequest request, String path) {
    print("Processing");
    HttpResponse response = request.response;
    response.write("Hello world");
    response.statusCode = HttpStatus.OK;
    response.close();
    return true;
  }
}