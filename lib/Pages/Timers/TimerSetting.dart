import 'dart:ui';
import 'package:flutter/material.dart';
import '/Locale/locales.dart';
import '/Theme/colors.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


class TimerSetting extends StatefulWidget {
  final int index;
  List sTimer;

  TimerSetting(this.index, this.sTimer);

  @override
  _TimerSettingState createState() => new _TimerSettingState();
}

class _TimerSettingState extends State<TimerSetting> {

  int preTime = 0, actTime = 0, regTime = 0, rndTime = 0;

  double labSize = 28, icoSize = 44, boxSize = 38;
  List timerTypeColor = [timerColorFight,  timerColorPause, timerColorPrep];
  List timerTypeText = ['Aktivzeit', 'Erholungszeit',  'Vorbereitung'];

  String durationString(String sec) {
    Duration duration = Duration(seconds: int. parse(sec));
    if (sec == '0') {
      return ' - ';
    } else {
      return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  void initState() {
    super.initState();

    var tBox = Hive.box('TimersBox');
    print(tBox.get(0));
    print(widget.index);
    print(widget.sTimer);

    preTime = int. parse(widget.sTimer[widget.index][1]);
    actTime = int. parse(widget.sTimer[widget.index][2]);
    regTime = int. parse(widget.sTimer[widget.index][3]);
    rndTime = int. parse(widget.sTimer[widget.index][4]);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    ThemeData themeData = Theme.of(context);

    int index = widget.index;
    String labTime = '';
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: AppBar(
                leading: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.chevron_left),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                titleSpacing: 0,
                backgroundColor: Colors.grey[800]!.withOpacity(0.3),
                // Bereich Appbar
                title: Text(
                  widget.sTimer[widget.index][0], //locale.workout!,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                            icon: Icon(
                            Icons.save_alt,
                              color: Colors.white70,
                              size: 24.0,
                            ),
                          label: Text(
                              'speichern',
                              style: TextStyle(color: Colors.white70,  fontWeight: FontWeight.normal)
                          ),
                          onPressed: () {
                            print('Pressed');
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  timerColorPauseBg),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey[800]!.withOpacity(0.5)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(
                                          color: Colors.grey[800]!
                                              .withOpacity(0.5),
                                          width: 3)))),
                          ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(AppBar().preferredSize.height)),
      backgroundColor: Colors.white10, // keine Auswirkung

      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/bg1.png",
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Column(
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]!.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            timerTypeText[2],
                                            style: TextStyle(color: timerTypeColor[2],fontSize: labSize, fontWeight: FontWeight.bold)
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {

                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            child: Text(
                                                durationString(preTime.toString()),
                                                style: TextStyle(fontSize: boxSize, fontWeight: FontWeight.bold)
                                            ),
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size(110,30)),
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!.withOpacity(0.5)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: timerTypeColor[2], width: 5)
                                                    )
                                                )
                                            ),
                                            onPressed: () => null
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {

                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]!.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            timerTypeText[0],
                                            style: TextStyle(color: timerTypeColor[0],fontSize: labSize, fontWeight: FontWeight.bold)
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {

                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            child: Text(
                                                durationString(actTime.toString()),
                                                style: TextStyle(fontSize: boxSize, fontWeight: FontWeight.bold)
                                            ),
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size(110,30)),
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!.withOpacity(0.5)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: timerTypeColor[0], width: 5)
                                                    )
                                                )
                                            ),
                                            onPressed: () => null
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {

                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]!.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            timerTypeText[1],
                                            style: TextStyle(color: timerTypeColor[1],fontSize: labSize, fontWeight: FontWeight.bold)
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {

                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            child: Text(
                                                durationString(regTime.toString()),
                                                style: TextStyle(fontSize: boxSize, fontWeight: FontWeight.bold)
                                            ),
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size(110,30)),
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!.withOpacity(0.5)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: timerTypeColor[1], width: 5)
                                                    )
                                                )
                                            ),
                                            onPressed: () => null
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {

                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]!.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Runden',
                                            style: TextStyle(color: Colors.white70,fontSize: labSize, fontWeight: FontWeight.bold)
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {
                                            rndTime = rndTime - 1;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                            child: Text(
                                                rndTime.toString(),
                                                style: TextStyle(fontSize: boxSize, fontWeight: FontWeight.bold)
                                            ),
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size(110,30)),
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!.withOpacity(0.5)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: Colors.white70, width: 5)
                                                                                                         )
                                                ),
                                            ),
                                            onPressed: () => null
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          color: Colors.white70,
                                          iconSize: icoSize,
                                          splashRadius: 40,
                                          disabledColor: Colors.blueAccent,
                                          onPressed: () {
                                            rndTime = rndTime + 1;
                                            print(rndTime.toString());
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
