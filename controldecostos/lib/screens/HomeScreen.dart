import 'dart:ui';

import 'package:controldecostos/widget/graph_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
     late PageController _controller;
     int currentPage = 9;

     @override
     void initState() {
    // TODO: implement initState
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4
    );
    super.initState();
  }

Widget _bottomAction(IconData icon){
  return InkWell(
   child: Padding(
    padding: const EdgeInsets.all(9.0),
     child: Icon(icon),
  ),
  onTap: (){},
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 9.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
               _bottomAction(FontAwesomeIcons.clockRotateLeft),
               _bottomAction(FontAwesomeIcons.chartPie),
               const SizedBox( width: 48.0,),
               _bottomAction(FontAwesomeIcons.wallet),
               _bottomAction(Icons.settings)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){},
        ),
        body : _body(),
    );
  }
  
 Widget _body() {
  return SafeArea(
    child:Column(
      children: <Widget>[
        _selector(),
        _expenses(),
        _graph(),
        Container(
             color: Colors.blueAccent.withOpacity(0.14),
             height: 15.0,
        ),
        _list()
      ],
    ));
 }
Widget _pageItem( String name , int position){
  var _alingment;
   final selected =  TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey.shade700
  );
 
  final unselected = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    color: Colors.blueGrey.withOpacity(0.6)
  );
  if(position == currentPage){
    _alingment = Alignment.center;
  }else if(position > currentPage){
    _alingment = Alignment.centerRight;
  }else{
    _alingment = Alignment.centerLeft;
  }


  return Align(
   alignment: _alingment,
   child: Text(name,
   style: position == currentPage ? selected : unselected,),
   );
}

Widget _selector(){
return SizedBox.fromSize(
            size: const Size.fromHeight(70.0),
            child: PageView(
              onPageChanged: (newPage){
                setState(() {
                  currentPage = newPage;
                });
              },
              controller: _controller,
              children:  <Widget>[
                _pageItem('Enero',0),
                _pageItem('Febrero',1),
                _pageItem('Marzo',2),
                _pageItem('Abril',3),
                _pageItem('Mayo',4),
                _pageItem('Junio',5),
                _pageItem('Julio',6),
                _pageItem('Agosto',7),
                _pageItem('Septiembre',8),
                _pageItem('Octumbre',9),
                _pageItem('Noviembre',10),
                _pageItem('Diciembre',11)       
              ],
            ),
          );

}

Widget _expenses(){
   return const Column(
      children: <Widget>[
        Text("\$2361,41",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text("Total expenses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
}

Widget _graph(){
  return Container(
    width: double.infinity,
    child: GraphWidget());
}
Widget _item(IconData icon , String name, int percent , double value){
  return  ListTile(
    leading: Icon(icon , size: 32.0,),
    title: Text(name ,
     style: const TextStyle( 
      fontWeight : FontWeight.bold,
      fontSize: 16.0
       ),
       ),
    subtitle: Text('$percent% of expenses'
    ),
    trailing: Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0)
        ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('\$$value',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 16.0
        ),),
      )),
  );
}
Widget _list(){
  return Expanded(
    child: ListView.separated(
      itemCount: 15,
      itemBuilder: (BuildContext context, index) =>  _item(FontAwesomeIcons.bagShopping, 'Shopping' , 14 , 145.12), 
      separatorBuilder: (BuildContext context, int index) { 
        return Container(
             color: Colors.blueAccent.withOpacity(0.14),
             height: 6.0,
        );
       },
        
      ),
    );
  
}
}