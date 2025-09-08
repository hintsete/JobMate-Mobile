import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_mate/core/presentation/bloc/localization_bloc.dart';

class LanguageToggleButton extends StatelessWidget {
  final bool showLabel;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const LanguageToggleButton({
    super.key,
    this.showLabel = true,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        final isAmharic = state.locale.languageCode == 'am';

        if (showLabel) {
          return TextButton.icon(
            onPressed: () {
              context.read<LocalizationBloc>().toggleLanguage();

              // Show feedback message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isAmharic
                        ? 'Language changed to English'
                        : 'ቋንቋ ወደ አማርኛ ተቀይሯል',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(
              Icons.language,
              color: iconColor ?? Colors.black,
              size: 20,
            ),
            label: Text(
              isAmharic ? 'አማ' : 'EN',
              style: TextStyle(color: textColor ?? Colors.black, fontSize: 13),
            ),
          );
        } else {
          return IconButton(
            onPressed: () {
              context.read<LocalizationBloc>().toggleLanguage();

              // Show feedback message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isAmharic
                        ? 'Language changed to English'
                        : 'ቋንቋ ወደ አማርኛ ተቀይሯል',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.language, color: iconColor ?? Colors.black),
          );
        }
      },
    );
  }
}
