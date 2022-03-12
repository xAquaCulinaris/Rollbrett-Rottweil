import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/course_preview/detailedView.dart';
import 'package:rollbrett_rottweil/course_preview/obstacles.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

import 'package:flutter_blue/flutter_blue.dart';

import 'widgets/ObstacleListViewItem.dart';

class CoursePreview extends StatefulWidget {
  final FlutterBlue ble = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = [];

  @override
  _CoursePreviewState createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  CoursePreviewObstaclesProvider obstaclesProvider;

  @override
  void initState() {
    super.initState();
    widget.ble.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.ble.startScan();
  }

  @override
  Widget build(BuildContext context) {
    obstaclesProvider = Provider.of<CoursePreviewObstaclesProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            text: AppLocalizations.of(context).translate('course_preview'),
          ),
          _obstacleList()
        ],
      ),
    );
  }

  _obstacleList() {
    int i = 0;
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: obstaclesProvider.obstacles.length ~/ 2,
          itemBuilder: (BuildContext context, int index) {
            i += 2;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ObstacleListViewItem(obstaclesProvider.obstacles[i - 2]),
                ObstacleListViewItem(obstaclesProvider.obstacles[i - 1])
              ],
            );
          }),
    );
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      widget.devicesList.add(device);
      obstaclesProvider.addUidInRange(device.id.toString());
      print("device id: " + device.id.toString());
    }
  }
}
