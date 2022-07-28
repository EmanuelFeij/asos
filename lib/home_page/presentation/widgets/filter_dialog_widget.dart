import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/pagination.dart';
import 'package:spacex/home_page/presentation/widgets/state_widget.dart';

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({Key? key}) : super(key: key);

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  int yearTextController = 2006;
  var wasSuccessful = LaunchSuccessful.both;
  var sortBy = SortOrder.asc;
  DateTime selectedDate = DateTime(2006);

  @override
  Widget build(BuildContext context) {
    var states = States.of(context)?.paginationNotifier;
    final mQuery = MediaQuery.of(context);
    return Dialog(
      child: SizedBox(
        height: mQuery.size.height * 0.5,
        width: mQuery.size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // byLaunch year,
              SizedBox(
                  width: 200,
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(15, (index) {
                      final newYear = index + 2006;
                      return GestureDetector(
                        child: newYear == yearTextController
                            ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    '$newYear',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text('$newYear'),
                              ),
                        onTap: () {
                          setState(() {
                            yearTextController = newYear;
                          });
                        },
                      );
                    }),
                  )),
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
                      year: yearTextController,
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
