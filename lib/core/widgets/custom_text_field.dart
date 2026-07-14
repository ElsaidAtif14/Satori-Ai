import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? prefixIconAsset;
  final bool isPassword;
  final TextInputType keyboardType;
  final Color? fillColor;
  final Color? textColor;
  final void Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    this.fillColor,
    this.label = '',
    this.hintText = '',
    this.controller,
    this.prefixIconAsset,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textColor,
    this.onSaved,
    });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: GoogleFonts.cairo(
              color: const Color(0xFFB0B3B8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your ${widget.label}';
            }

            return null;
          },
          onSaved:widget.onSaved ,    
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          cursorColor: const Color(0xFF1A73E8),
          style: GoogleFonts.cairo(
            color: widget.textColor ?? Colors.black,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.cairo(
              color: const Color(0xFF555A64),
              fontSize: 15,
            ),
            prefixIcon: widget.prefixIconAsset != null
                ? Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      widget.prefixIconAsset!,
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8A8D93),
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFF8A8D93),
                      size: 22,
                    ),
                  )
                : null,
            filled: true,
            fillColor: widget.fillColor ?? const Color(0xFFffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF3A3F47),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF1A73E8),
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
