import '../entities/report_entity.dart';

abstract class ReportRepository {

  // - - - - - - - - - - - - - - - - - - NEW REPORT - - - - - - - - - - - - - - - - - -  //
  Future<void> insert({required ReportEntity reportEntity});


}