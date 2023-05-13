import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:progress_manager/progress_manager.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MainApp')),
      body: LoaderOverlay(
        overlayWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            const Center(
              child: Text('MainApp'),
            ),
            IconButton(
                onPressed: () => getRequest(),
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }

  getRequest() async {
    /// Show the loader before the request
    LoaderProvider().increment();

    /// Simulate a request and decrement the loader
    await Future.delayed(const Duration(seconds: 2), () {})
        .then((value) => LoaderProvider().decrement());
  }
}
