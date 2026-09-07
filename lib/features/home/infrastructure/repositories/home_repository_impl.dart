import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/features/home/domain/repositories/home_repository.dart';
import 'package:devkit/features/home/infrastructure/datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  const new({required this.localDataSource});

  final HomeLocalDataSource localDataSource;

  @override
  Future<DeviceInfoData> getDeviceInfo() {
    return localDataSource.getDeviceInfo();
  }
}
