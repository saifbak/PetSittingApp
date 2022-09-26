import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:whiskers_away_app/src/views/per_details/pet_details_view_model.dart';
import '../../../helper/location_helper.dart';
import '../home/widgets/location_petsitter.dart';
import 'package:url_launcher/url_launcher.dart';

final _authService = locator<AuthService>();

class PetDetailsView extends StatelessWidget {
  final Job request;
  final Roles role;

  const PetDetailsView({
    required this.request,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PetDetailsViewModel>.nonReactive(
      viewModelBuilder: () => PetDetailsViewModel(),
      builder: (context, model, __) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: _Body(model, request, role),
          ),
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  final PetDetailsViewModel model;
  final Job request;
  final Roles role;

  _Body(this.model, this.request, this.role);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final replyCtrl = TextEditingController();

  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? address;
    String? lat;
    String? lan;
    setState(() {
      lat = widget.request.latitude!;
      lan = widget.request.longitude!;
    });
    // print('request params ==>');
    // print(widget.request.owner?['id']);
    // print('locationpramas');
    // print(double.parse(widget.request.latitude!));
    //print(request.longitude);
    final screenSize = context.screenSize();
    Future<void> getAddress() async {
      final newaddress = await LocationHelper.getPlaceAddress(
          double.parse(widget.request.latitude!),
          double.parse(widget.request.longitude!));

      setState(() => address = newaddress);
      print(address);
    }

    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lan';
    Future<void> openMap() async {
      if (await canLaunchUrlString(googleUrl)) {
        await launchUrlString(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }

    //WidgetsBinding.instance.addPostFrameCallback((_) => getAddress);

    // final  address = LocationHelper.getPlaceAddress(
    //     double.parse(request.latitude!), double.parse(request.longitude!));
    //print(address);

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.height / 2.25,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 15,
                      color: Colors.black.withOpacity(.3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: widget.request.publicImage != null
                          ? NetworkImage(widget.request.publicImage!)
                          : AssetImage('assets/images/pet.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover),
                ),
              ),
              AppTopBar(
                text: '',
                color: Colors.white,
              ),
              Positioned(
                left: screenSize.width / 2 - ((screenSize.width / 1.5) / 2),
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 12.0,
                        sigmaY: 12.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: screenSize.width / 1.5,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.request.petName,
                              style: AppTextStyles.xLarge(
                                color: Colors.white,
                                weight: FontWeight.w700,
                              ),
                            ),
                            VerticalSpacing(4),
                            Text(
                              widget.request.breed ?? '',
                              style: AppTextStyles.xxLarge(
                                color: Colors.white,
                                weight: FontWeight.w500,
                              ),
                            ),
                            VerticalSpacing(6),
                            Row(
                              children: [
                                Text(
                                  '${widget.request.weight} lbs',
                                  style: AppTextStyles.xxLarge(
                                    color: Colors.white,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  widget.request.sittingat == 0
                                      ? 'Owner\'s home'
                                      : widget.request.sittingat == 1
                                          ? 'Sitter\'s home'
                                          : '',
                                  style: AppTextStyles.xMedium(
                                    color: Colors.white,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacing(6),
                            Row(
                              children: [
                                Icon(
                                  IconlyBold.location,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                HorizontalSpacing(4),
                                Text(
                                  widget.request.location != null
                                      ? widget.request.location.toString()
                                      : '',
                                  style: AppTextStyles.xMedium(
                                    color: Colors.white,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${widget.request.age} years old',
                                  style: AppTextStyles.xMedium(
                                    color: Colors.white,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalSpacing(28),
          //Expanded(
          //child: ListView(
          //padding: AppBaseStyles.horizontalPadding,
          //children: [
          SingleChildScrollView(
            child: Container(
              padding: AppBaseStyles.horizontalPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whisper,
                      image: DecorationImage(
                        image: widget.request.owner?['profile_img'] != null
                            ? NetworkImage(widget.request.owner!['profile_img'])
                            : AssetImage('assets/images/pet.jpg')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  HorizontalSpacing(10),
                  Expanded(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.request.owner != null
                                    ? widget.request.owner!['name'].toString()
                                    : '',
                                style: AppTextStyles.xLarge(
                                  weight: FontWeight.w500,
                                ),
                              ),
                              VerticalSpacing(6),
                              Text(
                                'Owner',
                                style: AppTextStyles.xxLarge(
                                  color: AppColors.gray,
                                ),
                              )
                            ],
                          ),
                          Text(
                            widget.request.period != null
                                ? widget.request.period.toString()
                                : '',
                            style: AppTextStyles.xMedium(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalSpacing(30),
          Padding(
            padding: AppBaseStyles.horizontalPadding,
            child: Text(widget.request.description != null
                ? widget.request.description.toString()
                : ''),
          ),
          VerticalSpacing(10),
          //],
          //),
          //),
          if (widget.role == Roles.petSitter) ...[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  VerticalSpacing(12),
                  Container(
                      padding: AppBaseStyles.horizontalPadding,
                      child: widget.request.sittingat == 0
                          ? Row(
                              children: <Widget>[
                                Text(
                                  'Pet Location',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.map,
                                  ),
                                  label: Text('Get Directions on the map'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                  onPressed: openMap,
                                ),
                              ],
                            )
                          : Spacer()),
                  VerticalSpacing(10),
                  Container(
                    padding: AppBaseStyles.horizontalPadding,
                    child: AppTextField(
                      controller: replyCtrl,
                      hintText: 'Enter your reply',
                      label: '',
                      maxLines: 4,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                    padding: AppBaseStyles.horizontalPadding,
                    child: AppTextField(
                        controller: priceCtrl,
                        hintText: 'Price',
                        label: '',
                        maxLines: 1,
                        padding: EdgeInsets.zero,
                        textInputType: TextInputType.number),
                  ),
                  //AppSpacing(context).bottomSpacing,
                  VerticalSpacing(12),
                  Padding(
                    padding: AppBaseStyles.horizontalPadding,
                    child: Row(
                      children: [
                        AppButton(
                          horizontalPadding: 10,
                          child: GestureDetector(
                              child: Icon(
                                Icons.favorite,
                                size: 20,
                                color: Colors.white,
                              ),
                              onTap: () {
                                handleFavourite(context);
                                // print("favorite");
                              }),
                          text: '',
                        ),
                        HorizontalSpacing(16),
                        Expanded(
                          child: AppButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                        "Attention",
                                        "Owners will review all available pet sitters' proposals and  make a selection based on those sitters who respond to their open booking. When  setting your rate, please factor in the 15% that will be withheld by the app. If a pet  owner accepts your proposal, you will be notified and provided with their contact  information to arrange a meet and greet. Pet sitters are paid by Pet Sitting App  within 1 day of completing the confirmed job.",
                                        'Confirm',
                                        widget.model,
                                        widget.request,
                                        replyCtrl,
                                        priceCtrl));
                              },
                              text: 'Request to pet sit'),
                        ),
                      ],
                    ),
                  ),
                  // VerticalSpacing(),
                ],
              ),
            )
          ],
          // VerticalSpacing(5),
          widget.model.isOwner()
              ? widget.request.isedit == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          text: 'Edit',
                          horizontalPadding: 30,
                          onPressed: () {
                            NavService.editsubmittedrequest(
                                arguments: EditRequestArguments(
                                    request: widget.request,
                                    role: Roles.petOwner));
                          },
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.request.isedit == 1
                            ? AppButton(
                                text: 'Delete',
                                horizontalPadding: 30,
                                onPressed: () {
                                  onDelete(context);
                                },
                                dangerColor: true,
                              )
                            : Container(),
                      ],
                    )
              : Container(),
          AppSpacing(context).bottomSpacing,
          AppSpacing(context).bottomSpacing,
        ],
      ),
    );
  }

  Future<void> onSubmit(ctx) async {
    try {
      await widget.model.requestToPetSit(
          widget.request.id,
          {
            "description": replyCtrl.text.trim(),
            "price": double.parse(priceCtrl.text.trim()),
          },
          ctx);
      _authService.navigateHomeScreen();
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }

  Future<void> handleFavourite(ctx) async {
    try {
      await widget.model
          .addToFavourite({"petowner_id": widget.request.petownerId}, ctx);
      _authService.navigateHomeScreen();
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }

  Future<void> onDelete(ctx) async {
    try {
      await widget.model.deleteJob({
        "job_id": widget.request.id,
      }, ctx);
      _authService.navigateHomeScreen();
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}

class CustomDialog extends StatelessWidget {
  final model;
  final request;
  final String title, description, buttonText;
  final replyCtrl;
  final priceCtrl;

  CustomDialog(
    this.title,
    this.description,
    this.buttonText,
    this.model,
    this.request,
    this.replyCtrl,
    this.priceCtrl,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                //ignore: deprecated_member_use
                child: ElevatedButton(
                  onPressed: () {
                    onSubmit(context);
                    Navigator.pop(context);
                  },
                  child: Text(buttonText),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onSubmit(ctx) async {
    try {
      await model.requestToPetSit(
          request.id,
          {
            "description": replyCtrl.text.trim(),
            "price": double.parse(priceCtrl.text.trim()),
            "petowner_id": request.owner?['id'],
          },
          ctx);
      _authService.navigateHomeScreen();
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
