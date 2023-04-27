A progress management tool where you can manage your progress by pushing and pulling on a stack

## Features

Customizable progress widget and progress state management

## Getting started

Makes it easy to manage progress on multiple api calls

## Usage

First, wrap your whole project with ProgressManager. Make any customizations you want. Call LoaderProvider().increment() 
before the api calls, and LoaderProvider().decrement after the api calls result. This stacks your Progress and shows progress 
if the stack is greater than 1. If the stack drops to 0 or below, the progress disappears. This simplifies your progress management 
on multiple api calls. Also, using it without context will make it easier for you to use it in the bloc layer.


```dart
class YourApp extends StatelessWidget {
  const YourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      /// Wait for build to complete
      fetchData();
      fetchDataOther();
    });
    return MultiBlocProvider(
      providers: providers(),
      child: MaterialApp(
        /// This is where you wrap your whole project with ProgressManager
        home: const ProgressManager(
          child: HomeView(),
        ),
      ),
    );
  }
}

Future<List<Station>?> fetchData() async {
  LoaderProvider().increment();
  final response = await _dioClient.get(_getDataPath);
  if (response.statusCode == 200) {
    var list = (response.data as List).map((e) => Data.fromJson(e)).toList();
    LoaderProvider().decrement(); // if you want to decrement the stack
    return list;
  } else {
    LoaderProvider().decrement(); // if you want to decrement the stack
    throw Exception('Failed to load data');
  }
  /// Warning: When you increase it, you should decrease it when the call ends. Otherwise you will see progress forever
}

Future<List<Station>?> fetchDataOther() async {
    LoaderProvider().increment();
    final response = await _dioClient.get(_getDataPathOther);
    if (response.statusCode == 200) {
        var list = (response.data as List).map((e) => Data.fromJson(e)).toList();
        LoaderProvider().increment(); // if you want to decrement the stack
        return list;
    } else {
        LoaderProvider().decrement(); // if you want to decrement the stack
        throw Exception('Failed to load data');
    }
}

```

## Additional information

mertyasarerkocc@gmail.com