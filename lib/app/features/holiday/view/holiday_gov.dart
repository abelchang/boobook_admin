import 'package:boobook_admin/app/core/widget/tiny_widget.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/repository/holiday_repository_impl.dart';
import 'package:boobook_admin/app/features/holiday/widget/holiday_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidayGov extends StatefulWidget {
  const HolidayGov({super.key});

  @override
  State<HolidayGov> createState() => _HolidayGovState();
}

class _HolidayGovState extends State<HolidayGov> {
  Response? response;
  List<Holiday> holidays = [];
  List<Holiday> rowholidays = [];
  int year = DateTime.now().year;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(year.toString()),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  year++;
                  filterHolidays();
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                setState(() {
                  year--;
                  filterHolidays();
                });
              },
              icon: const Icon(Icons.remove)),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  EasyLoading.showInfo('匯入中...');
                  ref
                      .read(holidayRepositoryProvider)
                      .storeList(holidays)
                      .then((value) {
                    if (value) {
                      EasyLoading.showSuccess('匯入完成！');
                    } else {
                      EasyLoading.showError('匯入失敗！');
                    }
                  });
                },
                child: const Text('import'),
              );
            },
          ),
          const C(16),
        ],
      ),
      body: holidays.isEmpty
          ? const Center(
              child: Text('...'),
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: holidays.length,
              separatorBuilder: (BuildContext ctx, int index) {
                return const SizedBox(height: 16);
              },
              itemBuilder: (BuildContext ctx, int index) {
                return HolidayCardWidget(
                  editable: false,
                  day: holidays[index],
                );
              },
            ),
    );
  }

  bool stringTobool(String string) {
    switch (string) {
      case '是':
        return true;
      default:
        return false;
    }
  }

  Future<void> fetchData() async {
    try {
      response = await Dio().get(
          'https://data.ntpc.gov.tw/api/datasets/308DCD75-6434-45BC-A95F-584DA4FED251/json?page=0&size=1000009');
      if (response?.data != null) {
        rowholidays.clear();
        for (var holiday in response?.data) {
          if (holiday?['name'] != null) {
            rowholidays.add(
              Holiday(
                date: DateTime.parse(holiday['date'] as String),
                name: holiday['name'],
                isHoliday: stringTobool(holiday["isholiday"]),
                description: holiday['description'] ?? '',
              ),
            );
          }
        }
        setState(() {
          filterHolidays();
        });
      }
    } catch (e) {
      debugPrint('Error fetching holidays: $e');
    }
  }

  void filterHolidays() {
    holidays.clear();
    for (var holiday in rowholidays) {
      if (holiday.date.year == year) {
        holidays.add(holiday);
      }
    }
  }
}
