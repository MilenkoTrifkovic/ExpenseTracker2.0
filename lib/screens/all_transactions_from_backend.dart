import 'package:expense_tracker_2/providers/records_future_provider_from_backend.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:expense_tracker_2/widgets/record_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllTransactionsFromBackend extends ConsumerWidget {
  const AllTransactionsFromBackend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providedRecords = ref.watch(fetchConfigurationProvider);
    final MediaQuerySize = MediaQuery.sizeOf(context);
    // final MediaQueryData mediaQuery = MediaQuery.of(context);//the same Approach
    return Scaffold(
      appBar:
          AppBar(title: const Center(child: StyledHeading('All Transactions'))),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuerySize.width * 0.1),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    providedRecords.when(
                      data: (records) {
                        print("Records: $records");
                        return Expanded(
                          child: ListView.builder(
                            itemCount: records.length,
                            itemBuilder: (context, index) {
                              // Provide how each record is displayed
                              return RecordCard(
                                  transaction: records[index].transaction,
                                  icon: records[index].category.icon,
                                  description: records[index].description,
                                  price: records[index].price,
                                  date: records[index].date.toString());
                            },
                          ),
                        );
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(
                          child: Text(
                        ' $error',
                        style: const TextStyle(fontSize: 6),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
///////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';

// class ExpandedExample extends StatelessWidget {
//   const ExpandedExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Flexible(
//             flex: 1,
//             child: Container(
//               color: Colors.red,
//               height: 100,
//               child: const Center(child: Text('Flex 1')),
//             ),
//           ),
//           Container(
//             color: Colors.green,
//             height: 100,
//             width: 200,
//             child: const Center(child: Text('Fixed Width Container')),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.teal,
//               height: 100,
//               child: const Center(child: Text('Expanded')),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }//////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';

// class FractionallySizedBoxExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Center(
//         child: FractionallySizedBox(
//           widthFactor: 0.8, // Set the width of the child to 80% of the available width.
//           heightFactor: 0.5, // Set the height of the child to 50% of the available height.
//           child: Container(
//             color: Colors.green,
//             child: Center(
//               child: Text(
//                 'Hello, FractionallySizedBox!',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
