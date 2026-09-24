import 'package:boobook_admin/app/features/bnb/view/bnb_view.dart';
import 'package:boobook_admin/app/features/holiday/view/holiday_view.dart';
import 'package:boobook_admin/app/features/solar/view/solar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class Dashborad extends StatefulWidget {
  const Dashborad({super.key});

  @override
  State<Dashborad> createState() => _DashboradState();
}

class _DashboradState extends State<Dashborad> {
  int selectedTab = 0;
  final List<(Widget, Widget, String)> items = <(Widget, Widget, String)>[
    (const Icon(Icons.reorder), const Icon(Icons.reorder_outlined), 'BnB'),
    (
      const Icon(Icons.edit_calendar),
      const Icon(Icons.edit_calendar_outlined),
      '假日'
    ),
    (const Icon(Icons.wb_sunny), const Icon(Icons.wb_sunny_outlined), '節氣'),
  ];
  final List<Widget> child = <Widget>[
    const BnbsView(),
    const HolidayView(),
    const SolarView(),
  ];
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      selectedIndex: selectedTab,
      onSelectedIndexChange: (int index) {
        setState(() {
          selectedTab = index;
        });
      },
      useDrawer: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(items[selectedTab].$3),
      ),
      body: (_) => child[selectedTab],
      destinations: items
          .map((e) => NavigationDestination(
              icon: e.$2, selectedIcon: e.$1, label: e.$3))
          .toList(),
    );
  }
}