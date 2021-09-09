import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class ReadMoreScrollableContent extends StatefulWidget {
  const ReadMoreScrollableContent({
    required this.contentLength,
    this.contentSeparator,
    required this.contentItemBuilder,
  });

  final int contentLength;
  final Widget? contentSeparator;
  final Widget Function(BuildContext, int) contentItemBuilder;

  @override
  _ReadMoreScrollableContentState createState() =>
      _ReadMoreScrollableContentState();
}

class _ReadMoreScrollableContentState extends State<ReadMoreScrollableContent> {
  final scrollCtrl = ScrollController();
  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();
  bool showMoreDisplay = false;
  bool readMoreContent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (scrollCtrl.position.maxScrollExtent > 0.0)
        setState(() => showMoreDisplay = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.separated(
      physics: scrollPhysics,
      padding: EdgeInsets.zero,
      controller: scrollCtrl,
      itemBuilder: widget.contentItemBuilder,
      separatorBuilder: (_, __) => widget.contentSeparator ?? VerticalSpacing(),
      itemCount: widget.contentLength,
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: readMoreContent ? Scrollbar(child: list) : list),
          if (showMoreDisplay) ...[
            VerticalSpacing(16),
            GestureDetector(
              onTap: () {
                setState(() {
                  readMoreContent = true;
                  scrollPhysics = ScrollPhysics();
                  showMoreDisplay = false;
                });
              },
              child: Text(
                'Read more',
                style: AppTextStyles.xMedium(color: AppColors.primaryColor)
                    .copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
