import 'package:berkania/data/models/review_dto.dart';
import 'package:berkania/domain/entities/review_entity.dart';

extension ReviewEntityMapper on ReviewEntity {
  ReviewDto toReviewDto() => ReviewDto(
    id: id,
      vendorId: vendorId,
      viewerId: viewerId,
    fullName: fullName,
    reviewBody: reviewBody,
    avatar: avatar,
    rating: rating,
    createAt: createAt
  );
}

extension ReviewDtoMapper on ReviewDto {
  ReviewEntity toReviewEntity() => ReviewEntity(
      id: id,
      fullName: fullName,
      vendorId: vendorId,
      viewerId: viewerId,
      reviewBody: reviewBody,
      avatar: avatar,
      rating: rating,
      createAt: createAt
  );
}