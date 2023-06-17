import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/models/user_model.dart';
import 'package:memory_aid/provider/profile_provider.dart';
import 'package:memory_aid/widget/textField.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phno = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController ct_phno = TextEditingController();
    TextEditingController ct_email = TextEditingController();
    TextEditingController ct_name = TextEditingController();
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textfield(controller: phno, label: 'User phno'),
              const SizedBox(
                height: 10,
              ),
              Textfield(controller: age, label: 'User age'),
              const SizedBox(
                height: 10,
              ),
              Textfield(controller: ct_name, label: 'CareTaker name'),
              const SizedBox(
                height: 10,
              ),
              Textfield(controller: ct_phno, label: 'CareTaker phno'),
              const SizedBox(
                height: 10,
              ),
              Textfield(controller: ct_email, label: 'CareTaker email'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .addProfile(UserProfile(
                            uid: '${FirebaseAuth.instance.currentUser!.uid}',
                            age: age.text,
                            phNo: phno.text,
                            ctname: ct_name.text,
                            ctphno: ct_phno.text,
                            ctemail: ct_email.text));
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
