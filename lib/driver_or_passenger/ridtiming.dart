import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/ride_user/Matchedrides.dart';
import 'package:my_app/ride_user/createride_database.dart';

class RideTimingPage extends StatefulWidget {
  final String rideId;
  final String userId;
  final bool isDriver;

  RideTimingPage(
      {required this.rideId, required this.userId, required this.isDriver});

  @override
  _RideTimingPageState createState() => _RideTimingPageState();
}

class _RideTimingPageState extends State<RideTimingPage> {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  CreateRideDatabase _rideDatabase = CreateRideDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 45, 35, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              'Set Your Ride Timings',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 5,
              width: 100,
            ),
            SizedBox(height: 30),
            Text(
              'You can reschedule it anytime',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            // time picker
            buildTimePickerButton(
              'Starting time',
              selectedStartTime,
              (TimeOfDay? newTime) {
                setState(() {
                  selectedStartTime = newTime;
                });
              },
            ),
            SizedBox(height: 40),
            buildTimePickerButton(
              'Return time',
              selectedEndTime,
              (TimeOfDay? newTime) {
                setState(() {
                  selectedEndTime = newTime;
                });
              },
            ),
            SizedBox(height: 40),
            SizedBox(height: 30),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  saveRideTiming();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateMatchesridePage(isDriver: widget.isDriver)),
                  );
                },
                child: Text('CONTINUE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimePickerButton(
    String label,
    TimeOfDay? selectedTime,
    ValueChanged<TimeOfDay?> onChanged,
  ) {
    return InkWell(
      onTap: () {
        _selectTime(context, selectedTime, onChanged);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              selectedTime != null ? _formatTime(selectedTime) : 'Select Time',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(
    BuildContext context,
    TimeOfDay? initialTime,
    ValueChanged<TimeOfDay?> onChanged,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != initialTime) {
      onChanged(pickedTime);
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    return DateFormat('hh:mm a')
        .format(DateTime(2022, 1, 1, time.hour, time.minute));
  }

  void saveRideTiming() async {
    if (widget.rideId.isNotEmpty &&
        selectedStartTime != null &&
        selectedEndTime != null) {
      await _rideDatabase.updateRideTiming(
        widget.userId,
        widget.rideId,
        _formatTime(selectedStartTime),
        _formatTime(selectedEndTime),
        widget.isDriver ?? true,
      );
    }
  }
}
