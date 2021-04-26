import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CycleItem extends StatelessWidget {
  final int cycle;
  final DateTime nowTime;
  final DateTime wakeUpTime;
  const CycleItem(
      {Key key,
      @required this.cycle,
      @required this.nowTime,
      @required this.wakeUpTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _formattedDate =
        timeEnToKo(DateFormat('yy/MM/dd a hh:mm').format(wakeUpTime));

    Duration _sleepingTime = wakeUpTime.difference(nowTime);
    String longTime = '낮잠';
    if (_sleepingTime > Duration(hours: 5)) {
      longTime = '잠';
    }
    String _stString =
        '[$longTime] ${_sleepingTime.inHours}시간 ${_sleepingTime.inMinutes % 60}분 동안 잡니다.';
    return Card(
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  cycle.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Text(
                  '사이클',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                )
              ],
            ),
            // VerticalDivider(
            //   width: 2,
            //   thickness: 2,
            //   color: Colors.white,
            // ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formattedDate,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    _stString,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
            Icon(Icons.alarm),
          ],
        ),
      ),
    );
  }

  static String timeEnToKo(String time) {
    time = time.replaceAll('AM', '오전');
    time = time.replaceAll('PM', '오후');
    return time;
  }
}