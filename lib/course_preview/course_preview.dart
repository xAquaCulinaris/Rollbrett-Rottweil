import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

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
          height: MediaQuery.of(context).size.height / 4.2,
          width: MediaQuery.of(context).size.width / 2.7,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: AssetImage('assets/images/rollbrett_rottweil.jpg'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
