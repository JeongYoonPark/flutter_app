import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';
import 'package:flutter_app/widget/cycle_item.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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
            alarm(),
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
    String _formattedDate =
        CycleItem.timeEnToKo(DateFormat('kk:mm').format(_tempTime));
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                StyledText(
                    text: '만약 <bold>$_formattedDate</bold>에 잠들면',
                    styles: {
                      'bold': TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.black)
                    },
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)),
              ],
            ),
            color: Color.fromRGBO(0, 0, 197, 0.3),
            alignment: Alignment.topLeft,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                DateTime wakeUpTime = _tempTime.add(
                    Duration(hours: 1, minutes: 44) +
                        Duration(hours: 1, minutes: 30) * index);
                return CycleItem(
                  cycle: index + 1,
                  nowTime: _tempTime,
                  wakeUpTime: wakeUpTime,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget alarm() {
    return Container(
        child: Column(
          children: [
            Container(
              child: time_picker(),
            )
          ],
    ));
  }
  Widget time_picker() {
    DateTime _dateTime = new DateTime.now();
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(
        fontSize: 24,
        color: Colors.grey
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 24,
        color: Colors.black
      ),
      spacing: 50,
      itemHeight: 80,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
