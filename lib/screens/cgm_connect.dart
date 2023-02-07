import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

class CGMConnect extends StatefulWidget {
  const CGMConnect({super.key});

  @override
  State<CGMConnect> createState() => _CGMConnectState();
}

class _CGMConnectState extends State<CGMConnect> {
  bool cgmFound = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      setState(() => cgmFound = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    FlutterError.onError = null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SharedPreferenceService.connectedCgm.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: SizedBox(height: 100, child: _buildCard()),
                ),
              )
            : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    AnimatedContainer(
                      decoration: const BoxDecoration(
                        color: kBackgroundColor,
                      ),
                      duration: const Duration(milliseconds: 1000),
                      height: cgmFound ? height / 1.6 : height,
                      child: Center(
                        child: AvatarGlow(
                          glowColor: kOrangePrimary,
                          endRadius: 180.0,
                          duration: const Duration(milliseconds: 1000),
                          repeat: !cgmFound,
                          showTwoGlows: true,
                          repeatPauseDuration: const Duration(milliseconds: 20),
                          child: Material(
                            shape: const CircleBorder(),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.grey[100],
                              child: SvgPicture.asset(
                                kCgmIcon,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (cgmFound)
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ConfirmPairing(),
                          ),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _buildCard(),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCard() => Row(
        children: [
          Hero(
            tag: 'cgm',
            child: SvgPicture.asset(
              kCgmIcon,
              width: 44,
              height: 44,
              color: kOrangePrimary,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "CGM di ${SharedPreferenceService.codiceFiscale}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}

class ConfirmPairing extends StatefulWidget {
  const ConfirmPairing({
    super.key,
  });

  @override
  State<ConfirmPairing> createState() => _ConfirmPairingState();
}

class _ConfirmPairingState extends State<ConfirmPairing> {
  bool connected = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 800), () {
      setState(() {
        connected = true;
      });

      Timer(const Duration(milliseconds: 1250), () {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'cgm',
              child: Material(
                shape: const CircleBorder(),
                child: AnimatedContainer(
                  onEnd: () => SharedPreferenceService.connectedCgm =
                      "CGM di ${SharedPreferenceService.codiceFiscale}",
                  duration: const Duration(milliseconds: 800),
                  decoration: BoxDecoration(
                    color: connected ? Colors.green : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  width: 100,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset(
                      kCgmIcon,
                      color: connected ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (connected)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 150),
                child: Text(
                  "Connesso!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
