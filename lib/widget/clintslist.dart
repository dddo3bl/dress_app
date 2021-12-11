import 'package:flutter/material.dart';
import 'package:flutter_app/pages/clitdetails.dart';

class ClintsList extends StatelessWidget {
  final clint_name;
  final clint_phone;
  final clint_id;
  final chist_whdth;
  final cholder;
  final handwhdth;
  final hight;
  final hight_res;
  final kbk_length;
  final mfsl;
  final muscle;
  final nick;

  const ClintsList(
      {Key key,
      this.clint_name,
      this.clint_phone,
      this.clint_id,
      this.chist_whdth,
      this.cholder,
      this.handwhdth,
      this.hight,
      this.hight_res,
      this.kbk_length,
      this.muscle,
      this.mfsl,
      this.nick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: 150,
          width: 150,
          child: Card(
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.topRight,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(clint_name),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      clint_id.toString(),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ClintDetails(
            clintid: clint_id,
            clintname: clint_name,
            clintphone: clint_phone,
            chistwhdth: chist_whdth,
            chold: cholder,
            hand_whdth: handwhdth,
            hightall: hight,
            hightres: hight_res,
            kbklength: kbk_length,
            mfslall: mfsl,
            nickall: nick,
          );
        }));
      },
    );
  }
}
