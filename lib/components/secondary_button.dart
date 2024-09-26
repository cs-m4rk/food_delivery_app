import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SecondaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String? text, icons;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? textColor, bgColor;
  final double? iconWidth;
  final double? iconHeight;
  final Color? borderColor;
  const SecondaryButton(
      {super.key,
      required this.onTap,
      this.text,
      this.width,
      this.height,
      this.icons,
      this.borderRadius,
      this.fontSize,
      this.textColor,
      this.bgColor,
      this.iconWidth,
      this.iconHeight,
      this.borderColor});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 5,
          child: Container(
            height: widget.height ?? 55,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              border:
                  Border.all(color: widget.borderColor ?? Colors.transparent),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.icons ?? "",
                  width: widget.iconWidth,
                  height: widget.iconHeight,
                ),
                Text(
                  widget.text ?? "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w700,
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
