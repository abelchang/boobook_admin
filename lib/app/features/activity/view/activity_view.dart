import 'package:boobook_admin/app/core/widget/tiny_widget.dart';
import 'package:boobook_admin/app/features/activity/model/activity.dart';
import 'package:boobook_admin/app/features/activity/providers/activity_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityView extends ConsumerWidget {
  /// TODO add your comment here
  const ActivityView({Key? key}) : super(key: key);

  static const routeName = '/activity';

  @override
  // Notice how "build" now receives an extra parameter: "ref"
  Widget build(BuildContext context, WidgetRef ref) {
    // We can use "ref.watch" inside our widget like we did using "Consumer"
    final AsyncValue<Activity> activity = ref.watch(activityProvider);

    // The rendering logic stays the same
    return Scaffold(
      appBar: AppBar(title: const Text('Pull to refresh')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(activityProvider.future),
        child: ListView(
          children: [
            const C(16),
            switch (activity) {
              // If some data is available, we display it.
              // Note that data will still be available during a refresh.
              AsyncValue<Activity>(:final valueOrNull?) =>
                Text(valueOrNull.activity),
              // An error is available, so we render it.
              AsyncValue(:final error?) => Text('Error: $error'),
              // No data/error, so we're in loading state.
              _ => const Center(child: CircularProgressIndicator()),
            },
          ],
        ),
      ),
    );
  }
}
