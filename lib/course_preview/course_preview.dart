import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/course_preview/detailedView.dart';
import 'package:rollbrett_rottweil/course_preview/obstacles.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

import 'package:flutter_blue/flutter_blue.dart';

import 'widgets/ObstacleListViewItem.dart';

class CoursePreview extends StatefulWidget {
  @override
  _CoursePreviewState createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  CoursePreviewObstaclesProvider obstaclesProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return ObstacleView();
          }
          return BluetoothOffScreen(state: state);
        });
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomAppBar(
              text: AppLocalizations.of(context).translate('course_preview'),
            ),
            Spacer(),
            Icon(
              Icons.bluetooth_disabled,
              size: MediaQuery.of(context).size.width / 3,
              color: Colors.white54,
            ),
            Text('Bluetooth is required for this function'),
            Spacer()
          ],
        ),
      ),
    );
  }
}

class ObstacleView extends StatefulWidget {
  ObstacleView({Key key}) : super(key: key);

  final FlutterBlue ble = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = [];

  @override
  _ObstacleViewState createState() => _ObstacleViewState();
}

class _ObstacleViewState extends State<ObstacleView>
    with WidgetsBindingObserver {
  CoursePreviewObstaclesProvider obstaclesProvider;

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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    print("state changed");

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      widget.ble.stopScan();
      widget.devicesList.clear();
      obstaclesProvider.resetInRange();
      print("background called");
    } else {
      widget.ble.startScan();
      print("start again");
    }
  }

  @override
  void dispose() {
    widget.ble.stopScan();
    widget.devicesList.clear();
    obstaclesProvider.resetInRange();
    print("dispose called");
    super.dispose();
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
