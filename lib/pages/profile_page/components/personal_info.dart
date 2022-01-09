import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/pages/profile_page/profile_provider.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final commonInfoForm = GlobalKey<FormState>();
  bool isShowDatePicker = false;
  User? userData;
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  String? country;
  DateTime? birthday;
  List<String> specialties = [];
  List<String> levels = [
    "BEGINNER",
    "HIGHER_BEGINNER",
    "PRE_INTERMEDIATE",
    "INTERMEDIATE",
    "UPPER_INTERMEDIATE",
    "ADVANCED",
    "PROFICIENCY"
  ];
  String level = "BEGINNER";

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthday ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != birthday) {
      setState(() {
        birthday = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userData = widget.user;
      _nameController = TextEditingController(text: userData!.name);
      _phoneController = TextEditingController(text: userData!.phone);
      country = userData!.country;
      if (userData!.birthday != null) {
        List<String> dayStr = userData!.birthday!.split("-");
        if (dayStr.length == 3) {
          int year = int.tryParse(dayStr[0]) ?? 2000;
          int month = int.tryParse(dayStr[1]) ?? 1;
          int day = int.tryParse(dayStr[2]) ?? 1;
          birthday = DateTime(year, month, day);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: commonInfoForm,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 1),
                ),
                labelText: 'Name',
              ),
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name is required";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 1),
                ),
                labelText: 'Phone',
              ),
              controller: _phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone is required";
                }
                return null;
              },
              enabled: userData?.isPhoneActivated == true ? false : true,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const Text('National'),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                      ),
                    ),
                    child: CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        setState(() {
                          country = countryCode.toString();
                        });
                      },
                      initialSelection: country,
                      showOnlyCountryWhenClosed: true,
                      showCountryOnly: true,
                      alignLeft: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(birthday.toString().split(' ')[0]),
                IconButton(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Level',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black38,
                width: 1,
              ),
            ),
            child: DropdownButton(
              isExpanded: true,
              items: levels.map<DropdownMenuItem>((String selectedValue) {
                return DropdownMenuItem(
                  child: Text(selectedValue),
                  value: selectedValue,
                );
              }).toList(),
              value: level,
              onChanged: (dynamic newValue) {
                setState(() {
                  level = newValue;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 150,
                child: PrimaryButton(
                  isDisabled: false,
                  text: 'Save changes',
                  onPressed: () {
                    if (commonInfoForm.currentState!.validate()) {
                      ProfileProvider.of(context, listen: false)
                          .updatePersonalInfo(
                        context,
                        _nameController?.text ?? '',
                        _phoneController?.text,
                        country ?? '',
                        level,
                        birthday,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
