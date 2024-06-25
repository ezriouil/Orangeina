import 'package:berkania/data/data_source/remote.dart';
import 'package:berkania/data/mappers/review_mapper.dart';
import 'package:berkania/data/models/review_dto.dart';
import 'package:berkania/domain/entities/review_entity.dart';
import 'package:berkania/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE INSERT NEW REVIEW - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> insert({ required ReviewEntity reviewEntity }) async{
    await Remote.insertReview(reviewDto: reviewEntity.toReviewDto());
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE GET ALL REVIEWS - - - - - - - - - - - - - - - - - -  //
  @override
  Future<List<ReviewEntity>> getReviews({required String id}) async {
    final List<ReviewEntity> reviewsEntity = [];
    final List<ReviewDto> reviewsDto = await Remote.getAllReviews(vendorId: id);

    if (reviewsDto.isNotEmpty) {
      for (ReviewDto reviewDto in reviewsDto) {
        reviewsEntity.add(reviewDto.toReviewEntity());
      }
    }
    return reviewsEntity;
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE DELETE REVIEW - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> delete({required String docId}) async{
    await Remote.deleteReviewById(id: docId,);
  }
}
