import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({
    required this.tabs,
    required this.onChanged,
    this.active,
    required this.pagesContent,
  });

  final List<String> tabs;
  final ValueChanged<String> onChanged;
  final String? active;
  final List<Widget> pagesContent;

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
    if (changePage) {
      pageController.animateToPage(
        widget.tabs.indexOf(activeTab),
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      notifier.value = activeTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            margin: AppBaseStyles.horizontalPadding,
            child: ValueListenableBuilder<String>(
              valueListenable: notifier,
              builder: (_, String value, child) {
                return _Tabs(
                  tabs: widget.tabs,
                  active: value,
                  onSelectTab: (val) => onTabChanged(val, changePage: true),
                );
              },
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.06),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              children: widget.pagesContent,
              onPageChanged: onTabChanged,
              controller: pageController,
            ),
          )
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
  });
  final List<String> tabs;
  final String? active;
  final ValueChanged<String> onSelectTab;

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
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    value,
                    style: AppTextStyles.xxLarge(
                      weight: FontWeight.w500,
                      color: isActive ? Colors.white : AppColors.primaryColor,
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
