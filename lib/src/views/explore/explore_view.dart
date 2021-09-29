import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_listing_card.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view_model.dart';
import 'package:whiskers_away_app/src/views/explore/search_widget/search_bar.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      onModelReady: (model) {
        model.getExploreJobs();
      },
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final ExploreViewModel model;
  _Body(this.model);

  bool? get mounted => null;

  String query = '';
  Timer? debouncer;
  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    // contains(obj, query) {
    //   var check = query.toLowerCase();
    //   var name = obj.name;
    //   if (name.toLowerCase().includes(check)) {
    //     return true;
    //   }
    //   return false;
    // }

    handleSearch(text) async {
      print(text);
      // var filteredData = [];
      // String query = text;
      // // let obj = {};
      // var filterr;
      // filteredData =
      //     await filterr(model.newJobs, (obj) => {contains(obj, query)});
      // if (filteredData.length == 0) {
      //   Timer(Duration(seconds: 1), () {
      //     print(text);
      //   });

      //   // setTimeout(() => {
      //   //   Toast.show(`${Languages.nosearchTipster} ${text}`);
      //   // }, 1500)
      // }
      // setSearchState(filteredData);
    }

    return Column(
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeHeading(name: model.user?.name ?? ''),
              GestureDetector(
                onTap: NavService.userProfile,
                child: ImageDisplayBox(
                  size: 50,
                  imgUrl: model.user!.profileImg,
                  assetDefaultImage: "profile.png",
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(14),
        buildSearch(),
        !model.isBusy
            ? Expanded(
                child: model.newJobs.length > 0
                    ? ListView.separated(
                        padding: AppBaseStyles.horizontalPadding
                            .copyWith(bottom: 16, top: 16),
                        itemBuilder: (_, index) {
                          final request = model.newJobs[index];
                          return GestureDetector(
                            onTap: () => NavService.petDetails(
                              arguments: PetDetailsViewArguments(
                                request: request,
                                role: Roles.petSitter,
                              ),
                            ),
                            child: AppListingCard(
                              model,
                              request: request,
                              role: Role.PET_SITTER,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => VerticalSpacing(16),
                        itemCount: model.newJobs.length)
                    : Expanded(
                        child: Center(
                          child: Text(
                            "No Records Found...",
                            style: AppTextStyles.xLarge(
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
              )
            : Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
      ],
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );
  Future searchBook(String query) async => debounce(() async {
        print(query);
        // final books = await BooksApi.getBooks(query);

        // if (!mounted!) return;

        // setState(() {
        //   this.query = query;
        //   this.books = books;
        // });
      });

}
