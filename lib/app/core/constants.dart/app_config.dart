class AppConfig {
  static const projectName = "療管家";
  static const apiUrl = "API_URL";
  static const debug = "DEBUG";
  static const locale = "Locale";
  static const statisticsPerid = 6;
  static const maxAttachment = 10;
}

class ApiConstants {
  static const String token = 'token';
  static const String loggingUserList = 'loggingUserList';
  static const String success = 'success';
  static const String message = 'message';
  static const String code = 'code';
  static const String traceId = 'traceId';
  static const String data = 'data';
  static const String user = 'user';
  static const String ots = 'ots';
  static const String singleClass = 'singleClass';
  static const String singleClassId = 'singleClassId';
  static const String classes = 'classes';
  static const String courses = 'courses';
  static const String course = 'course';
  static const String courseName = 'courseName';
  static const String courseId = 'courseId';
  static const String kids = 'kids';
  static const String kid = 'kid';
  static const String kidId = 'kidId';
  static const String kidStatus = 'kidStatus';
  static const String kidIds = 'kidIds';
  static const String reason = 'reason';
  static const String status = 'status';
  static const String kidAttends = 'kidAttends';
  static const String classrooms = 'classrooms';
  static const String classroom = 'classroom';
  static const String schedules = 'schedules';
  static const String courseTemplate = 'courseTemplate';
  static const String file = 'file';
  static const String behaviorComment = 'behaviorComment';
  static const String behaviorComments = 'behaviorComments';
  static const String leaveReasonComment = 'leaveReasonComment';
  static const String leaveReasonComments = 'leaveReasonComments';
  static const String homeworkTemplate = 'homeworkTemplate';
  static const String homeworkTemplates = 'homeworkTemplates';
  static const String homeworkAssignment = 'homeworkAssignment';
  static const String homeworkAssignments = 'homeworkAssignments';
  static const String homeworkDelivery = 'homeworkDelivery';
  static const String homeworkDeliverys = 'homeworkDeliverys';
  static const String homeworkAssignmentAttached = 'homeworkAssignmentAttached';
  static const String homeworkTemplateAttached = 'homeworkTemplateAttached';
  static const String homeworkTemplateId = 'homeworkTemplateId';
  static const String homeworkAssignmentId = 'homeworkAssignmentId';
  static const String sources = 'sources';
  static const String userId = 'userId';
  static const String title = 'title';
  static const String tags = 'tags';
  static const String tag = 'tag';
  static const String users = 'users';
  static const String messagesBoard = 'messagesBoard';
  static const String threadId = 'threadId';
  static const String messages = 'messages';
  static const String email = 'email';
  static const String userName = 'userName';
  static const String userFullName = 'userFullName';
  static const String phone = 'phone';
  static const String originalPassword = 'originalPassword';
  static const String password = 'password';
  static const String resetPassword = 'resetPassword';
  static const String tenant = 'tenant';
  static const String name = 'name';
  static const String employees = 'employees';
  static const String tenantIds = 'tenantIds';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String loginCountByTenant = 'loginCountByTenant';
  static const String loginCountByTenants = 'loginCountByTenants';
  static const String loginCountPerDays = 'loginCountPerDays';
  static const String userCountPerDays = 'userCountPerDays';
  static const String appVersionInfo = 'appVersionInfo';
  static const String otCountPerDays = 'otCountPerDays';
  static const String countPerDay = 'countPerDay';
  static const String roleName = 'roleName';
  static const String userDeviceInfo = 'userDeviceInfo';
  static const String deviceId = 'deviceId';
  static const String fcmToken = 'fcmToken';
  static const String model = 'model';
  static const String platform = 'platform';
  static const String locale = 'locale';
  static const String tenantName = 'TenantName';
  static const String topics = 'Topics';
}

class Constants {
  static const String appName = '中文測試';
  static const String appNameDec = '感覺處理與平衡測試\nSPBT\n收案系統';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
  static const int mobileSize = 640;
  static const int screenWide = 1024;
  static const int yearConvert = 1911;
  static const int videoSeconds = 21;
  static const int videoPrepareSeconds = 3;
  static const String videoUploadDir = 'upload';
  static const String videoType = '.webm';
  static const String s3Url =
      'https://ase-dev.s3.ap-northeast-2.amazonaws.com/';
  static const String route = 'route';
  static const String course = 'course';
  static const String message = 'message';
  static const String singleClass = 'singleClass';
}

class ClassRes {
  ClassRes(
      {this.needUpdate = false, this.del = false, this.selectDate, this.data});
  bool needUpdate;
  bool del;
  DateTime? selectDate;
  dynamic data;
}

class ResCode {
  static const showMessage = 9110001;
  static const success = 0;
  static const authFalse = 401;
}
