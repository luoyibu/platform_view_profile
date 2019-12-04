import 'package:flutter/material.dart';
import 'uiview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _poiList = [
    'sdfweg',
    'sdfweg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: _buildListView(context),
            ),
          ),
          _buildBottomBar(context),
        ],
      )
    );
  }

  Widget _buildListView(BuildContext context) {

    return ListView.separated(
      itemCount: _poiList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 1, color: Colors.grey,);
      },
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 65,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Text(index.toString() + ' ' + _poiList[index]),
              Container(
                width: 100,
                height: 15,
                padding: EdgeInsets.only(left: 20),
                child: UIView(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: FlatButton(
              child: Text('add item', style: TextStyle(fontSize: 16),),
              onPressed: onAddItemClicked,
            ),
            width: 150,
          ),
          Container(
            child: FlatButton(
              child: Text('delete item', style: TextStyle(fontSize: 16),),
              onPressed: onDeleteItemClick,
            ),
            width: 150,
          ),
        ],
      ),
    );
  }

  void onAddItemClicked() {
    setState(() {
      _poiList.add('sdfweg');
    });
  }

  void onDeleteItemClick() {
    setState(() {
      _poiList.removeLast();
    });
  }
}
