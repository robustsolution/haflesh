// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hafleh/common/widgets/multi_select/constants.dart';
import 'package:hafleh/common/widgets/multi_select/multi_search_selection.dart';

class NationalityChoose extends StatefulWidget {
  final List<String> nation;
  final Function onChange;
  const NationalityChoose({
    super.key,
    required this.nation,
    required this.onChange,
  });

  @override
  _NationalityChooseState createState() => _NationalityChooseState();
}

class _NationalityChooseState extends State<NationalityChoose>
    with AutomaticKeepAliveClientMixin<NationalityChoose> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    List<String> nations = [];
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: MultipleSearchSelection<Country>(
            showClearAllButton: false,
            onItemAdded: (c) {
              if (count < 2) {
                count++;
                nations.add(c.name);
                widget.onChange(nations);
              } else {}
            },
            showClearSearchFieldButton: true,
            items: countries,
            fieldToCheck: (c) {
              return c.name;
            },
            itemBuilder: (country, index) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(country.name),
                  ),
                ),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(country.name),
                ),
              );
            },
            sortShowedItems: true,
            sortPickedItems: true,
            caseSensitiveSearch: false,
            fuzzySearch: FuzzySearch.none,
            itemsVisibility: ShowedItemsVisibility.alwaysOn,
            showSelectAllButton: true,
            maximumShowItemsHeight: 416,
          ),
        ),
      ],
    );
  }
}
