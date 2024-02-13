import 'package:flutter/material.dart';
import 'package:weather/get_data.dart';
import 'package:weather/weather.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() {
    return _PagesState();
  }
}

class _PagesState extends State<Pages> {
  late Future<CurrentWeather> wtr;

  TextEditingController cityCntrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wtr = Data.getWeather('Amol');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<CurrentWeather>(
            future: wtr,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Image.network('https://openweathermap.org/img/wn/${snapshot.data?.weather![0].icon!}.png');
                //return Text('${snapshot.data!.weather?[0].description}');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.network(
                        'https://openweathermap.org/img/wn/${snapshot.data?.weather![0].icon!}.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('${snapshot.data?.weather![0].description!}',
                        style: const TextStyle(fontSize: 30),
                        textDirection: TextDirection.rtl),
                    const SizedBox(
                      width: 30,
                    ),
                    Text('${snapshot.data?.weather![0].main!}',
                        style: const TextStyle(fontSize: 30),
                        textDirection: TextDirection.rtl),
                    const SizedBox(
                      width: 10,
                    ),
                    //ImageIcon(Image.network('https://openweathermap.org/img/wn/${snapshot.data?.weather![0].icon!}.png') as ImageProvider<Object>?,size: 10)       ,
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),


          FutureBuilder<CurrentWeather>(
            future: wtr,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: RichText(
                        text:  TextSpan(
                          style: const TextStyle(color: Colors.black, fontSize: 20,),
                          text: '',
                          children: <TextSpan>[
                            const TextSpan(text: '   '),
                            const TextSpan(text: 'دما هوا: '),
                            TextSpan(text: '${snapshot.data?.main?.temp!}',style: const TextStyle(color: Colors.purple),),
                            const TextSpan(text: '   سرعت باد: '),
                            TextSpan(text: '${snapshot.data?.wind?.speed!}',style: const TextStyle(color: Colors.purple),),
                            const TextSpan(text: '   مقدار باران: '),
                            TextSpan(text: '${snapshot.data?.rain?.d1h??0}',style: const TextStyle(color: Colors.purple),),
                          ],
                        ),
                      ),
                    )
                        ],
                );
              } else {
                return const CircularProgressIndicator(color: Colors.red,);
              }
            },
          ),

          const SizedBox(height: 30,),

          FutureBuilder<CurrentWeather>(
            future: wtr,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${snapshot.data?.sys?.country!} : کشور ',style: const TextStyle(fontSize: 22)),
                    Text('${snapshot.data?.dt!} : زمان ',style: const TextStyle(fontSize: 22)),
                    Text('شهر: ${snapshot.data?.name!} ',textDirection: TextDirection.ltr,style: const TextStyle(fontSize: 22)),
                  ],
                );
              } else {
                return const CircularProgressIndicator(color: Colors.deepOrange,);
              }
            },
          ),

          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: cityCntrl,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_city)
                  ),
                ),
              ),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                setState(() {
                  wtr = Data.getWeather('${cityCntrl.text??'Amol'}');
                });
              }, child: Text('سرچ'))
            ],
          ),

          const SizedBox(height: 30,),


        ],
      ),
    );
  }
}

class Capcha extends StatefulWidget {
  const Capcha({super.key});

  @override
  State<Capcha> createState() => _CapchaState();
}

class _CapchaState extends State<Capcha> {
  int _selectedIndex=1;

 String capcha='';

  TextEditingController captchaCntrl=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('اب و هوا',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [
             Image.network(capcha,) ,
              const SizedBox(height: 30,),

              TextField(
                controller: captchaCntrl,
                decoration: InputDecoration(
                    icon: Icon(Icons.padding)
                ),

              ),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
            setState(() {
              capcha = Data.getCapcha(captchaCntrl.text);
            });
              }, child: Text('تنظیم'))
            ],

          ),
        ),

      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

          });

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),

      ),*/
      bottomNavigationBar:BottomNavigationBar(
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return Pages();
            // },));

            Navigator.pop(context);

          }
          else if(value==1&&value!=_selectedIndex){
            _selectedIndex=1;

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

