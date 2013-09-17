//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of rest_server;

/**
 * The value of a type or subtype wildcard.
 */
const String MEDIA_TYPE_WILDCARD = "*";

/**
 * A String representing wildcard media type.
 */
const String WILDCARD = "*/*";

/**
 * A MediaType representing [WILDCARD] media type.
 */
MediaType WILDCARD_TYPE = new MediaType();

/**
 * A String representing plain text media type.
 */
String TEXT_PLAIN = "text/plain";

/**
 * A MediaType representing plain text media type.
 */
MediaType TEXT_PLAIN_TYPE = new MediaType("text", "plain");

/**
 * An abstraction for a media type.
 */
class MediaType {
  
  final String type;
  final String subtype;
  
  /**
   * Creates a new instance of [MediaType]. 
   * By default [type] and [subtype] equal [MEDIA_TYPE_WILDCARD].
   */
  MediaType([String this.type = MEDIA_TYPE_WILDCARD, String this.subtype = MEDIA_TYPE_WILDCARD]);
  
  /**
   * Create MediaType from [mimeType] string.
   */
  factory MediaType.from(String mimeType) {
    new MediaType();
  }
}