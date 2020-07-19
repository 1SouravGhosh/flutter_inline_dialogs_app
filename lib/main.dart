import 'package:flutter/material.dart';
import 'package:flutter_inline_dialogs_app/custom_utils/service_locator.dart';
import 'package:flutter_inline_dialogs_app/dialogs/manager.dart';
import 'package:flutter_inline_dialogs_app/dialogs/model.dart';
import 'package:flutter_inline_dialogs_app/dialogs/service.dart';

void main() {
  dialogSetupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inline Dialogs Demo',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Inline Dialogs Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DialogService _dialogService = locator<DialogService>();
  Future<void> _incrementCounter() async {
    var _response = _dialogService.showDialog(
        title: Icon(
          Icons.watch_later,
          size: 40,
          color: Colors.green,
        ),
        content: Text("$_counter"),
        dialogType: DialogType.option,
        optionLeft: "Left",
        optionRight: "Right",
        buttonText: "Close");
    setState(() {
      _counter++;
    });
//    await Future.delayed(Duration(seconds: 3));
    _response.then((value) => debugPrint("${value.optionRight}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
