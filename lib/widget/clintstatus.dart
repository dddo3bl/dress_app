import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Status extends StatefulWidget {
  final bayed;
  final clint_order;
  final total_price;
  final is_bayed;
  final order_time;

  const Status({Key key,this.is_bayed,this.order_time , this.bayed, this.clint_order, this.total_price}) : super(key: key);

  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  
  @override
  void initState() {
    print(widget.is_bayed.toString());
    // TODO: implement initState
    super.initState();
  }
  @override
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 400,
        height: 200,
        color: Colors.purpleAccent.withOpacity(.3),
        child: Column(
          children:[
           Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text("رقم الفاتورة:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(widget.clint_order.toString(),style: TextStyle(fontSize: 20),),
                ),
                Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Text(" الدفع:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(widget.is_bayed == 0 ? "لم يتم الدفع":"تم الدفع",style: TextStyle(fontSize: 20),),
                ),
              ],
          ),
           Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30,right: 20),
                  child: Text("المدفوع",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30,right: 20),
                  child: Text(widget.bayed.toString(), style: TextStyle(fontSize: 20),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30,right: 90),
                  child: Text("المبلغ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30,right: 20),
                  child: Text(widget.total_price.toString(),style: TextStyle(fontSize: 20),),
                ),
              ],
          ),
          Row(children: [
            Container(
                  margin: EdgeInsets.only(top: 10,right: 50),
                  child: Text("تاريخ الطلب",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(widget.order_time.toString(),style: TextStyle(fontSize: 17),),
                ),
          ],)
          ]
        ),       
      ),
    );
  }
}