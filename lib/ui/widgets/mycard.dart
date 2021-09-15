import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final String url;
  final String text;
  const MyCard({Key? key, required this.url, required this.text})
      : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      widget.url,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0)
                  ])),
              height: 30,
              width: double.infinity,
              child: Center(child: Text(widget.text)),
            ),
          )
        ],
      ),
    );
  }
}

Widget getCard({required String url, required String text}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            url,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0)
                  ])),
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          )
        ],
      ),
    ),
  );
}


// Widget newCard() {
//   return Padding(
//         padding: EdgeInsets.all(4.w),
//         child: Stack(
//           children: [
//             Container(
//               child: Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(5.2.w),
//                   child: CachedNetworkImage(
//                       height: double.infinity,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Column(
//                             children: [
//                               Container(
//                                 height: 20.h,
//                                 child: CustomLoadingSpinKitRing(
//                                     loadingColor: themeColor),
//                               )
//                             ],
//                           ),
//                       imageUrl: moviePreview.imageUrl!,
//                       errorWidget: (context, url, error) => Column(
//                             children: [
//                               Container(
//                                 height: 20.h,
//                                 child: CustomLoadingSpinKitRing(
//                                     loadingColor: themeColor),
//                               )
//                             ],
//                           )),
//                 ),
//               ),
//               height: 30.h,
//               width: 40.w,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.w),
//                 color: Colors.black,
//               ),
//             ),
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(5.w),
//                       bottomRight: Radius.circular(5.w),
//                     ),
//                     color: kAppBarColor,
//                     boxShadow: kBoxShadow,
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(3.w),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Wrap(
//                                 children: [
//                                   // Text(" ",
//                                   //     style: kBoldTitleTextStyle),
//                                   // Text(
//                                   //     (moviePreview.year == "")
//                                   //         ? ""
//                                   //         : "(${moviePreview.year})",
//                                   //     style: kTitleTextStyle),
//                                 ],
//                               ),
//                             ),
//                             if (moviePreview.isFavorite)
//                               Icon(
//                                 Icons.bookmark_sharp,
//                                 size: 15.sp,
//                                 color: kInactiveButtonColor,
//                               ),
//                           ],
//                         ),
//                         SizedBox(height: 1.5.w),
//                         if (stars.length != 0) Row(children: stars),
//                         SizedBox(height: 1.w),
//                         Text(
//                           moviePreview.overview,
//                           style: kSubTitleCardBoxTextStyle,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 3,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
// }