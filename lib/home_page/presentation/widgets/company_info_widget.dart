import 'package:flutter/material.dart';

import '../../domain/company_info.dart';

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({Key? key, required this.companyInfo})
      : super(key: key);
  final CompanyInfo companyInfo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          "${companyInfo.name} was founded by ${companyInfo.founder} in \n${companyInfo.founded}. It has now ${companyInfo.employees} employees,\n${companyInfo.launchSites} launch sites, and is valued at USD\n${companyInfo.valuation}",
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
