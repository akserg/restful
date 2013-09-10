//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Exception thrown when an expected case happed in REST services.
 */
class RestException extends HttpException {

  /**
   * HttpStatus
   */
  final int status;
  
  /**
   * Creates a new RestException with an http [status] and optional error 
   * [message] and [uri] .
   */
  const RestException(int this.status, {String message, Uri uri}) : super(message, uri:uri);
}