import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_repository.dart';

class ActivityRepositoryImpl extends ActivityRepository {
  // TODO add your methods here
}

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepositoryImpl();
});
