import 'package:berkania/domain/entities/review_entity.dart';

abstract class ReviewRepository {

  // - - - - - - - - - - - - - - - - - - NEW REVIEW - - - - - - - - - - - - - - - - - -  //
  Future<void> insert({required ReviewEntity reviewEntity});

  // - - - - - - - - - - - - - - - - - - GET ALL REVIEWS - - - - - - - - - - - - - - - - - -  //
  Future<List<ReviewEntity>> getReviews({ required String id });

}