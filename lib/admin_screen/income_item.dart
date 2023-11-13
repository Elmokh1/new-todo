import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_todo/database/model/income_model.dart';
import 'package:new_todo/database/model/user_model.dart';

import '../database/my_database.dart';

class IncomeItem extends StatelessWidget {
  List<User>? user;

  IncomeItem({required this.user});

  @override
  Widget build(BuildContext context) {
    List<int> sort = [5, 3, 7, 0, 1, 8, 4];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: sort.where((index) {
          return index >= 0 && index < (user?.length ?? 0);
        }).map((index) {
          return Column(
            children: [
              Divider(
                thickness: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      user?[index].name ?? "",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  StreamBuilder<QuerySnapshot<Income>>(
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var incomeList = snapshot.data?.docs
                          .map((doc) => doc.data() as Income)
                          .toList();
                      double totalIncome = 0.0;
                      if (incomeList != null && incomeList.isNotEmpty) {
                        totalIncome = incomeList
                            .map((income) => income.DailyInCome ?? 0)
                            .reduce((a, b) => a + b);
                      }
                      if (incomeList?.isEmpty == true) {
                        return Center(
                          child: Text(
                            "0",
                            style: GoogleFonts.abel(
                              fontSize: 30,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          totalIncome.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    stream: MyDataBase.getIncomeRealTimeUpdate(
                        user?[index].id ?? ""),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
