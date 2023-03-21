import 'package:floating_tabbar/Models/tab_item.dart';
import 'package:flutter/material.dart';

class TopTabbar extends StatefulWidget {
  final List<TabItem> tabList;
  final int initialIndex;
  final Decoration? indicator;
  final Color? labelColor;
  final Color? backgroundColor;
  const TopTabbar({
    Key? key,
    required this.tabList,
    this.initialIndex = 0,
    this.indicator,
    this.labelColor,
    this.backgroundColor,
  }) : super(key: key);
  @override
  _TopTabbarState createState() => _TopTabbarState();
}

class _TopTabbarState extends State<TopTabbar> with SingleTickerProviderStateMixin {
  List<String> getLabelList() {
    List<String> labelList = [];
    for (var element in widget.tabList) {
      Text? title = element.title as Text;
      String? titleString = title.data;
      labelList.add(titleString!);
    }
    return labelList;
  }

  List<Widget> getTabWidgetList() {
    List<Widget> tabWidgetList = [];
    for (var element in widget.tabList) {
      tabWidgetList.add(element.tab!);
    }
    return tabWidgetList;
  }

  TabController? controller;
  List<String> categories = [];
  final List<Tab> _tabs = [];

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (String e in categories) {
      _tabs.add(getTab(e));
    }
    return _tabs;
  }

  Tab getTab(String categoryname) {
    return Tab(text: categoryname);
  }

  @override
  void initState() {
    categories = getCategoryList();
    controller = TabController(length: categories.length, vsync: this, initialIndex: widget.initialIndex);
    getTabs(categories.length);

    super.initState();
  }

  List<String> getCategoryList() {
    List<String> list = getLabelList();
    return list;
  }

  AppBar customAppbarwithTabbar({TabController? controller, required BuildContext context, required List<Widget> tabs}) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? Colors.transparent,
      elevation: 0,
      bottom: TabBar(
        indicator: widget.indicator ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
        labelColor: widget.labelColor ?? Theme.of(context).primaryColor,
        controller: controller,
        tabs: tabs,
        isScrollable: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: customAppbarwithTabbar(controller: controller, tabs: _tabs, context: context),
      ),
      body: TabBarView(
        controller: controller,
        children: getTabWidgetList(),
      ),
    );
  }
}
