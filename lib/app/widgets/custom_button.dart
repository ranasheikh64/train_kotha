import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isLoading;
 
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.leading,
    this.width,
    this.height,
    this.borderRadius,
    this.isLoading = false,
   
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      child: ElevatedButton(
        
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          
          backgroundColor: backgroundColor ?? const Color(0xFF2C9E6A),
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
          side: backgroundColor == Colors.transparent || backgroundColor == Colors.white
              ? BorderSide(color: Colors.grey.shade200, width: 1)
              : BorderSide.none,
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: 12.w),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
