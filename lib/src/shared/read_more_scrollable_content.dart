import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class ReadMoreScrollableContent extends StatefulWidget {
  const ReadMoreScrollableContent({
    required this.contentLength,
    this.contentSeparator,
    required this.contentItemBuilder,
    this.readMoreCallback,
    this.readMoreContent = false,
  });

  final int contentLength;
  final Widget? contentSeparator;
  final Widget Function(BuildContext, int) contentItemBuilder;
  final ValueChanged<bool>? readMoreCallback;
  final bool? readMoreContent;

  @override
  _ReadMoreScrollableContentState createState() =>
      _ReadMoreScrollableContentState();
}

class _ReadMoreScrollableContentState extends State<ReadMoreScrollableContent> {
  final scrollCtrl = ScrollController();
  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();
  bool readMoreTextDisplay = false;
  late bool readMoreContent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (scrollCtrl.position.maxScrollExtent > 0.0) {
        readMoreContent = widget.readMoreContent!;
        if (readMoreContent) {
          scrollPhysics = ScrollPhysics();
        } else {
          readMoreTextDisplay = true;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.separated(
      physics: scrollPhysics,
      padding: EdgeInsets.only(right: 8),
      controller: scrollCtrl,
      itemBuilder: widget.contentItemBuilder,
      separatorBuilder: (_, __) => widget.contentSeparator ?? VerticalSpacing(),
      itemCount: widget.contentLength,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: readMoreContent
                ? Scrollbar(controller: scrollCtrl, child: list)
                : list),
        if (readMoreTextDisplay) ...[
          VerticalSpacing(16),
          GestureDetector(
            onTap: () {
              setState(() {
                readMoreContent = true;
                scrollPhysics = ScrollPhysics();
                readMoreTextDisplay = false;
              });
              if (widget.readMoreCallback != null)
                widget.readMoreCallback!(readMoreContent);
            },
            child: Text(
              'Read more',
              style:
                  AppTextStyles.xMedium(color: AppColors.primaryColor).copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ]
      ],
    );

    if (widget.readMoreCallback == null) {
      return Expanded(child: content);
    }

    return content;
  }
}
