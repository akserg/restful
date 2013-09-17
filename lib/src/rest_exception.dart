//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * Exception thrown when some thing expected happes in REST Server.
 */
class RestException implements Exception {

  final message;

  RestException([this.message]);

  String toString() {
    if (message == null) return "REST Exception";
    return "REST Exception: $message";
  }
}