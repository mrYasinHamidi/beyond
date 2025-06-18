import 'package:animations/animations.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchDialogAppbar extends StatelessWidget {
  final bool isSearchModel;
  final Function(bool mode) onModelChange;
  final Function(String searchTerm) onSearching;

  const SearchDialogAppbar({
    super.key,
    required this.isSearchModel,
    required this.onModelChange,
    required this.onSearching,
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: !isSearchModel,
      transitionBuilder: (Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          fillColor: Colors.transparent,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          child: child,
        );
      },
      child: isSearchModel
          ? Row(
              key: ValueKey('searchBar'),
              children: [
                IconButton(onPressed: () => onModelChange(false), icon: Icon(Icons.close)),
                const Gap(16),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) =>
                        EasyDebounce.debounce('search', const Duration(milliseconds: 300), () => onSearching(value)),
                    decoration: InputDecoration(border: InputBorder.none, hintText: 'Search'),
                  ),
                ),
              ],
            )
          : Row(
              key: ValueKey('title'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text('Choose a country'),
                IconButton(onPressed: () => onModelChange(true), icon: Icon(Icons.search)),
              ],
            ),
    );
  }
}
