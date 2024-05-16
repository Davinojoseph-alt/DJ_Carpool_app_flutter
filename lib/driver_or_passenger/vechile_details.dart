import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/ride_user/ridelocation.dart';

class VechileDetails extends StatefulWidget {
  const VechileDetails({Key? key}) : super(key: key);

  @override
  State<VechileDetails> createState() => _VechileDetailsState();
}

class _VechileDetailsState extends State<VechileDetails> {
  String dropdownValue = 'SUV'; // Default dropdown value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vechile Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => RideGiverOrTaker()));
            // // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 45, 45, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       IconButton(
              //         icon: Icon(Icons.arrow_back),
              //         onPressed: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       RideGiverOrTaker())); // Navigate to the RideGiverOrTaker page
              //         },
              //       ),
              //       const SizedBox(
              //         width: 15,
              //       ),
              //       const Text(
              //         "Vechile Details",
              //         style: TextStyle(
              //           fontSize: 28,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ]),
              SizedBox(height: 1),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10), // Rounded edges
              //     color: Colors.green, // Divider color
              //   ),
              //   height: 5, // Thickness
              //   width: 300, // Adjust width as needed
              //   // margin:
              //   //     EdgeInsets.symmetric(vertical: 20), // Add margin for spacing
              // ),
              SizedBox(height: 20),
              Center(
                  child: Image.asset('assets/cardetails.jpg',
                      width: 200, height: 200)),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Row(children: [
                  Text(
                    'Car Type',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 30),
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['SUV', 'Sedan', 'Hatchback']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ]),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Manufacturing Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Model Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Model Year',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Vehicle Plate No',
                ),
              ),
              // SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'No of Seats',
                ),
              ),
              // SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Vehicle Color',
                ),
              ),
              SizedBox(height: 40),
              InkWell(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => CreateRidePage(
                //                 isDriver: null,
                //               )));
                //   // Add functionality when the container is tapped
                // },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 20.0), // Adjust this value as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
