//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * Class helps parse and resolver [HttpRequest]. 
 */
class RequestResolver {
  
  /**
   * Find resource processing request by accepted criterias.
   */
  Resource resolve(HttpRequest request, Map<Resource, Resource> resources) {
    throw new Exception("Not implemented yet");
  }
}