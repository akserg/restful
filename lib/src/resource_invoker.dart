//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * Class helps invoke [Resource].
 */
class ResourceInvoker {
  
  /**
   * Invoke [resource] with [request] info and return result of invocation.
   */
  dynamic invoke(HttpRequest request, Resource resource) {
    throw new Exception("Not implemented yet");
  }
}

/**
 * Class [Entity] using by [ResourceInvoker] to public result in [HttpResponse]. 
 */
class Entity<T> {
  
  final MediaType mediaType;
  final T object;
  
  /**
   * Create new [Entity] contains [object] convertable to specified [mediaType].
   */
  Entity(this.mediaType, this.object);
}