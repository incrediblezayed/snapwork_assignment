import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:snapwork_assignment/src/app/models/event_model.dart';
import 'package:snapwork_assignment/src/app/providers/app_providers.dart';
import 'package:snapwork_assignment/src/utils/routes.dart';
import 'package:snapwork_assignment/src/utils/themes.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(eventProvider);
    var theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      onPressed: () {
                        provider.selectYear(context);
                      },
                      child: Text((provider.year ?? 'Select Year').toString())),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      onPressed: () {
                        provider.selectMonth(context);
                      },
                      child: Text(
                          (provider.monthText ?? 'Select Month').toString())),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: provider.dates.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  EventModel? eventModel =
                      provider.getEventOfDate(provider.dates[index]);
                  return CupertinoListTile(
                    onTap: () {
                      provider.pickedDateTime = DateTime(provider.year!,
                          provider.month!, provider.dates[index]);
                      provider.currentEventModel = eventModel;
                      provider.editEvent();
                      Navigator.pushNamed(context, Routes.createEvents);
                    },
                    leadingSize: 60,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black,
                            fontSize: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(provider.dates[index].toString()),
                              Text(provider.getMonthByIndex(
                                  provider.month!, 'MMM'))
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          indent: 10,
                          endIndent: 10,
                          color: AppTheme.verticleDividerColor,
                        )
                      ],
                    ),
                    leadingToTitle: 0,
                    title: eventModel != null
                        ? Text(
                            DateFormat('hh:mm dd-MMM-yyyy')
                                .format(eventModel.dateTime),
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: CupertinoColors.black,
                                fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    subtitle: eventModel != null
                        ? Text(
                            eventModel.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: CupertinoColors.black,
                                fontSize: 16),
                          )
                        : null,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: .5,
                    color: AppTheme.dividerColor,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
