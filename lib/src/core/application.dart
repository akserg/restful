//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Configurable application class defines Rest services. 
 */
abstract class Application {
  
  /**
   * Set of services
   */
  Set get services => new Set();
  
  void process(HttpRequest request) {
    
  }
}