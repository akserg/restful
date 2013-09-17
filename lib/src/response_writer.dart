//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * Class helps write result into [HttpResponse]. 
 */
class ResponseWriter {
  
  /**
   * Write [result] into [HttpResponse] by produces value of [resource].
   */
  void write(HttpRequest request, Resource resource, dynamic result) {
    throw new Exception("Not implemented yet");
  }
}