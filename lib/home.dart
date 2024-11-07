import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
TextEditingController heightController = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _infoText = 'Renseigner vos donnees';
double _imc = 0.0;
Color _textColor = Colors.white;
bool _notZero = false ;

  void _resetFields(){
    weightController.text=" ";
    heightController.text= " ";


    setState(() {
      _infoText= " ";
      _notZero= false;
      _formKey = GlobalKey <FormState> ();
    });
  }
  void _calculateIMC(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      _imc = weight/ (height * height);
      _notZero = true;
      if(_imc < 18.5){
        _infoText='MINCE';
        _textColor = Colors.purple;

      }
      else if (_imc >=18.5 && _imc < 25.9){
        _infoText='EN BONNE SANTE';
        _textColor = Colors.greenAccent;
      } else if (_imc >= 25.9 && _imc < 29.9){
        _infoText='EN SURPOIDS';
        _textColor = Colors.orangeAccent;


      } else if (_imc >= 29.9){
        _infoText='OBESITE';
        _textColor = Colors.pink;


      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Calculateur d'IMC"),
      centerTitle: true  ,
      backgroundColor: Colors.greenAccent,
      actions: <Widget>[
        IconButton(onPressed: _resetFields, icon:const Icon(Icons.refresh))
      ],
    ),
    backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Poids" , style : TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 30,
                ),
                ),
                Expanded(child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 30  , 10, 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        blurRadius: 1,
                        offset: const Offset(1, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(50.0),
                    ),
                  ),
                  child: TextFormField( keyboardType: TextInputType.number, textAlign: TextAlign.right,
controller: weightController,
                    validator: (value){
                    if (value!.isEmpty){
    return 'Entrez votre poids!';
                    }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                        const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      hintText: "00.0",
                      hintStyle: const TextStyle(fontSize: 20.0, color:Colors.black26),
                      suffixIcon: const Text(
                        'KG',
                        style:TextStyle(fontSize: 16, color:Colors.greenAccent,fontWeight:FontWeight.bold
                        ),

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none,
                        ),

                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Taille" , style : TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 30,
                ),
                ),
                Expanded(child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 30  , 10, 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        blurRadius: 1,
                        offset: const Offset(1, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(50.0),
                    ),
                  ),
                  child: TextFormField( keyboardType: TextInputType.number, textAlign: TextAlign.right,
                    controller:heightController,
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Entrez votre taille!';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      hintText: "00.0",
                      hintStyle: const TextStyle(fontSize: 20.0, color:Colors.black26),
                      suffixIcon: const Text(
                        'M',
                        style:TextStyle(fontSize: 16, color:Colors.greenAccent,fontWeight:FontWeight.bold
                        ),

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none,
                        ),

                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),

                ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: ElevatedButton(onPressed: (){
                if ( _formKey.currentState!.validate()){
                  _calculateIMC();
                }
              }, child: const Padding(
                  padding: EdgeInsets.all(10.0),
              child: Text("Calculer", style: TextStyle(fontSize: 20,),),
              ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent,),
              ),
            ),
Column(
  children: <Widget>[
    const Padding(
      padding: EdgeInsets.all(8.0),
    child: Text("VOUS ETES" , style: TextStyle(color: Colors.black26 , fontSize: 18,),),),
    Padding(padding: const EdgeInsets.all(16.0),
    child: Text(_infoText ,style: TextStyle(color: _textColor , fontSize: 26,),),

    ),
    if(_notZero)
      SfRadialGauge(
        axes: [
          RadialAxis(showLabels: false,minimum: 0,maximum: 40,
            ranges: [
              GaugeRange(startValue: 0, endValue: 18.5,color: Colors.purple.shade600,startWidth: 50,endWidth: 50),
              GaugeRange(startValue: 18.5, endValue: 25.9,color: Colors.greenAccent.shade400,startWidth: 50,endWidth: 50,),
              GaugeRange(startValue: 25.9, endValue: 29.9,color: Colors.deepOrangeAccent,startWidth: 50,endWidth: 50,),
              GaugeRange(startValue: 29.9, endValue: 40,color: Colors.pinkAccent,startWidth: 50,endWidth: 50,),

            ],
            pointers: [
              MarkerPointer(value: _imc,markerType: MarkerType.triangle, markerHeight: 30, markerWidth: 30,markerOffset: 40, color: Colors.white,)
            ],
            annotations: [
              GaugeAnnotation(axisValue: _imc, positionFactor: 0.05,widget: Text(_imc.toStringAsFixed(2),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.teal),))
            ],
          )
        ],
      )

  ],
)
          ],
        ),
        ),
      ),
    );
  }
}
