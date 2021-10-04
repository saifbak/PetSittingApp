import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class TermsConditionsViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();

  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;
  set termsAccepted(bool val) {
    _termsAccepted = val;
    notifyListeners();
  }

  ScrollController scrollController = ScrollController();
  List<String> get termsDemoData => [
        "This	agreement	applies	as	between	you,	the	User	of	this	App	and	Whiskers	Away	Night	And	Day	LLC	of	Randolph,	New	 Jersey	 (US),	 the	owner(s)	of	 this	App. Your	agreement	 to	comply	with	and	be	bound	by	 these	 terms	and	conditions	is	deemed	to	occur	upon	your	first	use	of	the	App. If you	do	not	agree	to	be	bound	by	these	terms	and	conditions,	you	should	stop	using	the	App	immediately.\n\n",
        "These	Terms	and	Conditions	should	be	read	in	conjunction	with	our	Privacy	Policy.	These	Terms	and	Conditions	sets	out	the	basis	on	which	Whiskers	Away	Night	And	Day	LLC	 	(herein	after	“	Whiskers	Away”)	makes	the	APP	available	 to	 you	 (“User”	 or	 ”You”)	and	 on	which	You	may	 use	 them.	Whiskers	Away’s	 Privacy	 Policy,	 forms	an	integral	part	of	These	Terms	and	Conditions.	By	installing	or	using	the	APP,	You	agree	to	accept	and	to	be	bound	by	(1)	These	Terms	and	Conditions	and	(2)	the	Privacy	Policy	at	all	time. If	You	do	not	agree	with	one	of	these,	please	do	not	install	or	use	the	APP.\n\n",
        "Please	take	a	few	moments	to	read	the	Terms	and	Conditions	carefully	in	regard	to	the	use	of	our	service	(“the	Service”)	including	all	of	our	App	(the	“App”)."
            "You	must	be	aged	18	or	over	in	order	to	download	and	operate	the	Service.	We	recommend	that	you	print	a	copy	of	this	for	future	reference.	All	sitters	offering	services	on	our	platform	must	be	18	years	of	age	or	as	a	17	year	old	must	have	the	written	consent	of	a	parent	or	guardian.	Additionally,	17	year	olds	must	disclose	their	age	to	all	potential	clients.\n\n"
            "When	you	first	use	the	Service,	you	must	confirm	your	acceptance	of	these	Terms	and	Conditions.\n\n"
            "Your	Use	of	our	App.\n"
            "These	Terms	and	Conditions	govern	your	use	of	 the	Service,	 that	is	our	App.	You	must	not	use	 this	Service	 for	anything	 that	is	unlawful	or	is prohibited	by these	Terms	and	Conditions	and/or any	notices	elsewhere	on this	Service.\n\n"
            "You	 further	agree	that	in	relation	to	this	Service	you	will	not	in	any	way	conduct	yourself	in	a	manner	which	is	unlawful,	or	which	gives	rise	to	civil	or	criminal	liability	or	which	might	call	into	disrepute	Whiskers	Away	or	the	Service.\n\n"
            "You	 will	 cooperate	 fully	 with	 Whiskers	 Away	 to	 investigate	 any	 suspected	 unlawful,	 fraudulent	 or	 improper	activity.\n\n"
            "You	must	not	sell,	copy,	 reproduce,	 translate,	communicate,	 reverse	engineer,	publish,	stream,	distribute,	 rent,	loan,	 sub-license,	 derive	 source	 code	 from,	 modify,	 adapt,	 merge,	 disassemble,	 decompile,	 create	 derivative	works	based	on,	or	otherwise	transfer	or	deal	in	copies	or	reproductions	of	the	App	or	any	part	or	interest	in	it	to	or	with	other	parties	in	any	way.\n\n"
            "If	 you	 feel	 that	 the	 behavior	 of	 another	 user	 breaches	 these	 Terms	 and	 Conditions,	 then	 please	 let	Whiskers	Away	know	 by	 sending	an	email	 to	WhiskersAwayPets@gmail.com	with	 details	 of	 the	 potential	 breach	and/or	the	user	responsible.	Whiskers	Away	will	take	reasonable	steps	to	deal	with	any	breach.\n\n"
            "Grant	Of	License\n"
            "Whiskers	 Away	 grants	 You	 a	 non-exclusive,	 non-transferable,	 non-sublicensed,	 non-commercial	 and	 personal	license	to	install	and/or	use	the	APP	(in	whole	or	in	part)	and	any	APP	(the	“License”),	for	such	time	until	either	You	or	Whiskers	Away	terminates	this	EULA.	You	must	in	no	event	use,	nor	allow	others	to	use,	the	APP	or	this	License	for	commercial	purposes	without	obtaining	a	license	to	do	so	from	Whiskers	Away.	Updates,	upgrades,	patches	and	modifications	may	be	necessary	in	order	to	be	able	to	continue	to	use	the	APP	on	certain	hardware.\n\n"
        // "Please	take	a	few	moments	to	read	the	Terms	and	Conditions	carefully	in	regard	to	the	use	of	our	service	(“the	Service”)	including	all	of	our	App	(the	“App”)."
      ];

  Future<dynamic> signup() async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      Map<String, dynamic> payload = _authService.signupUser;

      final data = {
        'license_img': Dio.MultipartFile.fromBytes(
          payload['license_img'].readAsBytesSync(),
          filename: payload['license_img'].path.split('/').last,
        ),
      };
      final res = await _apiService.uploadLicenseImage(data);
      res.when(
        success: (data) async {
          if (data['url'] != null) {
            User user = new User(
                name: payload['name'],
                email: payload['email'],
                password: payload['password'],
                phone: payload['phone'],
                address: payload['address'],
                location: payload['location'],
                username: payload['username'],
                description: payload['description'] != null
                    ? payload['description']
                    : "",
                roleId: _authService.getRoleById(),
                licenseImg: data['url']);
            ApiResult apiResult = await _apiService.register(user);

            NavService.popOut;
            // Navigator.of(ctx, rootNavigator: true).pop();

            apiResult.when(success: (data) {
              showSuccessAlert();
              AppUtils.toastShow("User Registered Successfully");
            }, failure: (NetworkExceptions error) {
              AppUtils.toastShow("Unsuccessful Registration !");
              showErrorAlert(error);
            });
          }
          notifyListeners();
        },
        failure: (error) {
          print(error.toString());
        },
      );

      setBusy(false);
    } catch (e) {
      NavService.popOut;

      setBusy(false);
    }
  }

  showSuccessAlert() {
    dialogService.showDialog(
      title: 'Success',
      description:
          'Congratulations, your account has been created successfully.',
      buttonTitle: 'Okay',
      buttonTitleColor: AppColors.primaryColor,
    );
    Timer(Duration(seconds: 2), () {
      NavService.loginReplace();
    });
  }

  showErrorAlert(e) {
    dialogService.showDialog(
      title: 'Error Occurred',
      description: NetworkExceptions.getErrorMessage(e),
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }
}
