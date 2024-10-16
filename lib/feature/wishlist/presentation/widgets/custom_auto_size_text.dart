import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomAutoSizeText extends StatelessWidget {
  const CustomAutoSizeText({
    this.maxLines,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textStyle,
    required this.data,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: textStyle,
    );
  }
}