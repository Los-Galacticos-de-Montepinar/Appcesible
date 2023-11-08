import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'MyCheckbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>{

  List<String> tipos=[];
  List<bool> tiposV=[];
  Map<String,bool> mapa={};
  String seleccionados="";
  List<String> clases=[];
  String claseSelec="";

  _MyStatefulWidgetState(){
    tipos=["Audio","Texto","Pictogramas"];
    tiposV=List.filled(tipos.length, false);
    mapa=Map.fromIterables(tipos, tiposV);
    clases=["1A","2A","3A"];
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const heightPercentage=0.12;
    final heightTitle= screenHeight * heightPercentage;
    final heightContainer= (screenHeight * (1-heightPercentage))-10;

    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[300],
          title: const Text("AppCesible", textScaleFactor: 1.5),
          centerTitle: true,
          toolbarHeight: heightTitle,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.black,
                width: 2.5
              )
            ),
            width: screenWidth-10,
            height: heightContainer,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                  "Variable",
                  textScaleFactor: 2,
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                  decoration: InputDecoration(
                    labelText: "Apellidos",
                    border: OutlineInputBorder(),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                  decoration: InputDecoration(
                    labelText: "Correo",
                    border: OutlineInputBorder(),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Seleccionados: ${seleccionados}"),
                ),

                Padding(
                  padding: EdgeInsets.all(12),
                  child: DropdownButtonFormField(
                    items: tipos.map((e) => 
                      DropdownMenuItem(
                        value: e,
                        child: Text(e)
                      )
                    ).toList(),
                    onChanged: (value) => {
                      if(value!=null && mapa.containsKey(value))
                        mapa[value] = !(mapa[value] ?? false)
                      ,
                      seleccionados=""
                      ,
                      mapa.forEach((key, value) {
                        if(value)
                          seleccionados+=" ${key} ";
                      })
                      ,
                      setState(() {})
                    },
                    decoration: InputDecoration(
                      labelText: "Tipo de contenido"
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: DropdownButtonFormField(
                    items: clases.map((e) => 
                      DropdownMenuItem(
                        value: e,
                        child: Text(e)
                      )
                    ).toList(),
                    onChanged: (value) => {
                      if(value!=null)
                        claseSelec=value
                      ,                      
                      print(claseSelec)
                    },
                    decoration: InputDecoration(
                      labelText: "Clase"
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Fecha seleccionada: ${_selectedDate.toString().substring(0, 10)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text('Seleccionar fecha de nacimiento'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                    children: [
                      MyCheckbox(),
                      MyCheckbox()
                    ]
                  )
                  ),
                )
              ],
            )
              ),
            )
            
          )
        ),
      ),
    );
  }
}