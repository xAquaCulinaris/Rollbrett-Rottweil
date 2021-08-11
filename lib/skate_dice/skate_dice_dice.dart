import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';

class SkateDiceDice extends StatefulWidget {
  SkateDiceDice({Key key}) : super(key: key);

  final _SkateDiceDiceState state = _SkateDiceDiceState();

  @override
  _SkateDiceDiceState createState() => state;
}

class _SkateDiceDiceState extends State<SkateDiceDice>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  String trickName = "";

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
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
      child: RotationTransition(
        turns: _animation,
        child: Container(
          height: MediaQuery.of(context).size.width / 2.3,
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
          ),
          child: Center(child: Text(trickName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width / 14, color: Theme.of(context).primaryColor), textAlign: TextAlign.center)),
        ),
      ),
    );
  }

  animate(String trickName) {
    _animationController.forward(from: 0);
    if (mounted) {
      setState(() {
        this.trickName = trickName;
      });
    }
  }
}
