import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import 'guardian_consultation_names_list.dart';

class ConsultationCard extends StatelessWidget {
  final Consultation consultation;
  ConsultationCard({required this.consultation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 18.0, bottom: 5.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 250,
        child: Stack(
          children: [
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   // child: Container(
            //   //   width: 70.0,
            //   //   height: 30.0,
            //   //   alignment: Alignment.center,
            //   //   decoration:const BoxDecoration(
            //   //     color: Kgreen,
            //   //     borderRadius: BorderRadius.only(
            //   //       topRight: Radius.circular(12.0),
            //   //       bottomLeft: Radius.circular(12.0)
            //   //     )
            //   //   ),
            //   //   // child: Text("${consultation.price}",style: ksubtitlestyle.copyWith(color: Colors.white),),
            //   // ),
            //   ),
            Positioned(
              top: 30.0,
              left: 15.0,
              right: 18.0,
              bottom: 15.0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${consultation.title}",
                      style: ksubtitlestyle,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 2.0,
                            color: Kgreen,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                              child: Text(
                            "${consultation.subtitle}",
                            style: ksubtitlestyle,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
