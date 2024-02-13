import 'package:flutter/material.dart';
import 'package:weather/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('اب و هوا',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(

        child: Pages(),

      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

          });

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),

      ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_sharp, size: 40), label: 'Weather'),
          BottomNavigationBarItem(
              icon: Icon(Icons.password_sharp, size: 40), label: 'Capcha'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 40), label: 'Login')
        ],
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        onTap:(value) {

          if(value==0&&value!=_selectedIndex){
            _selectedIndex=0;

          }
          else if(value==1&&value!=_selectedIndex){
            _selectedIndex=1;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Capcha();
            },));
          }
          else if(value==2&&value!=_selectedIndex)
          {
            _selectedIndex=2;
          }
          setState(() {

          });
        },
        currentIndex: _selectedIndex,
        //currentIndex: ,
      ),

    );
  }
}
