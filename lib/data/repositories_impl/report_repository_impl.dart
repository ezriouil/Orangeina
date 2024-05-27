import 'package:berkania/data/data_source/remote.dart';
import 'package:berkania/data/mappers/report_mapper.dart';

import '../../domain/entities/report_entity.dart';
import '../../domain/repositories/report_repository.dart';

class ReportRepositoryImpl extends ReportRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE INSERT NEW REVIEW - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> insert({ required ReportEntity reportEntity }) async{
    await Remote.insertReport(reportDto: reportEntity.toReportDto());
  }

}
