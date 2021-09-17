import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_tab_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/my_employees/my_employees_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class MyEmployeesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyEmployeesViewModel>.nonReactive(
      viewModelBuilder: () => MyEmployeesViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final MyEmployeesViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Padding(
      padding: AppBaseStyles.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(context.topSpace() + screenSize.height * .05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeading(text: 'My Employees'),
              VerticalSpacing(12),
              Text(
                'Month of March',
                style: AppTextStyles.xLarge(
                  color: AppColors.primaryColor,
                  weight: FontWeight.w500,
                ),
              )
            ],
          ),
          VerticalSpacing(),
          AppTabBar(
              tabs: model.weekDaysSequence,
              onChanged: (val) {},
              pagesContent: [SizedBox()],
              customTab: (isActive, value) {
                return Container(
                  decoration: BoxDecoration(
                    color:
                        isActive ? AppColors.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Text(
                        'Week of',
                        style: AppTextStyles.xxMedium(
                          color: isActive ? Colors.white : AppColors.gray,
                          weight: FontWeight.w300,
                        ),
                      ),
                      VerticalSpacing(4),
                      Text(
                        value,
                        style: AppTextStyles.xLarge(
                          weight: FontWeight.w500,
                          color: isActive ? Colors.white : AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                );
              }
              // Padding(
              //   padding: AppBaseStyles.horizontalPadding,
              //   child: Row(
              //     children: List.generate(model.weekDaysSequence.length, (index) {
              //       final seq = model.weekDaysSequence[index];
              //       return Expanded(
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: AppColors.primaryColor,
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //           padding: const EdgeInsets.all(14),
              //           child: Column(
              //             children: [
              //               Text(
              //                 'Week of',
              //                 style: AppTextStyles.xxMedium(
              //                   color: Colors.white,
              //                   weight: FontWeight.w300,
              //                 ),
              //               ),
              //               VerticalSpacing(4),
              //               Text(
              //                 seq,
              //                 style: AppTextStyles.xLarge(
              //                   weight: FontWeight.w500,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     }),
              //   ),
              // )
              // AppTabBar(
              //   onChanged: print,
              //   tabs: model.weekDaysSequence,
              //   pagesContent: List.generate(
              //     model.weekDaysSequence.length,
              //     (idx) {
              //       return Padding(
              //         padding: const EdgeInsets.only(top: 12),
              //         child: ListView.separated(
              //           shrinkWrap: true,
              //           padding: AppBaseStyles.horizontalPadding,
              //           itemBuilder: (_, index) {
              //             final sitter = model.petSittersList[index];
              //             return GestureDetector(
              //               onTap: NavService.employeeDetails,
              //               child: AppBaseCard(
              //                 padding: const EdgeInsets.all(8),
              //                 child: Row(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                       width: 60,
              //                       height: 60,
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(10),
              //                         color: AppColors.whisper,
              //                         image: DecorationImage(
              //                           image: AssetImage(sitter.imgUrl),
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                     ),
              //                     HorizontalSpacing(10),
              //                     Expanded(
              //                       child: Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Row(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Column(
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                 children: [
              //                                   Text(
              //                                     sitter.name,
              //                                     style: AppTextStyles.xLarge(
              //                                       weight: FontWeight.w500,
              //                                     ),
              //                                   ),
              //                                   VerticalSpacing(6),
              //                                 ],
              //                               ),
              //                               Icon(
              //                                 Icons.more_vert_rounded,
              //                                 color: AppColors.primaryColor,
              //                               ),
              //                             ],
              //                           ),
              //                           Text('Total Bookings'),
              //                           VerticalSpacing(2),
              //                           Row(
              //                             children: [
              //                               Icon(
              //                                 IconlyBold.bookmark,
              //                                 size: 16,
              //                                 color: AppColors.primaryColor,
              //                               ),
              //                               HorizontalSpacing(4),
              //                               Text(
              //                                 '10',
              //                                 style: AppTextStyles.xxMedium(
              //                                   color: AppColors.darkGray,
              //                                 ),
              //                               ),
              //                               Spacer(),
              //                               Icon(
              //                                 IconlyBold.location,
              //                                 size: 16,
              //                                 color: AppColors.primaryColor,
              //                               ),
              //                               HorizontalSpacing(4),
              //                               Text(
              //                                 sitter.location,
              //                                 style: AppTextStyles.xxMedium(
              //                                   color: AppColors.darkGray,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //           separatorBuilder: (_, __) => VerticalSpacing(16),
              //           itemCount: idx % 2 == 1
              //               ? model.petSittersList.length - 4
              //               : model.petSittersList.length,
              //         ),
              //       );
              //     },
              //   ),
              // ),
              ),
        ],
      ),
    );
  }
}
