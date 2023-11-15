import 'package:flutter/material.dart';
import 'package:memory_aid/provider/search_provider.dart';
import 'package:memory_aid/widget/textField.dart';
import 'package:provider/provider.dart';

class SearchDialog extends StatefulWidget {
  final String text; 
  const SearchDialog({super.key,required this.text});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}


class _SearchDialogState extends State<SearchDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider=Provider.of<SearchProvider>(context,listen: false);
    TextEditingController qs = TextEditingController();
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<SearchProvider>(
                builder: (context, provider, _) => Column(
              children: [
                Text(
                  "Ask a Question",
                  style: TextStyle(color: theme.colorScheme.secondary),
                ),
                const SizedBox(
                  height: 20,
                ),
                Textfield(controller: qs, label: 'Title'),
                const SizedBox(
                  height: 20,
                ),
                provider.search ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary, // Set the background color
                    ),
                  onPressed: () async{
                      provider.setsearch(false);
                    provider.setres(await Provider.of<SearchProvider>(context,listen: false).questionQuery({"inputs":{
                        "question" : qs.text,
                        "context" : widget.text
                      }}));
                    print(provider.res);
                }, child: Text("Search",style: TextStyle(color: theme.colorScheme.tertiary),))  :
                 Column(
                    children: [
                      Text("Answer",style: TextStyle(color: theme.colorScheme.secondary),),
                      const SizedBox(height: 20,),
                      Text(provider.res,style: TextStyle(color: theme.colorScheme.primary),)
                    ],
                  ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
