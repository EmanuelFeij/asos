import 'package:flutter/material.dart';

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({Key? key}) : super(key: key);

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Dialog(
        child: Column(
          children: [
            // byLaunch year,
            Text('Something'),
            // sucessfully
            Checkbox(value: true, onChanged: (v) {}),
            // asc/desc
            ElevatedButton(onPressed: () {}, child: Text('Close')),
          ],
        ),
      ),
    );
  }
}
