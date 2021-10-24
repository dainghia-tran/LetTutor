import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime selectedDate = DateTime.now();
  var countryName = 'Vietnam';

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final List<String> levelItems = ['Beginer', 'Intermediate', 'Advanced'];
  var level = 'Beginer';

  final List<String> categories = ['TOEIC', 'TOEFL', 'IELTS', 'PET', 'KET', 'FLYERS'];
  var wantToLearn = 'IELTS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: const [
                        CustomCircleAvatar(
                            dimension: 75,
                            avatarUrl:
                                'https://cdn.dribbble.com/users/1003944/screenshots/10412487/dribbble_angry_4x.gif?compress=1&resize=400x300'),
                        Positioned(
                          child: Icon(Icons.camera_alt),
                          bottom: 0,
                          right: 0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Dai Nghia Tran',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'dainghia@gmail.com',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Birthday'),
              const SizedBox(
                height: 8,
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
                    Text(selectedDate.toString().split(' ')[0]),
                    IconButton(onPressed: () => _selectDate(context), icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey,))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Phone number'),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Country'),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () => showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    setState(() {
                      countryName = country.displayNameNoCountryCode;
                    });
                  },
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(countryName),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('My level'),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: level,
                    items: levelItems
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (selected) {
                      setState(() {
                        level = selected as String;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Want to Learn'),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: wantToLearn,
                    items: categories
                        .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (selected) {
                      setState(() {
                        wantToLearn = selected as String;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              PrimaryButtonRounded(isDisabled: false, onPressed: () => Navigator.of(context).pop(), text: 'Save')
            ],
          ),
        ),
      ),
    );
  }
}
