import 'package:flutter/material.dart';

class PayAgent extends StatefulWidget {
  const PayAgent({Key? key}) : super(key: key);

  @override
  State<PayAgent> createState() => _PayAgentState();
}

class _PayAgentState extends State<PayAgent> {
  String dropdownValue1 = 'Features';
  String dropdownValue2 = 'How We Work';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.only(left: 160, right: 160),
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.white,
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('images/pay.png'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff022F40),
                        minimumSize: const Size(100, 50),
                        maximumSize: const Size(200, 50)),
                    onPressed: () {},
                    child: const Text('Home'),
                  ),
                  SizedBox(width: 20),
                  DropdownButton(
                    value: dropdownValue1,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 20,
                    style: const TextStyle(color: Color(0xff022F40)),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                    },
                    items: <String>['Features', 'How We Work']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20),
                  DropdownButton(
                    value: dropdownValue2,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 20,
                    style: const TextStyle(color: Color(0xff022F40)),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: <String>['How We Work', 'Features']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'ContactUs',
                      style: TextStyle(color: Color(0xff022F40)),
                    ),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Color(0xff022F40)),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
