import 'package:flutter/material.dart';
import 'package:flutter_app/test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '수면 계산기 - 수면 사이클',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          backgroundColor: Color(0xffF7E600),
          centerTitle: false,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.black,
            indicator: BoxDecoration(color: Colors.white),
            tabs: [
              Tab(
                icon: Icon(Icons.nightlight_round),
                text: '지금 잠들면?',
              ),
              Tab(icon: Icon(Icons.schedule), text: '알람'),
              Tab(
                icon: Icon(Icons.more_horiz),
                text: '기타',
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          children: [
            screen1(),
            screen1(),
            screen1(),
          ],
          controller: _tabController,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _refresh,
          tooltip: 'Increment',
          child: Icon(Icons.update),
        ));
  }

  Widget screen1() {
    DateTime _tempTime = DateTime.now();
    String _formattedDate = DateFormat('kk:mm').format(_tempTime);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                StyledText(
                    text: '만약 <bold>${_formattedDate}</bold>에 잠들면',
                    styles: {
                      'bold': TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.black)
                    },
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                Text(
                  '시에 일어나야 합니다.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            alignment: Alignment.topLeft,
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'Cycle',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        VerticalDivider(
                            thickness: 30, width: 50, color: Colors.grey),
                        Column(
                          children: [
                            Text(
                              'This Section',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
