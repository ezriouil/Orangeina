import 'package:berkania/data/models/review_dto.dart';
import 'package:berkania/domain/entities/review_entity.dart';

import '../../domain/entities/report_entity.dart';
import '../models/report_dto.dart';

extension ReportEntityMapper on ReportEntity {
  ReportDto toReportDto() => ReportDto(
    id: id,
      vendorId: vendorId,
    fullName: fullName,
      reportType: reportType,
      reportBody: reportBody,
    avatar: avatar,
    rating: rating,
    createAt: createAt
  );
}

extension ReportDtoMapper on ReportDto {
  ReportEntity toReportEntity() => ReportEntity(
      id: id,
      fullName: fullName,
      vendorId: vendorId,
      reportType: reportType,
      reportBody: reportBody,
      avatar: avatar,
      rating: rating,
      createAt: createAt
  );
}