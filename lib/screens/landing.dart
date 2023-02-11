import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glucose_guardian/constants/assets.dart';
import 'package:glucose_guardian/constants/colors.dart';
import 'package:glucose_guardian/constants/strings.dart';
import 'package:glucose_guardian/screens/login.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

/// Landing screen
///
/// This will be called once when opening the app for the first time
/// Store maybe in the shared preferences a boolean indicating if the app
/// has previously been opened or not
class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final List<Widget> pages = const [
    _LandingPageContent(
      title: "Benvenut* in Glucose Guardian",
      description: kAppUniLectureDesc,
      asset: kUndrawProfessor,
    ),
    _LandingPageContent(
      title: "Benvenut* in Glucose Guardian",
      description: kAppCreators,
      asset: kUndrawStudent,
    ),
    _LandingPageContent(
      title: "Cos'è Glucose Guardian?",
      description: kAppDescription,
      shrinkIcon: true,
    ),
  ];

  final int pageCount = 3;
  late final PageController _controller;
  late int _selectedPage;

  @override
  void initState() {
    _selectedPage = 0;
    _controller = PageController(initialPage: _selectedPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (page) {
              setState(() {
                _selectedPage = page;
              });
            },
            children: pages,
          ),
          Positioned(
            bottom: 64,
            child: Center(
              child: PageViewDotIndicator(
                currentItem: _selectedPage,
                count: pageCount,
                unselectedColor: Colors.black26,
                selectedColor: kBlue,
              ),
            ),
          ),
          Positioned(
              bottom: 32,
              right: 32,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Semantics(
                    button: true,
                    hint: "Bottone per proseguire alla prossima schermata",
                    child: MaterialButton(
                      onPressed: () {
                        if (_selectedPage != (pageCount - 1)) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        } else {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const Login(),
                            ),
                          );
                          // goodbye landing page, never see you again after this
                          SharedPreferenceService.firstTimeOpeningApp = false;
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        _selectedPage != (pageCount - 1) ? "Avanti" : "Inizia",
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class _LandingPageContent extends StatelessWidget {
  final String title;
  final String description;
  final String? asset;
  final bool shrinkIcon;

  const _LandingPageContent({
    required this.title,
    required this.description,
    this.asset,
    this.shrinkIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: asset != null
                ? SvgPicture.asset(asset!)
                : Image.asset(
                    kLogoTransparent,
                    semanticLabel: "Logo dell'applicazione",
                  ),
          ),
        ),
        Expanded(
          flex: asset == null ? 2 : 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Center(
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
