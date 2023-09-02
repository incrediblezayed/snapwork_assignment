import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:snapwork_assignment/src/app/providers/app_providers.dart';

class CreateEvent extends ConsumerWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(eventProvider);
    final theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: TextButton(
            child: Text(
              'Back',
              style: theme.textTheme.navTitleTextStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Date & Time')),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                                child: CupertinoTextField(
                              placeholder: 'HH:MM',
                              onTap: () async {
                                provider.pickTime(context);
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                  text: provider.pickedTime),
                            )),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(DateFormat('dd-MMM-yyyy')
                                .format(provider.pickedDateTime!)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('Title'),
                      ),
                      Expanded(
                        flex: 3,
                        child: CupertinoTextField(
                          controller: provider.titleController,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Desciption'),
                  const SizedBox(height: 8),
                  CupertinoTextField(
                    controller: provider.descriptionController,
                    maxLines: 4,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.zero,
              onPressed: () {
                provider.createEvent(() => Navigator.pop(context));
              },
              minSize: 60,
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}
