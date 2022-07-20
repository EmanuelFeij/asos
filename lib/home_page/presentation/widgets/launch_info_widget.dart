import 'package:flutter/material.dart';
import 'package:spacex/home_page/domain/lauch_info.dart';

class LaunchInfoWidget extends StatelessWidget {
  const LaunchInfoWidget({Key? key, required this.launchInfo})
      : super(key: key);
  final LaunchInfo launchInfo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // image
        Image.network(launchInfo.missionImage, width: 70, height: 70),
        // Text
        Expanded(
          child: Column(
            children: [
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
