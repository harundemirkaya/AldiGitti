// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:aldigitti/Models/UserModel.dart';
import 'package:aldigitti/ViewModels/PersonalInformationViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  late final UserModel? currentUser;
  final personalInfoVM = PersonalInformationViewModel();

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    currentUser = await personalInfoVM.getCurrentUserInfo();
    if (currentUser != null) {
      _nameController.text = currentUser!.name ?? '';
      _surnameController.text = currentUser!.surname ?? '';
      _genderController.text = currentUser!.gender ?? '';
      _birthDateController.text = currentUser!.birthDate ?? '';
      _mailController.text = currentUser!.email ?? '';
      _phoneNumberController.text = currentUser!.telephoneNumber ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryNavigationBar(
            backButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kişisel Bilgilerini Düzenle",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryTextField(
                      controller: _nameController,
                      icon: Icons.person,
                      placeholderText: "Ad",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _surnameController,
                      icon: Icons.person,
                      placeholderText: "Soyad",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _genderController,
                      icon: Icons.female,
                      placeholderText: "Cinsiyet",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _birthDateController,
                      icon: Icons.calendar_today,
                      placeholderText: "Doğum Tarihi",
                      isDateField: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _mailController,
                      icon: Icons.call,
                      placeholderText: "Mail Adresi",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _phoneNumberController,
                      icon: Icons.call,
                      placeholderText: "Telefon Numarası",
                      isTelephoneNumber: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryNextButton(
                      buttonText: "Güncelle",
                      onPressed: () async {
                        UserModel updatedUser = UserModel(
                          uid: currentUser!.uid,
                          name: _nameController.text,
                          surname: _surnameController.text,
                          gender: _genderController.text,
                          birthDate: _birthDateController.text,
                          email: _mailController.text,
                          telephoneNumber: _phoneNumberController.text,
                        );
                        await personalInfoVM.updateUserInfo(updatedUser);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Başarılı"),
                              content: Text(
                                "Kişisel Bilgileriniz Başarıyla Güncellendi",
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Tamam'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      isDoubleInfinity: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
