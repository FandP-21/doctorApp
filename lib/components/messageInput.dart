import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class MessageInput extends StatefulWidget {
  MessageInput({
    this.hintText,
    this.onCameraPressed,
    this.onMicPressed,
    this.onMicReleased,
    this.onImagePressed,
    this.controller,
  });
  final String hintText;
  final GestureTapCallback onCameraPressed;
  final GestureTapCallback onImagePressed;
  final GestureDragDownCallback onMicPressed;
  final GestureDragEndCallback onMicReleased;
  final TextEditingController controller;
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: textGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(65),
        ),
        child: TextFormField(
          style: TextStyle(
            color: inputGrey,
            fontSize: pixel16,
            fontWeight: semiBold,
          ),
          controller: widget.controller,
          cursorColor: darkBlue,
          minLines: 1,
          maxLines: 3,
          decoration: InputDecoration(
              fillColor: Color(0xffF3F4F8),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(65),
                gapPadding: 20,
              ),
              contentPadding:
                  EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(65),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: inputGrey,
                fontSize: pixel14,
                fontStyle: FontStyle.italic,
                fontWeight: semiBold,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxWidth: 55, maxHeight: 26),
              prefixIcon: GestureDetector(
                  onTap: widget.onCameraPressed,
                  child: Container(
                      width: 55,
                      child: Image.asset('assets/images/camera.png'))),
              suffixIconConstraints:
                  BoxConstraints(maxWidth: 82, maxHeight: 26),
              suffixIcon: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    GestureDetector(
                      onPanDown: widget.onMicPressed,
                      onPanEnd: widget.onMicReleased,
                      child: Icon(
                        Icons.mic,
                        color: blue,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.onImagePressed,
                      child: Icon(
                        Icons.image,
                        color: blue,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
