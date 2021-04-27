import 'package:android_alarm_manager/android_alarm_manager.dart';

class AlarmManager {
  Future<bool> setAlarm(int alarmID, DateTime setTime) async {
    DateTime _now = DateTime.now();
    Duration _differenceTimes = setTime.difference(_now);

    try {
      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.periodic(_differenceTimes, alarmID, startAlarm);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelAlarm(int alarmID) async {
    try {
      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.cancel(alarmID);
      return true;
    } catch (e) {
      return false;
    }
  }
  void startAlarm() {
  
  }
}