import 'package:flutter/material.dart';

class BlackBarTitle extends StatelessWidget {
  const BlackBarTitle({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(text,
                style: const TextStyle(
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
