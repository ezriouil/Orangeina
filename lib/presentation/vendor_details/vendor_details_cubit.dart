import 'dart:async';
import 'dart:ui' as ui;

import 'package:berkania/domain/entities/report_entity.dart';
import 'package:berkania/domain/entities/review_entity.dart';
import 'package:berkania/domain/entities/user_entity.dart';
import 'package:berkania/domain/repositories/review_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_text_field.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../domain/entities/vendor_entity.dart';
import '../../domain/repositories/report_repository.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../../utils/constants/custom_colors.dart';
import '../../utils/constants/custom_image_strings.dart';

part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final UserRepository userRepository;
  final VendorRepository vendorRepository;
  final ReviewRepository reviewRepository;
  final ReportRepository reportRepository;
  final GetStorage storage;
  String? argumentId;
  String? uid;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  VendorDetailsCubit(
      {required this.userRepository,
      required this.vendorRepository,
      required this.reviewRepository,
      required this.reportRepository,
      required this.storage})
      : super(VendorDetailsLoadingState()) {
    init();
  }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async{

    emit(VendorDetailsMainState(
      mapController:  Completer<GoogleMapController>(),
      vendor: VendorEntity(),
      markers: const {},
      reviews: const [],
      feedbackController: TextEditingController(),
      feedback: 0.0,
      reportReason: ""
    ));
    await getVendorInfo();
    uid = await LocalStorage.read(key: "UID", storage: storage);
    await getReviews();
  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  getVendorInfo() async{
    final VendorDetailsMainState currentState = state as VendorDetailsMainState;
    print("++++++++");
    print(argumentId);
    print("++++++++");
    final VendorEntity? vendor = await vendorRepository.getVendorById(vendorId: argumentId!);

    final markers = <Marker>{};
    if(vendor == null) return;

    markers.add(await customMarker(lat: 31.7071858, lng: -7.9518629));

    emit(currentState.copyWith(vendor: vendor, markers: markers));
  }

  // - - - - - - - - - - - - - - - - - - GET ALL REVIEWS - - - - - - - - - - - - - - - - - -  //
  getReviews() async{
    final VendorDetailsMainState currentState = state as VendorDetailsMainState;
    if(uid == null) return;
    final List<ReviewEntity> reviews = await reviewRepository.getReviews(id: uid!);
    emit(currentState.copyWith(reviews: reviews));
  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  onMapCompleted(GoogleMapController mapController) {
    final VendorDetailsMainState updateState = state as VendorDetailsMainState;
    if(updateState.mapController!.isCompleted) return;
    updateState.mapController!.complete(mapController);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - MARKER - - - - - - - - - - - - - - - - - -  //
  Future<Marker> customMarker({required double lat, required double lng}) async{
    final customIcon = BitmapDescriptor.fromBytes(await _getBytesFromAsset(CustomImageStrings.MARKER_SELLER, 120));
    return Marker(
        markerId: MarkerId("$lat $lng"),
        position: LatLng(lat, lng),
        icon: customIcon);
  }
  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  // - - - - - - - - - - - - - - - - - - ALERT FEEDBACK - - - - - - - - - - - - - - - - - -  //
  void onGiveFeedback({required BuildContext context, required Function callBack}) async {

    final VendorDetailsMainState currentState = state as VendorDetailsMainState;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.infinity,
              height: 360,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                
                    // - - - - - - - - - - - - - - - - - -  TITLE - - - - - - - - - - - - - - - - - -  //
                    Text("Give Feedback", style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 0.6)),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                
                    // - - - - - - - - - - - - - - - - - -  SUB TITLE 1 - - - - - - - - - - - - - - - - - -  //
                    Text("What do you think about this seller.", style: Theme.of(context).textTheme.bodySmall),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                
                    // - - - - - - - - - - - - - - - - - -  RATING - - - - - - - - - - - - - - - - - -  //
                    Center(
                      child: RatingBar.builder(
                        itemCount: 5,
                        initialRating:  3,
                        maxRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemPadding: EdgeInsets.zero,
                        itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                        onRatingUpdate: (double value) {  },
                      ),
                    ),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                
                    // - - - - - - - - - - - - - - - - - -  SUB TITLE 2 - - - - - - - - - - - - - - - - - -  //
                    Text("Do you have any thoughts you would like to share ?.", style: Theme.of(context).textTheme.bodySmall),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                
                    // - - - - - - - - - - - - - - - - - -  TEXT FILED- - - - - - - - - - - - - - - - - -  //
                    CustomTextField(hint: "Write Your Feedback ..!", controller: currentState.feedbackController!, leadingIcon: Iconsax.bookmark, validator: null),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),
                
                    // - - - - - - - - - - - - - - - - - -  BUTTONS- - - - - - - - - - - - - - - - - -  //
                    Row(
                      children: [

                        // - - - - - - - - - - - - - - - - - -  CANCEL - - - - - - - - - - - - - - - - - -  //
                        Expanded(child: CustomElevatedButton(child: Text("Cancel"), onClick: context.pop, height: 78, withDefaultPadding: false)),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),

                        // - - - - - - - - - - - - - - - - - -  SUBMIT - - - - - - - - - - - - - - - - - -  //
                        Expanded(child: CustomElevatedButton(child: Text("Submit"), onClick: () async{

                          if(currentState.feedbackController!.text.trim().length < 6){
                            // SHOW SNACK BAR
                            return;
                          }

                          if(uid == null) return;

                          final UserEntity? userEntity = await userRepository.getUserInfo(id: uid!);

                          if(userEntity == null) return;

                          final date = DateTime.now();
                          final ReviewEntity review = ReviewEntity(
                            vendorId: uid,
                            fullName: "${userEntity.firstName} ${userEntity.lastName}",
                            reviewBody: currentState.feedbackController!.text.trim(),
                            avatar: userEntity.avatar,
                            rating: currentState.feedback!,
                            createAt: "${date.day}/${date.month}/${date.year}"
                          );
                          await reviewRepository.insert(reviewEntity: review);

                          currentState.feedbackController!.clear();

                          callBack.call();

                        }, height: 78, withDefaultPadding: false)),

                      ],
                    )
                    
                  ],
                ),
              ),
            ),
          );
        });
  }

  // - - - - - - - - - - - - - - - - - - ALERT REPORT - - - - - - - - - - - - - - - - - -  //
  void onReport({required BuildContext context, required Function callBack}) async {

    final VendorDetailsMainState currentState = state as VendorDetailsMainState;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.infinity,
              height: 360,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                
                    // - - - - - - - - - - - - - - - - - -  TITLE - - - - - - - - - - - - - - - - - -  //
                    Text("Report", style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 0.6)),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                
                    // - - - - - - - - - - - - - - - - - -  SUB TITLE 1 - - - - - - - - - - - - - - - - - -  //
                    Text("Why you want to report this seller ?", style: Theme.of(context).textTheme.bodySmall),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                
                    DropdownButton<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                        style: Theme.of(context).textTheme.bodyLarge,
                        items:[
                          DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_1.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_1.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                          DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_2.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_2.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                          DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_3.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_3.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                          DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_4.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_4.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                          DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_5.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_5.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                        ],
                        onChanged: (String? value) {
                          emit(currentState.copyWith(reportReason: value));
                        },
                        icon: const Icon(Iconsax.arrow_bottom),
                        value: currentState.reportReason == "" ? CustomLocale.VENDOR_DETAILS_REPORT_REASON_1.getString(context) : currentState.reportReason ),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                
                    // - - - - - - - - - - - - - - - - - -  SUB TITLE 2 - - - - - - - - - - - - - - - - - -  //
                    Text("Do you have any thoughts you would like to share ?.", style: Theme.of(context).textTheme.bodySmall),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                
                    // - - - - - - - - - - - - - - - - - -  TEXT FILED- - - - - - - - - - - - - - - - - -  //
                    CustomTextField(hint: "Write Your Feedback ..!", controller: currentState.feedbackController!, leadingIcon: Iconsax.bookmark, validator: null),
                
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),
                
                    // - - - - - - - - - - - - - - - - - -  BUTTONS- - - - - - - - - - - - - - - - - -  //
                    Row(
                      children: [

                        // - - - - - - - - - - - - - - - - - -  CANCEL - - - - - - - - - - - - - - - - - -  //
                        Expanded(child: CustomElevatedButton(child: Text("Cancel"), onClick: context.pop, height: 78, withDefaultPadding: false)),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),

                        // - - - - - - - - - - - - - - - - - -  SUBMIT - - - - - - - - - - - - - - - - - -  //
                        Expanded(child: CustomElevatedButton(child: Text("Submit"), onClick: () async{

                          if(currentState.feedbackController!.text.trim().length < 6){
                            // SHOW SNACK BAR
                            return;
                          }

                          if(uid == null) return;

                          final UserEntity? userEntity = await userRepository.getUserInfo(id: uid!);

                          if(userEntity == null) return;

                          final date = DateTime.now();
                          final ReportEntity report = ReportEntity(
                              vendorId: uid,
                              fullName: "${userEntity.firstName} ${userEntity.lastName}",
                              reportType: currentState.reportReason,
                              reportBody: currentState.feedbackController!.text.trim(),
                              avatar: userEntity.avatar,
                              rating: currentState.feedback!,
                              createAt: "${date.day}/${date.month}/${date.year}"
                          );
                          await reportRepository.insert(reportEntity: report);

                          currentState.feedbackController!.clear();

                          callBack.call();

                        }, height: 78, withDefaultPadding: false)),

                      ],
                    )
                
                  ],
                ),
              ),
            ),
          );
        });
  }

}
