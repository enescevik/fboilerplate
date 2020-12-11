import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DropdownComponent extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String title;

  DropdownComponent({
    @required this.value,
    @required this.items,
    @required this.onChanged,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      title == null
          ? Container()
          : Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(title, style: Theme.of(context).textTheme.subtitle1),
            ),
      Expanded(
        child: DropdownButton(
          value: value,
          items: items,
          isExpanded: true,
          onChanged: onChanged,
          hint: Text('widget.choose'.tr()),
        ),
      ),
    ]);
  }
}
