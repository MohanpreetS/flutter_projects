import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/side_drawer.dart';
import '../widgets/reward_punishment.dart';
import '../templates/rounded_tint_container.dart';
import '../providers/motivators.dart';

class MotivatorsScreen extends StatefulWidget {
  static const routeName = '/motivatorsScreen';
  bool rewardSelected = true;
  @override
  _MotivatorsScreenState createState() => _MotivatorsScreenState();
}

class _MotivatorsScreenState extends State<MotivatorsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final motivators = Provider.of<Motivators>(context);
    //print(motivators.rewards.length);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: SideDrawer(),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/luke-chesser-PHtp0cDBJSM-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  _buildHeader(
                    () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    widget.rewardSelected,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          if (widget.rewardSelected)
                            _buildConcreteRewards(size, motivators, context),
                          if (!widget.rewardSelected)
                            _buildConcretePunishments(size),
                          SizedBox(
                            height: 15,
                          ),
                          if (widget.rewardSelected)
                            _buildReasonRewards(size, motivators),
                          if (!widget.rewardSelected)
                            _buildReasonPunishments(size),
                        ],
                      ),
                    ),
                  ),
                  RewardPunishment(
                    () {},
                    () {
                      widget.rewardSelected = true;
                      setState(() {});
                    },
                    () {
                      widget.rewardSelected = false;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMotivatorsTitle() {
    return Text(
      'Motivators',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRewardLine(motivator) {
    var icon;
    if (motivator.isReason) {
      icon = Icons.star;
    } else {
      icon = Icons.celebration;
    }
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
            ),
            children: [
              WidgetSpan(
                child: Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              TextSpan(text: ' ${motivator.details}')
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }

  Widget _buildConcreteRewards(size, motivators, context) {
    return RoundedTintContainer(
      color: Colors.yellowAccent.shade700,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.35,
        width: size.width * 0.9,
        padding: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Concrete Rewards',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Expanded(
              //height: size.height * 0.28,
              child: ListView.builder(
                itemBuilder: (context, i) {
                  if (!motivators.rewards[i].isReason) {
                    return _buildRewardLine(motivators.rewards[i]);
                  }
                  return Container();
                },
                itemCount: motivators.rewards.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonRewards(size, motivators) {
    return RoundedTintContainer(
      color: Colors.yellowAccent.shade700,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.35,
        width: size.width * 0.9,
        padding: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                'Reasons to succeed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Expanded(
              //height: size.height * 0.28,
              child: ListView.builder(
                itemBuilder: (context, i) {
                  if (motivators.rewards[i].isReason) {
                    return _buildRewardLine(motivators.rewards[i]);
                  }
                  return Container();
                },
                itemCount: motivators.rewards.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConcretePunishments(size) {
    return RoundedTintContainer(
      color: Colors.red,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.35,
        width: size.width * 0.9,
      ),
    );
  }

  Widget _buildReasonPunishments(size) {
    return RoundedTintContainer(
      color: Colors.red,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.35,
        width: size.width * 0.9,
      ),
    );
  }

  Widget _buildHeader(drawerOpen, rewardSelected) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 28,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: _buildMotivatorsTitle(),
              ),
            ),
            IconButton(
              onPressed: drawerOpen,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 28,
              ),
            )
          ],
        ),
        if (rewardSelected)
          Container(
            child: Text(
              'Rewards',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        if (!rewardSelected)
          Container(
            child: Text(
              'Punishments',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          )
      ],
    );
  }
}
