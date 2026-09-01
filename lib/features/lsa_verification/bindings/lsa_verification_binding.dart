import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:habot/core/constants/api_constants.dart';
import 'package:habot/core/constants/app_durations.dart';
import 'package:habot/core/security/quarantine_service.dart';
import 'package:habot/data/repositories/verification_repository.dart';
import 'package:habot/data/services/api_client.dart';
import 'package:habot/data/services/verification_api_service.dart';
import 'package:habot/features/lsa_verification/controllers/lsa_verification_controller.dart';

class LsaVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: AppDurations.apiTimeout,
          receiveTimeout: AppDurations.apiTimeout,
        ),
      ),
    );
    Get.lazyPut<ApiClient>(() => ApiClient(Get.find<Dio>()));
    Get.lazyPut<VerificationApiService>(
      () => VerificationApiService(Get.find()),
    );
    Get.lazyPut<VerificationRepository>(
      () => VerificationRepository(Get.find()),
    );
    Get.lazyPut<QuarantineService>(() => QuarantineService());
    Get.lazyPut<LsaVerificationController>(
      () => LsaVerificationController(
        repository: Get.find(),
        quarantineService: Get.find(),
      ),
    );
  }
}
