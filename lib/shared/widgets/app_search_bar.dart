// lib/shared/widgets/app_search_bar.dart
import 'package:flutter/material.dart';

import '../../core/theme/app_dimensions.dart';
import 'app_text_field.dart';

class AppSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? hint;

  const AppSearchBar({
    super.key,
    required this.onChanged,
    this.hint,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label: '',
            hint: widget.hint ?? 'Search...',
            controller: _controller,
            prefixIcon: Icons.search,
            onChanged: (value) {
              setState(() {});
              widget.onChanged(value);
            },
          ),
        ),
        if (_controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.spacingSm),
            child: IconButton(
              icon: Icon(Icons.clear, size: AppDimensions.iconSizeMd),
              onPressed: () {
                _controller.clear();
                setState(() {});
                widget.onChanged('');
              },
            ),
          ),
      ],
    );
  }
}
