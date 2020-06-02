import 'package:flutter/material.dart';
import 'package:flutter_list_pro/flutter_list_pro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your applicatioss
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView as carousel DEMO ',
      home: MyHomePage(title: 'ListView as carousel DEMO'),
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
  final List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ScrollHandler(
              scrollController: _scrollController,
              scrollThreshold: 200,
              child: Container(
               margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController, // controller must to be added 
                    itemCount: numbers.length,
                    
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 24.0),
                        width: 250,
                        child: Card(
                          color: Colors.blue,
                          child: Container(
                            child: Center(
                                child: Text(
                              numbers[index].toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 36.0),
                            )),
                          ),
                        ),
                      );
                    }),
              )),
        ));
  }
}