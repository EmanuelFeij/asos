import 'package:flutter/material.dart';

import '../../domain/company_info.dart';

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({Key? key, required this.companyInfo})
      : super(key: key);
  final CompanyInfo companyInfo;
  @override
  Widget build(BuildContext context) {
    return Text(
        "${companyInfo.name} was founded by ${companyInfo.founder} in \n${companyInfo.founded}. It has now ${companyInfo.employees} employees,\n${companyInfo.launchSites} launch sites, and is valued at USD\n${companyInfo.valuation}");
  }
}
