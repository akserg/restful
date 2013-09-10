import "dart:io";

import 'package:restful/restful.dart';
import 'shoping_application.dart';

main() {
//  RestRuntime runtime = new RestRuntime();
//  runtime.register([new ShoppingApllication()]);

	String host = "127.0.0.1";
	String port = 8080;
  
  HttpServer.bind(host, port).then((server) {
  	print("Server starts on host ${host} and port ${port}");
  	print("To stop server press CTRL + C");
    // Create new runtime
    RestRuntime runtime = new RestRuntime();
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
        request.response.write("404. Not found.");
        request.response.statusCode = HttpStatus.NOT_FOUND;
        request.response.close();
      };
    });
  });
}