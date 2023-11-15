import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:memory_aid/provider/summary_provider.dart';
import 'package:memory_aid/widget/search_dialog.dart';
import 'package:provider/provider.dart';

import '../../provider/search_provider.dart';
import '../../widget/appbar_decoration.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // String? selectedDate;
    // String selectedSummary = '';
    final collection = FirebaseFirestore.instance
        .collection('users/${FirebaseAuth.instance.currentUser!.uid}/summary')
        .orderBy('date', descending: true)
        .limit(7);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final data;
            String currentDate =
                DateFormat('yyyy-MM-dd').format(DateTime.now());
            final textId = FirebaseFirestore.instance
                .collection(
                    'users/${FirebaseAuth.instance.currentUser!.uid}/texts')
                .doc(currentDate);
            DocumentSnapshot snapshot = await textId.get();
            data = snapshot.data();
            String? available = data?['content'] as String?;
            final summary =
                await Provider.of<SummaryProvider>(context, listen: false)
                    .Summaryquery({"inputs": available});
            final summaryId = FirebaseFirestore.instance
                .collection(
                    'users/${FirebaseAuth.instance.currentUser!.uid}/summary')
                .doc(currentDate);
            summaryId.set(
                {'id': summaryId, 'summary': summary, 'date': currentDate});
          },
          backgroundColor: theme.colorScheme.secondary,
          child: const Icon(
            Icons.note_add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          flexibleSpace: const AppbarDecoration(),
          //backgroundColor:theme.colorScheme.secondary,
          centerTitle: true,
          title: const Text(
            'Summary',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          actions: [
            Tooltip(
              message: "Search",
              child: IconButton(
                  onPressed: () async {
                    final data;
                    Provider.of<SearchProvider>(context,listen:false).setsearch(true);
                    Provider.of<SearchProvider>(context,listen:false).setres("");
                    final textId = FirebaseFirestore.instance
                .collection(
                    'users/${FirebaseAuth.instance.currentUser!.uid}/texts')
                .doc(Provider.of<SummaryProvider>(context, listen: false)
                              .selectedDate);
            DocumentSnapshot snapshot = await textId.get();
            data = snapshot.data();
            String? available = data?['content'] as String?;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SearchDialog(text: available!);
                        });
                  },
                  icon: Icon(
                    Icons.search,
                    color: theme.colorScheme.tertiary,
                  )),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: StreamBuilder<QuerySnapshot>(
                stream: collection.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    if (documents.isEmpty) {
                      return Center(
                        child: Text(
                          'You have no summaries!!',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      );
                    }
                    List<DropdownMenuItem<String>> dropdownItems =
                        snapshot.data!.docs.map((doc) {
                      if (Provider.of<SummaryProvider>(context, listen: false)
                              .selectedDate ==
                          null) {
                        Provider.of<SummaryProvider>(context, listen: false)
                            .initselectedDate(doc['date']);
                        Provider.of<SummaryProvider>(context, listen: false)
                            .initselectedSummary(doc['summary']);
                        print(doc['summary']);
                      }
                      return DropdownMenuItem<String>(
                        value: doc.id,
                        child: Text(
                          doc['date'],
                          style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: theme.colorScheme.tertiary)),
                        ), // Replace 'date' with the field name representing the date in your document
                      );
                    }).toList();
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Consumer<SummaryProvider>(
                              builder: (context, SummaryProvider provider, _) =>
                                  Column(
                                children: [
                                  DropdownButton<String>(
                                      dropdownColor:
                                          theme.colorScheme.secondary,
                                      hint: Text(
                                        'Select Date',
                                        style: TextStyle(
                                            color: theme.colorScheme.tertiary),
                                      ),
                                      value: provider.selectedDate,
                                      onChanged: (newValue) {
                                        provider.setselectedDate(newValue!);
                                        provider.setselectedSummary(snapshot
                                            .data!.docs
                                            .firstWhere((doc) =>
                                                doc.id.trim() ==
                                                newValue.trim())['summary']);
                                      },
                                      items: dropdownItems)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Consumer<SummaryProvider>(
                              builder: (context, SummaryProvider provider, _) =>
                                  Text(
                                Provider.of<SummaryProvider>(context,
                                        listen: false)
                                    .selectedSummary!,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: theme.colorScheme.tertiary,
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
      ),
    );
  }
}
