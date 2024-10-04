import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class MyDropdown extends StatefulWidget {
  String? selectedValue;

  final List<dynamic> address;
  final String name;
  final String Function(dynamic) getValue;
  final String Function(dynamic) getLabel;
  final bool Function(dynamic)? filterAddress;
  final ValueChanged<String?> onChanged;
  bool isEnable;

  MyDropdown(
      {super.key,
      required this.address,
      required this.selectedValue,
      required this.getValue,
      this.isEnable = true,
      required this.getLabel,
      this.filterAddress,
      required this.name,
      required this.onChanged});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Text(widget.name),
        value: widget.selectedValue,
        isExpanded: true,
        onChanged: widget.isEnable ? widget.onChanged : null,
        items: widget.isEnable
            ? widget.address
                .where((address) => widget.filterAddress?.call(address) ?? true)
                .map((address) {
                return DropdownMenuItem<String>(
                  value: widget.getValue(address),
                  child: Text(widget.getLabel(address)),
                );
              }).toList()
            : [],
        buttonStyleData: ButtonStyleData(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.kLine,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          scrollbarTheme: const ScrollbarThemeData(
            radius: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}
