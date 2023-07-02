import 'package:flutter/material.dart';
import 'package:the_hafleh/common/widgets/multi_select/constants.dart';
import 'package:the_hafleh/common/widgets/multi_select/multi_search_selection.dart';

class NationalityChoose extends StatefulWidget {
  final String title;
  // final String lastname;
  // final Function onChangeFirstname;
  // final Function onChangeLastname;
  const NationalityChoose({
    super.key,
    required this.title,
    // required this.lastname,
    // required this.onChangeFirstname,
    // required this.onChangeLastname,
  });

  @override
  // ignore: library_private_types_in_public_api
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
            onItemAdded: (c) {},
            showClearSearchFieldButton: true,
            items: countries,
            fieldToCheck: (c) {
              return c.name;
            },
            itemBuilder: (country, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
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
            selectAllButton: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select All',
                    style: kStyleDefault,
                  ),
                ),
              ),
            ),
            clearAllButton: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Clear All',
                    style: kStyleDefault,
                  ),
                ),
              ),
            ),
            caseSensitiveSearch: false,
            fuzzySearch: FuzzySearch.none,
            itemsVisibility: ShowedItemsVisibility.alwaysOn,
            showSelectAllButton: true,
            maximumShowItemsHeight: 200,
          ),
        ),
      ],
    );
  }
}
