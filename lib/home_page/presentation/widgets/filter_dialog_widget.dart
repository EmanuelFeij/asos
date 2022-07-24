import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/pagination.dart';

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({Key? key}) : super(key: key);

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  final yearTextController = TextEditingController();
  var wasSuccessful = false;
  var sortBy = SortOrder.asc;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Dialog(
      child: SizedBox(
        height: mQuery.size.height * 0.4,
        width: mQuery.size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // byLaunch year,
              TextField(
                keyboardType: TextInputType.number,
                controller: yearTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Year'),
                ),
              ),
              // sucessfully
              Row(
                children: [
                  const Text('Successful:'),
                  Checkbox(
                      value: wasSuccessful,
                      onChanged: (v) {
                        setState(() {
                          wasSuccessful = v!;
                          print(wasSuccessful);
                        });
                      }),
                ],
              ),
              DropdownButton<String>(
                  value: sortBy.toString(),
                  items: [
                    DropdownMenuItem(
                        value: SortOrder.asc.toString(),
                        child: Text(SortOrder.asc.toString())),
                    DropdownMenuItem(
                        value: SortOrder.desc.toString(),
                        child: Text(SortOrder.desc.toString())),
                  ],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      SortOrder s;
                      if (newValue == SortOrder.asc.toString()) {
                        s = SortOrder.asc;
                      } else {
                        s = SortOrder.desc;
                      }
                      setState(() {
                        sortBy = s;
                      });
                    }
                  }),
              // asc/desc
              ElevatedButton(
                  onPressed: () {
                    print(yearTextController);
                    print(wasSuccessful);
                    print(sortBy);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }
}
