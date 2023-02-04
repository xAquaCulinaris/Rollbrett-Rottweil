import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/course_preview/provider/obstacle.dart';

import '../detailedView.dart';
import '../provider/obstacleProvider.dart';

class ObstacleListViewItem extends StatefulWidget {
  const ObstacleListViewItem(this.obstacle);
  final Obstacle obstacle;

  @override
  _ObstacleListViewItemState createState() => _ObstacleListViewItemState();
}

class _ObstacleListViewItemState extends State<ObstacleListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.2,
        width: MediaQuery.of(context).size.width / 2.2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailObstacleView(widget.obstacle)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.2,
                  width: MediaQuery.of(context).size.width / 2.7,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.obstacle.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: AssetImage(widget.obstacle.imagePath),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.obstacle.inRange == false) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height / 4.2,
                  width: MediaQuery.of(context).size.width / 2.2,
                  color: Colors.grey[800].withOpacity(0.7),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 64,
                    ),
                    Text(
                      "Out of range",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
