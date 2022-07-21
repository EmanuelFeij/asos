import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/lauch_info.dart';

class LaunchInfoWidget extends StatelessWidget {
  const LaunchInfoWidget({Key? key, required this.launchInfo})
      : super(key: key);
  final LaunchInfo launchInfo;
  @override
  Widget build(BuildContext context) {
    Widget image;
    if (launchInfo.missionImage != "") {
      image = Image.network(launchInfo.missionImage, width: 70, height: 70);
    } else {
      image = const SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Text(
            'Image Not Found',
            style: TextStyle(overflow: TextOverflow.clip),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // image
        image,
        // Text
        Expanded(
          child: Column(
            children: [
              Text('${launchInfo.flightNumber}'),
              Text(launchInfo.missionName),
              Text(launchInfo.launchYear),
              Text('${launchInfo.rocketName}/${launchInfo.rocketType}'),
              // Text('${launchInfo.}'),
            ],
          ),
        ),
        // checkmark
        launchInfo.launchSuccess
            ? const Icon(Icons.check)
            : const Icon(Icons.close)
      ],
    );
  }
}
