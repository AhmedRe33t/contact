import 'package:firebaseproject/widgets/defultText.dart';
import 'package:flutter/material.dart';

class BuilderUi extends StatelessWidget {
  const BuilderUi({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(''),
          ),
          Column(
            children: [
              CustomText(text: 'name'),
              CustomText(text: 'Phone')
            ],
          )
        ],
      ),
    );
  }
}