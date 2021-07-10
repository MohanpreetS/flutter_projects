import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/side_drawer.dart';
import '../widgets/reward_punishment.dart';
import '../templates/rounded_tint_container.dart';
import '../providers/motivators.dart';
import '../widgets/add_rp_sheet.dart';

class MotivatorsScreen extends StatefulWidget {
  static const routeName = '/motivatorsScreen';
  bool rewardSelected = true;

  MotivatorsScreen(this.rewardSelected);
  @override
  _MotivatorsScreenState createState() => _MotivatorsScreenState();

  void showPunishments() {
    rewardSelected = false;
  }
}

class _MotivatorsScreenState extends State<MotivatorsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final motivators = Provider.of<Motivators>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: SideDrawer(),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background1.jpg'),
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
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              if (widget.rewardSelected)
                                _buildConcreteRewards(
                                    size, motivators, context),
                              if (!widget.rewardSelected)
                                _buildConcretePunishments(size, motivators),
                              SizedBox(
                                height: 15,
                              ),
                              if (widget.rewardSelected)
                                _buildReasonRewards(size, motivators),
                              if (!widget.rewardSelected)
                                _buildReasonPunishments(size, motivators),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  RewardPunishment(
                    () {
                      showAddRpSheet(widget.rewardSelected);
                    },
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

  showAddRpSheet(isReward) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: Duration(milliseconds: 150),
          child: AddRpSheet(
            isReward: isReward,
          ),
        );
      },
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

  int subListCount(list, isReason) {
    var count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].isReason == isReason) {
        count++;
      }
    }

    return count;
  }

  Widget _buildRewardLine(motivator) {
    var icon;
    if (motivator.isReason) {
      icon = Icons.star;
    } else {
      icon = Icons.celebration;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildPunishmentLine(motivator) {
    var icon;
    if (motivator.isReason) {
      icon = Icons.local_fire_department_sharp;
    } else {
      icon = Icons.not_interested;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            if (subListCount(motivators.rewards, false) != 0)
              Expanded(
                //height: size.height * 0.28,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    if (!motivators.rewards[i].isReason) {
                      return Container(
                          child: _buildRewardLine(motivators.rewards[i]));
                    }
                    return Container();
                  },
                  itemCount: motivators.rewards.length,
                ),
              ),
            if (subListCount(motivators.rewards, false) == 0)
              Expanded(
                child: Center(
                  child: Text(
                    'Add some concrete rewards',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                'Reasons for succeeding',
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
            if (subListCount(motivators.rewards, true) != 0)
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
            if (subListCount(motivators.rewards, true) == 0)
              Expanded(
                child: Center(
                  child: Text(
                    'Add some reasons to succeed',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildConcretePunishments(size, motivators) {
    return RoundedTintContainer(
      color: Colors.red,
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
                'Concrete Punishments',
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
            if (subListCount(motivators.punishments, false) != 0)
              Expanded(
                //height: size.height * 0.28,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    if (!motivators.punishments[i].isReason) {
                      return _buildPunishmentLine(motivators.punishments[i]);
                    }
                    return Container();
                  },
                  itemCount: motivators.punishments.length,
                ),
              ),
            if (subListCount(motivators.punishments, false) == 0)
              Expanded(
                child: Center(
                  child: Text(
                    'Add some concrete punishments',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonPunishments(size, motivators) {
    return RoundedTintContainer(
      color: Colors.red,
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
                'Reasons for not failing',
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
            if (subListCount(motivators.punishments, true) != 0)
              Expanded(
                //height: size.height * 0.28,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    if (motivators.punishments[i].isReason) {
                      return _buildPunishmentLine(motivators.punishments[i]);
                    }
                    return Container();
                  },
                  itemCount: motivators.punishments.length,
                ),
              ),
            if (subListCount(motivators.punishments, true) == 0)
              Expanded(
                child: Center(
                  child: Text(
                    'Add some reasons to not fail',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
