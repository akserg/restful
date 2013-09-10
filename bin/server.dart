import "dart:io";

import 'package:restful/restful.dart';
import 'shoping_application.dart';

main() {
  HttpServer.bind('127.0.0.1', 8080).then((server) {
    // Create new runtime
    RuntimeDelegate runtime = new RuntimeDelegate();
    // register all applications
    runtime.register([new ShoppingApllication()]);
    // Start listenning
    server.listen((HttpRequest request) {
      // Process REST services 
      if (!runtime.process(request)) {
        // Process other type of requests or resources 
        final Uri uri = request.uri;
        if (!uri.isAbsolute) {
          final String stringPath = uri.path == '/' ? '/index.html' : uri.path;
          final File file = new File(stringPath);
          file.exists().then((bool found) {
            if (found) {
              file.openRead()
                .pipe(request.response)
                .catchError((e) { });
              return;
            };
          });
        }
        // Nothing found or url incorrect
        request.response.statusCode = HttpStatus.NOT_FOUND;
        request.response.close();
      };
    });
  });
}