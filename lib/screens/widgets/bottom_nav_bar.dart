import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;

  final double iconSize;

  final Color backgroundColor;

  final bool showElevation;

  final Duration animationDuration;

  final List<BottomNavyBarItem> items;

  final ValueChanged<int> onItemSelected;

  final MainAxisAlignment mainAxisAlignment;

  final double itemCornerRadius;

  final double containerHeight;

  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        boxShadow: [
          if (showElevation) const BoxShadow(blurRadius: 5),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key key,
    @required this.item,
    @required this.isSelected,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    @required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 200 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withOpacity(0.2)
              : Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 200 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : Theme.of(context).textTheme.bodyText1.color),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                          maxLines: 1,
                          textAlign: item.textAlign,
                          child: item.title),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem(
      {@required this.icon,
      @required this.title,
      this.activeColor = Colors.blue,
      this.textAlign = TextAlign.center,
      this.inactiveColor});

  final Widget icon;

  final Widget title;

  final Color activeColor;

  final Color inactiveColor;

  final TextAlign textAlign;
}
