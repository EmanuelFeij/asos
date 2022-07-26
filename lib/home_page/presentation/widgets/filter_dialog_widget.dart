import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/pagination.dart';
import 'package:spacex/home_page/presentation/widgets/state_widget.dart';

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({Key? key}) : super(key: key);

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  final yearTextController = TextEditingController();
  var wasSuccessful = LaunchSuccessful.both;
  var sortBy = SortOrder.asc;

  @override
  Widget build(BuildContext context) {
    var states = States.of(context)?.paginationNotifier;
    final mQuery = MediaQuery.of(context);
    return Dialog(
      child: SizedBox(
        height: mQuery.size.height * 0.3,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Successful Launch:"),
                  DropdownButton<LaunchSuccessful>(
                      value: wasSuccessful,
                      items: [
                        DropdownMenuItem(
                          value: LaunchSuccessful.both,
                          child: Text(
                            LaunchSuccessful.both.toShortString(),
                          ),
                        ),
                        DropdownMenuItem(
                          value: LaunchSuccessful.yes,
                          child: Text(
                            LaunchSuccessful.yes.toShortString(),
                          ),
                        ),
                        DropdownMenuItem(
                          value: LaunchSuccessful.no,
                          child: Text(
                            LaunchSuccessful.no.toShortString(),
                          ),
                        ),
                      ],
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            wasSuccessful = newValue;
                          });
                        }
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sorted By:"),
                  DropdownButton<SortOrder>(
                      value: sortBy,
                      items: [
                        DropdownMenuItem(
                            value: SortOrder.asc,
                            child: Text(SortOrder.asc.toShortString())),
                        DropdownMenuItem(
                            value: SortOrder.desc,
                            child: Text(SortOrder.desc.toShortString())),
                      ],
                      onChanged: (newValue) {
                        if (newValue != null) {
                          SortOrder s;
                          if (newValue == SortOrder.asc) {
                            s = SortOrder.asc;
                          } else {
                            s = SortOrder.desc;
                          }
                          setState(() {
                            sortBy = s;
                          });
                        }
                      }),
                ],
              ),
              // asc/desc
              ElevatedButton(
                  onPressed: () {
                    states!.value = Pagination(
                      launchSuccessful: wasSuccessful,
                      year: yearTextController.text.isEmpty
                          ? 0
                          : int.parse(yearTextController.text),
                      limit: 20,
                      offset: 0,
                      sortOrder: sortBy,
                    );
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
