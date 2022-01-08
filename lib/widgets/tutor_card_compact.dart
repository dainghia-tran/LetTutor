import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';

class TutorCardCompat extends StatelessWidget {
  const TutorCardCompat(
      {Key? key,
      required this.tutorName,
      required this.national,
      required this.avatar})
      : super(key: key);
  final tutorName;
  final national;
  final avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CustomCircleAvatar(
            avatarUrl: avatar,
            dimension: 50,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tutorName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              CountryCodePicker(
                initialSelection: national,
                showOnlyCountryWhenClosed: true,
                enabled: false,
                padding: const EdgeInsets.all(0),
                alignLeft: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}
