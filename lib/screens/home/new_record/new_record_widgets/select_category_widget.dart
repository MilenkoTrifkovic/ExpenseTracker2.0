import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCategoryWidget extends ConsumerStatefulWidget {
  final TransactionStatus selectedTransactionStatus;
  final Function(TransactionCategory) changeCategory;
  final TransactionCategory selectedCategory;
  final TransactionStatus transactionStatus;
  const SelectCategoryWidget(
      {super.key,
      required this.selectedTransactionStatus,
      required this.changeCategory,
      required this.selectedCategory,
      required this.transactionStatus});

  @override
  ConsumerState<SelectCategoryWidget> createState() =>
      _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends ConsumerState<SelectCategoryWidget> {
  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final asyncCategories =
        widget.transactionStatus == TransactionStatus.expense
            ? ref.watch(expenseCategoriesProvider)
            : ref.watch(incomeCategoriesProvider);

    return Dialog(
      backgroundColor: AppColors.surfaceColor.withOpacity(0.90),
      // padding: const EdgeInsets.all(20),
      child: LayoutBuilder(builder: (context, constrains) {
        int crossAxisCount = (constrains.maxWidth / 150).floor();
        if (crossAxisCount > 4) {
          crossAxisCount = 4;
        }
        return Column(
          children: [
            const StyledTitle('Select one option'),
            const StyledText(text: 'Description Matching'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                children: [
                  const StyledText(text: '0%', textColor: Colors.white),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.white, AppColors.highlightColor],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
                  StyledText(text: '100%', textColor: AppColors.highlightColor),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: asyncCategories.when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // leading: ,
                            title: Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.changeCategory(data[index]);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Text('•',
                                        style: TextStyle(
                                            fontSize: 32,
                                            color: data[index].confidence != 0
                                                ? Color.lerp(
                                                    Colors.white,
                                                    AppColors.highlightColor,
                                                    data[index]
                                                        .confidence!
                                                        .clamp(0.0, 1.0),
                                                  )
                                                : Colors.white)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      data[index].icon,
                                      height: 30,
                                    ),
                                    Expanded(child: SizedBox()),
                                    StyledHeading(data[index].categoryName),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Text('Error'),
                    loading: () => Text('Loading'),
                  )),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}


//Attempts to create a grid view of buttons representing different categories, 
//The problem are inconsistent text sizes 
 
 // return GridView.count(
                      //     padding: const EdgeInsets.symmetric(horizontal: 40),
                      //     mainAxisSpacing: 80,
                      //     crossAxisSpacing: 80,
                      //     crossAxisCount: crossAxisCount,
                      //     children: data.map(
                      //       (e) {
                      //         print(
                      //             '${e.categoryName} confidence ${e.confidence}');
                      //         return Column(
                      //           children: [
                      //             Stack(
                      //               children: [
                      //                 Container(
                      //                   height: 100,
                      //                   child: ElevatedButton(
                      //                     style: ElevatedButton.styleFrom(
                      //                         foregroundColor: Colors.black,
                      //                         backgroundColor:
                      //                             Colors.white.withOpacity(0.5),
                      //                         shape: e.confidence != 0
                      //                             ? CircleBorder(
                      //                                 side: BorderSide(
                      //                                   color: Color.lerp(
                      //                                     Colors.white,
                      //                                     AppColors
                      //                                         .highlightColor,
                      //                                     e.confidence!
                      //                                         .clamp(0.0, 1.0),
                      //                                   )!,
                      //                                   width: 4.0,
                      //                                 ),
                      //                               )
                      //                             : const CircleBorder()),
                      //                     onPressed: () {
                      //                       setState(() {
                      //                         widget.changeCategory(e);
                      //                       });
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: const Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.center,
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         // Container(Transform.translate(offset: Offset((-(calculateTextWidth(e.categoryName, Theme.of(context).textTheme.bodyMedium!)/2)), -25),child: StyledText(text:  e.categoryName),)
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Positioned(bottom: -10, child: Text('data'))
                      //               ],
                      //             )
                      //           ],
                      //         );
                      //       },
                      //     ).toList());
 // GridView.count(
                      //     padding: const EdgeInsets.symmetric(horizontal: 40),
                      //     mainAxisSpacing: 80,
                      //     crossAxisSpacing: 80, // If needed, uncomment this line
                      //     crossAxisCount: crossAxisCount,
                      //     children:
                      // asyncCategories.when(
                      //   data: (data) {
                      //     return ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       foregroundColor: Colors.black,
                      //       backgroundColor: Colors.white.withOpacity(0.5),
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         widget.changeCategory(e);
                      //       });
                      //       Navigator.pop(context);
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         FittedBox(
                      //             child: Image.asset(
                      //           e.icon,
                      //           width: 50,
                      //           height: 50,
                      //         )),
                      //         FittedBox(
                      //           child: Text(
                      //             e.categoryName,
                      //             style: const TextStyle(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      //   },
                      //   error: (error, stackTrace) {},
                      //   loading: () {},
                      // )
                      // map((e) {
                      //   return ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       foregroundColor: Colors.black,
                      //       backgroundColor: Colors.white.withOpacity(0.5),
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         widget.changeCategory(e);
                      //       });
                      //       Navigator.pop(context);
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         FittedBox(
                      //             child: Image.asset(
                      //           e.icon,
                      //           width: 50,
                      //           height: 50,
                      //         )),
                      //         FittedBox(
                      //           child: Text(
                      //             e.categoryName,
                      //             style: const TextStyle(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      // }).toList(),
