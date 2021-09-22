import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/my_availability/my_availability_view_model.dart';

class MyAvailabilityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAvailabilityViewModel>.nonReactive(
      viewModelBuilder: () => MyAvailabilityViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final MyAvailabilityViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppHeading(text: 'My Availability'),
              ImageDisplayBox(
                size: 30,
                imgUrl: "assets/images/profile_pic.jpg",
              ),
            ],
          ),
        ),
        VerticalSpacing(20),
        Expanded(
          child: ListView(
            padding: AppBaseStyles.horizontalPadding,
            children: [
              SfDateRangePicker(
                minDate: DateTime.now(),
                view: DateRangePickerView.month,
                headerHeight: 0,
                selectionMode: DateRangePickerSelectionMode.range,
                startRangeSelectionColor: AppColors.primaryColor,
                rangeTextStyle: AppTextStyles.xxMedium(color: Colors.white),
                todayHighlightColor: Colors.transparent,
                selectionTextStyle: AppTextStyles.xxMedium(color: Colors.white),
                rangeSelectionColor: AppColors.primaryColor,
                endRangeSelectionColor: AppColors.primaryColor,
                navigationDirection:
                    DateRangePickerNavigationDirection.horizontal,
                enableMultiView: false,
                enablePastDates: false,
                selectionShape: DateRangePickerSelectionShape.rectangle,
                monthCellStyle: DateRangePickerMonthCellStyle(
                  cellDecoration: _MonthCellDecoration(
                    borderColor: null,
                    backgroundColor: Colors.white,
                    showIndicator: false,
                  ),
                  todayCellDecoration: _MonthCellDecoration(
                    backgroundColor: AppColors.primaryColor,
                    showIndicator: false,
                    indicatorColor: Colors.red,
                  ),
                  specialDatesDecoration: _MonthCellDecoration(
                    borderColor: null,
                    backgroundColor: Colors.black,
                    showIndicator: true,
                    indicatorColor: Colors.red,
                  ),
                  todayTextStyle: AppTextStyles.xxMedium(color: Colors.white),
                  textStyle: AppTextStyles.xxMedium(),
                ),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true,
                  enableSwipeSelection: false,
                ),
                toggleDaySelection: false,
              ),
              VerticalSpacing(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'October',
                    style: AppTextStyles.xLarge(
                      weight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    IconlyLight.edit,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              VerticalSpacing(16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      IconlyLight.calendar,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    HorizontalSpacing(6),
                    Text(
                      'Oct. 11 - 14',
                      style: AppTextStyles.xxLarge(
                        color: AppColors.primaryColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Unavailable',
                      style: AppTextStyles.xxLarge(
                        color: AppColors.primaryColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryColor),
                ),
              ),
              VerticalSpacing(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        HorizontalSpacing(12),
                        Text(
                          'Add Availability',
                          style: AppTextStyles.xxLarge(
                            color: Colors.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    text: '',
                  ),
                ],
              ),
              VerticalSpacing(16),
              AppBaseCard(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    AppTextField(
                      readOnlyField: true,
                      hintText: 'Wednesday, October 10',
                      label: 'Start Date',
                      suffixIcon: IconlyLight.calendar,
                    ),
                    VerticalSpacing(),
                    AppTextField(
                      readOnlyField: true,
                      hintText: 'Wednesday, October 12',
                      label: 'End Date',
                      suffixIcon: IconlyLight.calendar,
                    ),
                    VerticalSpacing(16),
                    Padding(
                      padding: AppBaseStyles.horizontalPadding,
                      child: Row(
                        children: [
                          AppButton(
                            text: 'Accept',
                            fullWidth: true,
                            onPressed: () {},
                          ),
                          HorizontalSpacing(18),
                          AppButton(
                            text: 'Reject',
                            type: AppButtonType.outline,
                            fullWidth: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              VerticalSpacing(20),
            ],
          ),
        ),
      ],
    );
  }
}

/// [_MonthCellDecoration] used to customize the month cell
/// background of [SfDateRangePicker].
/// [backgroundColor] property used to draw the fill color the month cell
/// [borderColor] property used to draw the border to highlight the
/// today month cell.
/// [showIndicator] property used to decide whether the cell
/// have indicator or not.
/// it is enabled then draw the circle on right top corner
/// with [indicatorColor].
class _MonthCellDecoration extends Decoration {
  const _MonthCellDecoration(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MonthCellDecorationPainter(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor);
  }
}

/// [_MonthCellDecorationPainter] used to paint month cell decoration.
class _MonthCellDecorationPainter extends BoxPainter {
  _MonthCellDecorationPainter(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    final Paint paint = Paint()..color = backgroundColor!;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    if (borderColor != null) {
      paint.color = borderColor!;
      canvas.drawRRect(
          RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    }

    if (showIndicator) {
      paint.color = indicatorColor!;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bounds.right - 6, bounds.top + 6), 2.5, paint);
    }
  }
}
