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
  Resource resolve(HttpRequest request, Set<Resource> resources) {
    Resource foundResource;
    // Pass through all resources
    resources.any((Resource resource){
      // Check the path
      if (_checkPath(request.uri, resource.path)) {
        // Check the method
        if (request.method == resource.method) {
          //
          // Get accepted Response mime type from Header
          List<MediaType> mediaTypes = _getMediaType(request);
          // Check the produces
          if (_checkMediaType(mediaTypes, resource.produces)) {
            foundResource = resource;
            return true;
          }
        }
      }
      return false;
    });
    //
    if (foundResource != null) {
      return foundResource;
    } else {
      throw new RestException("Resource not found");
    }
  }
  
  /**
   * Get [request] MediaType.
   */
  List<MediaType> _getMediaType(HttpRequest request) {
    String acceptMimeType = request.headers.value(HttpHeaders.ACCEPT);
    if (acceptMimeType == null || acceptMimeType.isEmpty) {
      return [WILDCARD_TYPE];    
    } else {
      List<MediaType> mediaTypes = [];
      acceptMimeType.split(",").forEach((String mime){
        mediaTypes.add(new MediaType.from(mime));
      });
      return mediaTypes;
    }
  }
  
  /**
   * Check is path accepts
   */
  bool _checkPath(Uri uri, String path) {
    // TODO: Must be more sofisticated implementation
    return uri.path.startsWith(path);
  }
  
  /**
   * Check is media type accepts
   */
  bool _checkMediaType(List<MediaType> mediaTypes, MediaType resourceMediaType) {
    return mediaTypes.any((MediaType mediaType){
      if (mediaType.toString().startsWith(resourceMediaType.toString())) {
        // One of acceptable media formats supported by Resource method
        return true;
      }
      return false;
    });
  }
}