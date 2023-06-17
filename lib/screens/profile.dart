import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/models/user_model.dart';
import 'package:memory_aid/provider/signin_provider.dart';
import 'package:memory_aid/widget/appbar_decoration.dart';
import 'package:memory_aid/widget/edit_profile.dart';
import 'package:memory_aid/widget/profile_details.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('users');
    final theme = Theme.of(context);
    return  Consumer<GoogleSignInProvider>(
          builder: (context, GoogleSignInProvider provider, _) {
        return SafeArea(
            child:  Scaffold(
                backgroundColor: theme.colorScheme.primary,
                appBar: AppBar(
                  //backgroundColor: theme.colorScheme.secondary,
                  toolbarHeight: 70,
                  flexibleSpace:const AppbarDecoration(),
                  centerTitle: true,
                  title: Text(
                    user != null ? '${user.displayName}' : 'User',
                    style:  TextStyle(color: theme.colorScheme.tertiary, fontSize: 20,fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          provider.logout();
                        },
                        icon:  Icon(
                          Icons.logout,
                          color: theme.colorScheme.tertiary,
                        ))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const EditProfile();
                        });
                  },
                  //Color.fromARGB(255, 182, 160, 218)
                  backgroundColor: theme.colorScheme.secondary,
                  child:  Icon(
                    Icons.edit,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'User Details',
                          style: TextStyle(
                              color: theme.colorScheme.secondary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                
                        DetailsTile(title: 'Name:', details: '${FirebaseAuth.instance.currentUser!.displayName}'),
                        const SizedBox(
                          height: 20,
                        ),
                        
                         DetailsTile(title: 'Email:', details: '${FirebaseAuth.instance.currentUser!.email}'),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: collection
                              .doc('${FirebaseAuth.instance.currentUser!.uid}')
                              .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error = ${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              var output = snapshot.data!.data();
                              var currentUser = UserProfile(
                                  uid: output!['uid'],
                                  age: output['age'],
                                  phNo: output['phno'],
                                  ctname: output['ct_name'],
                                  ctphno: output['ct_phno'],
                                  ctemail: output['ct_email']);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailsTile(title: 'Age:', details: currentUser.age),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  
                                  DetailsTile(title: 'Phone Number:', details: currentUser.phNo),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                   Text(
                                    'Care Taker Details',
                                    style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height:20,
                                  ),
                                  
                                  DetailsTile(title: 'Name:', details: currentUser.ctname),
                                  const SizedBox(
                                    height: 20,
                                  ),
                          
                                  DetailsTile(title: 'Phone Number:', details: currentUser.ctphno),
                                  const SizedBox(
                                    height: 20,
                                  ),
                            
                                  DetailsTile(title: 'Email:', details: currentUser.ctemail),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }
                                
                            return const Center(child: CircularProgressIndicator());
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            
          )
        ;
      })
    ;
  }
}
