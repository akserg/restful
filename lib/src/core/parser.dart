//Copyright (C) 2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of core;

/**
 * Parse Dart instances and classes.
 */
class Parser {
  
  /**
   * Return iterable set of [InstanceMirror]'s by [instance].
   */
  Iterable<InstanceMirror> getClassAnnotations(instance) {
    ClassMirror clazz = reflect(instance).type;
    return _findClassAnnotations(clazz);
  }
  
  /**
   * Private [clazz] annotations iterator.
   */
  Iterable<InstanceMirror> _findClassAnnotations(ClassMirror clazz) {
    return clazz.metadata.where((InstanceMirror im) => 
        im.reflectee is ApplicationPath ||
        im.reflectee is Path
    );
  }
  
  /**
   * Return iterable set of method anotations if [instance].
   */
  Iterable<MethodMirror> getMethodAnnotations(instance) {
    ClassMirror clazz = reflect(instance).type;
    return _findMethodAnnotations(clazz);
  }
  
  /**
   * Private method annotations of [clazz] iterator.
   */
  Iterable<MethodMirror> _findMethodAnnotations(ClassMirror clazz) {
    return clazz.methods.values.where((MethodMirror mm) => 
      mm.metadata.any((InstanceMirror im) => 
        im.reflectee is Get ||
        im.reflectee is Post ||
        im.reflectee is Put ||
        im.reflectee is Delete ||
        im.reflectee is Path ||
        im.reflectee is Produces
      )
    );
  }
  
}