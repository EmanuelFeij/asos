class CompanyInfo {
  final String name;
  final String founder;
  final int founded;
  final int employees;
  final int launchSites;
  final int valuation;

  CompanyInfo(this.name, this.founder, this.founded, this.employees,
      this.launchSites, this.valuation);

  CompanyInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        founder = json['founder'],
        founded = json['founded'],
        employees = json['employees'],
        launchSites = json['launch_sites'],
        valuation = json['valuation'];
}
