import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/course_preview/detailedView.dart';
import 'package:rollbrett_rottweil/course_preview/provider/obstacle.dart';
import 'package:rollbrett_rottweil/course_preview/provider/obstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/ObstacleProvider.dart';

class SkateDiceDice extends StatefulWidget {
  SkateDiceDice({Key key}) : super(key: key);

  _SkateDiceDiceState state = _SkateDiceDiceState();

  @override
  _SkateDiceDiceState createState() => this.state = new _SkateDiceDiceState();
}

class _SkateDiceDiceState extends State<SkateDiceDice>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  String text = "";

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => _onDiceClick(),
        child: RotationTransition(
          turns: _animation,
          child: Container(
            height: MediaQuery.of(context).size.width / 2.3,
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: new BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
            ),
            child: Center(
                child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: _animationController,
                  child: child,
                );
              },
              child: Text(text,
                  key: ValueKey<String>(text),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 14,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
            )),
          ),
        ),
      ),
    );
  }

  void _onDiceClick() {
    //TODO get correct obstacle name 
    String obstacleLinkName = Provider.of<SkateDiceObstacleProvider>(context, listen: false).getObstacleLinkNameByName(text);
    Obstacle obstacle = Provider.of<CoursePreviewObstaclesProvider>(context, listen: false)
        .getObstacleByName(obstacleLinkName);
    if (obstacle != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailObstacleView(obstacle)));
    }
  }

  animate(String trickName) {
    _animationController.forward(from: 0);
    if (mounted) {
      setState(() {
        this.text = trickName;
      });
    }
  }
}
