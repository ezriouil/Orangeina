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
      createAt: createAt
  );
}