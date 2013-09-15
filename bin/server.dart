import "dart:io";

import 'package:restful/restful.dart';
import 'shoping_application.dart';

main() {
//  RestRuntime rest = new RestRuntime();
//  rest.register([new ShoppingApllication()]);

	String host = "127.0.0.1";
	int port = 8080;
  
  HttpServer.bind(host, port).then((server) {
  	print("Server runs on [${host}:${port}]");
  	print("To stop server press CTRL + C");
    // Create new rest runtime
    RestRuntime rest = new RestRuntime();
    // register all applications
    rest.register([new ShoppingApllication()]);
    // Start listenning
    server.listen((HttpRequest request) {
      // Process REST services 
      if (!rest.service(request)) {
        // Process other type of requests or resources 
        final Uri uri = request.uri;
        if (!uri.isAbsolute) {
          final String stringPath = uri.path == '/' ? 'index.html' : uri.path;
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
        request.response.write("<h1>Error</h1><p>404 - Resource not found</p>");
        request.response.statusCode = HttpStatus.NOT_FOUND;
        request.response.close();
      };
    });
  });
}