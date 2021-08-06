import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/app_bar.dart';

class CoursePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            text: AppLocalizations.of(context).translate('course_preview'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ObstacleListViewItem(), ObstacleListViewItem()],
          )
        ],
      ),
    );
  }
}

class ObstacleListViewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        onPressed: () {
          print("test");
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 3.6,
          width: MediaQuery.of(context).size.width / 2.6,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "test",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                Image(image: AssetImage('assets/images/rail.jpg'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
