import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> with AutomaticKeepAliveClientMixin{
  Position? position;
  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await getCurrentPosition();
  }

  getCurrentPosition() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((val) {
      setState(() {
        position = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('출퇴근 시간 입력'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    getCurrentPosition();
                  },
                  child: const Text('현재 위치 가져오기')),
              position != null
                  ? Text(position!.longitude.toString())
                  : const Text('위치를 가져오는 중입니다.'),
              position != null
                  ? Text(position!.latitude.toString())
                  : const CircularProgressIndicator(),
              const Spacer(),
              startTime != null ? Text('출근시간 : ${startTime!.hour}시 ${startTime!.minute}분 ${startTime!.second}초') : const Text('출근 전입니다.'),
              endTime != null ? Text('퇴근시간 : ${endTime!.hour}시 ${endTime!.minute}분 ${endTime!.second}초') : const Text('퇴근 전입니다.'),
              const Spacer(),
              position != null && position!.longitude > 127.135 && position!.longitude < 127.136 ? Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          startTime = DateTime.now();
                        });
                      },
                      child: attendanceButton(Colors.blue, '출근'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          endTime = DateTime.now();
                        });
                      },
                       child: attendanceButton(Colors.green, '퇴근')
                    ),
                  ),

                ],
              ) : const Text('근무지 내에서만 출퇴근 입력이 가능합니다.')
            ],
          ),
        ));
  }

  attendanceButton(color, String title) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 4, right: 4, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        alignment: Alignment.center,
        height: 100,
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
