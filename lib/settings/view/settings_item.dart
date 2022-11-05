import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/dividers.dart';

class SettingsItem {
  static Widget spaceVertical(double height) {
    return SizedBox.fromSize(
      size: Size(1, height),
    );
  }

  static Widget spaceHorizontal(double width) {
    return SizedBox.fromSize(
      size: Size(width, 1),
    );
  }

  static Widget category(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceVertical(8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
        Dividers.horizontal(),
      ],
    );
  }

  static Widget title(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }

  static Widget categoryButtons(
    BuildContext context,
    VoidCallback onPrimaryAction, {
    String? primaryLabel,
    bool enablePrimary = true,
    String? secondaryLabel,
    bool enableSecondary = true,
    VoidCallback? onSecondaryAction,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _button(
            context,
            primaryLabel ?? MaterialLocalizations.of(context).saveButtonLabel,
            enablePrimary,
            onPrimaryAction,
          ),
          spaceHorizontal(16),
          _button(
            context,
            secondaryLabel ?? MaterialLocalizations.of(context).cancelButtonLabel,
            enableSecondary,
            onSecondaryAction,
          ),
        ],
      ),
    );
  }

  static Widget categoryButton(
    BuildContext context,
    VoidCallback onPrimaryAction, {
    String? primaryLabel,
    bool enablePrimary = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _button(
            context,
            primaryLabel ?? MaterialLocalizations.of(context).saveButtonLabel,
            enablePrimary,
            onPrimaryAction,
          ),
        ],
      ),
    );
  }

  static Widget _button(BuildContext context, String label, bool enable, VoidCallback? onPressed) {
    return OutlinedButton(
      onPressed: enable ? onPressed ?? () {} : null,
      child: Text(label),
    );
  }

  static Widget editor(
    BuildContext context,
    TextEditingController controller,
    String label, {
    String hint = '',
    String helpMessage = '',
    TextInputType inputType = TextInputType.text,
    int maxLength = 64,
    bool isSecret = false,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          spaceVertical(8),
          _helpMessage(context, helpMessage),
          spaceVertical(6),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
            keyboardType: inputType,
            obscureText: isSecret,
            readOnly: readOnly,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  static Widget _helpMessage(BuildContext context, String helpMessage) {
    return helpMessage.isNotEmpty
        ? Text(
            helpMessage,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.clip,
          )
        : const SizedBox.shrink();
  }

  static Widget dropdownMenu<T>(
    BuildContext context,
    String label,
    T selected,
    List<DropdownMenuData<T>> options,
    ValueChanged<T?>? onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          spaceVertical(6),
          DropdownButton<T>(
            style: Theme.of(context).textTheme.bodyMedium,
            isExpanded: false,
            items: _dropdownMenuItems(context, options),
            value: selected,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  static List<DropdownMenuItem<T>> _dropdownMenuItems<T>(
    BuildContext context,
    List<DropdownMenuData<T>> options,
  ) {
    return options.map((item) {
      return DropdownMenuItem<T>(
        value: item.key,
        child: Text(item.label),
      );
    }).toList();
  }
}

class DropdownMenuData<T> extends Equatable {
  const DropdownMenuData(this.key, this.label);

  final T key;
  final String label;

  @override
  List<Object?> get props => [key, label];
}
