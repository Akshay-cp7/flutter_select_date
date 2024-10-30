import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  void _goToNextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  void _goToPreviousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dayString = DateFormat('EEEE').format(selectedDate);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              profileContainer(),
              greySpace(),
              dateSelect(dayString),
              Flexible(
                flex: 10,
                child: gridContainers(),
              ),
              Flexible(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Row dateSelect(String day) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: _goToPreviousDay,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
              size: 25,
            ),
          ),
        ),
        SizedBox(
          height: 80,
          child: Center(
            child: GestureDetector(
              onTap: _pickDate,
              child: Row(
                children: [
                  Text(
                    '$day  ',
                    style:
                        const TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: _goToNextDay,
            icon: const Icon(
              Icons.arrow_forward,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  Container greySpace() {
    return Container(
      color: const Color.fromARGB(255, 223, 223, 223),
      height: 5,
    );
  }

  Container profileContainer() {
    return Container(
      alignment: Alignment.center,
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        title: Text(
          'Akshay C P',
          style: TextStyle(color: Color.fromARGB(255, 16, 93, 156)),
        ),
        subtitle: Text(
          'ERP Developer',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Image(image: AssetImage('assets/images/logo_fk.png')),
      ),
    );
  }

  Widget gridContainers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          Color containerColor;
          if (index == 0) {
            containerColor = Colors.green;
          } else if (index == 1) {
            containerColor = Colors.blue;
          } else if (index == 2) {
            containerColor = Colors.red;
          } else {
            containerColor = Colors.grey;
          }

          return Container(
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.2,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              index.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
