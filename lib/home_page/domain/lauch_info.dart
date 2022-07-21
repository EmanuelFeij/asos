class LaunchInfo {
  final int flightNumber;
  final String missionName;
  final bool upcoming;
  final String launchYear;
  final String rocketName;
  final String rocketType;
  final String missionImage;
  final String launchDateUTC;
  final bool launchSuccess;
  final String wikiLink;
  final String youtubeLink;

  LaunchInfo(
      this.missionName,
      this.upcoming,
      this.launchYear,
      this.rocketName,
      this.rocketType,
      this.launchSuccess,
      this.wikiLink,
      this.youtubeLink,
      this.missionImage,
      this.launchDateUTC,
      this.flightNumber);

  // TODO: more date details
  LaunchInfo.fromJson(Map<String, dynamic> json)
      : missionName = json['mission_name'] ?? '',
        flightNumber = json['flight_number'],
        upcoming = json['upcoming'] ?? false,
        launchYear = json['launch_year'] ?? '',
        rocketName = json['rocket']['rocket_name'] ?? '',
        rocketType = json['rocket']['rocket_type'] ?? '',
        launchSuccess = json['launch_success'] ?? false,
        wikiLink = json['links']['wikipedia'] ?? '',
        youtubeLink = json['links']['video_link'] ?? '',
        launchDateUTC = json['launch_date_utc'] ?? '',
        missionImage = json['links']['mission_patch_small'] ?? '';
}
