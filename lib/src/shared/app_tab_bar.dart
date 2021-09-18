import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({
    required this.tabs,
    required this.onChanged,
    this.active,
    required this.pagesContent,
    this.customTab,
  })  : hasNoPageScrolling = tabs.length > 2,
        assert(pagesContent.length > 0);

  final List<String> tabs;
  final ValueChanged<String> onChanged;
  final String? active;
  final List<Widget> pagesContent;
  final Widget Function(bool isActive, String val)? customTab;
  final bool? hasNoPageScrolling;

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  late String activeTab;
  late PageController pageController;
  late ValueNotifier<String> notifier;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    activeTab = widget.active ?? widget.tabs[0];
    notifier = ValueNotifier(activeTab);
  }

  void onTabChanged(dynamic val, {bool changePage = false}) {
    activeTab = val is int ? widget.tabs[val] : val;
    widget.onChanged(activeTab);
    if (!widget.hasNoPageScrolling!) {
      if (changePage) {
        pageController.animateToPage(
          widget.tabs.indexOf(activeTab),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        notifier.value = activeTab;
      }
    } else {
      notifier.value = activeTab;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: widget.customTab != null
                ? AppBaseStyles.horizontalPadding
                : EdgeInsets.zero,
            child: AppBaseCard(
              plainDisplay: widget.customTab != null,
              padding: EdgeInsets.all(6),
              margin: AppBaseStyles.horizontalPadding,
              child: ValueListenableBuilder<String>(
                valueListenable: notifier,
                builder: (_, String value, child) {
                  return _Tabs(
                    customTab: widget.customTab,
                    tabs: widget.tabs,
                    active: value,
                    onSelectTab: (val) => onTabChanged(val, changePage: true),
                  );
                },
              ),
            ),
          ),
          if (!widget.hasNoPageScrolling!)
            Expanded(
              child: PageView(
                children: widget.pagesContent,
                onPageChanged: onTabChanged,
                controller: pageController,
              ),
            )
          else if (widget.tabs.indexOf(activeTab) <=
              widget.pagesContent.length - 1)
            Expanded(child: widget.pagesContent[widget.tabs.indexOf(activeTab)])
        ],
      ),
    );
  }
}

class _Tabs extends StatefulWidget {
  const _Tabs({
    required this.tabs,
    this.active,
    required this.onSelectTab,
    this.customTab,
  });
  final List<String> tabs;
  final String? active;
  final ValueChanged<String> onSelectTab;
  final Widget Function(bool isActive, String val)? customTab;

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<_Tabs> {
  late String activeTab;

  @override
  void initState() {
    super.initState();
    activeTab = widget.active ?? widget.tabs[0];
  }

  @override
  void didUpdateWidget(covariant _Tabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active != activeTab) {
      onTabChanged(widget.active!, parentCalled: true);
    }
  }

  void onTabChanged(String val, {bool parentCalled = false}) {
    if (!parentCalled) widget.onSelectTab(val);
    setState(() => activeTab = val);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.tabs.length,
        (index) {
          final value = widget.tabs[index];
          final isActive = activeTab == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(value),
              child: widget.customTab != null
                  ? widget.customTab!(isActive, value)
                  : AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          value,
                          style: AppTextStyles.xxLarge(
                            weight: FontWeight.w500,
                            color: isActive
                                ? Colors.white
                                : AppColors.primaryColor,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
