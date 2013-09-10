//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Contract for a provider that maps Java exceptions to {@link javax.ws.rs.core.Response}.
 */
abstract class ExceptionMapper<E extends RestException> {
  
  /**
   * Map an [RestException] to a [HttpResponse].
   */
  HttpResponse toResponse(E exception);
}