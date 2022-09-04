import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MaterialApp(
      title: 'AdMob',
      theme: ThemeData(
        // fontFamily: "Montserrat",
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

late Animation<double> animation;
late AnimationController controller;
late BannerAd bottomBannerAd;
bool isBottomBannerAdLoaded = false;
late InterstitialAd interstitialAd1,
    interstitialAd2,
    interstitialAd3,
    interstitialAd4,
    interstitialAd5;
bool isInterstitialAdLoaded = false;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    createBottomBannerAd();
    loadInterstitialAds();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween<double>(begin: 10, end: 1)
        .chain(CurveTween(curve: Curves.bounceOut))
        .animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    bottomBannerAd.dispose();
    controller.dispose();
  }

  void createBottomBannerAd() {
    bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bottomBannerAd.load();
  }

  void loadInterstitialAds() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-6925422502460692/5112731815",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd1 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              showSnackBar();
            },
          );

          isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdLoaded = false;
        },
      ),
    );
    InterstitialAd.load(
      adUnitId: "ca-app-pub-6925422502460692/8644453149",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd2 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              showSnackBar();
            },
          );

          isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdLoaded = false;
        },
      ),
    );
    InterstitialAd.load(
      adUnitId: "ca-app-pub-6925422502460692/2079044795",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd3 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              showSnackBar();
            },
          );

          isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdLoaded = false;
        },
      ),
    );
    InterstitialAd.load(
      adUnitId: "ca-app-pub-6925422502460692/7139799787",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd4 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              showSnackBar();
            },
          );

          isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdLoaded = false;
        },
      ),
    );
    InterstitialAd.load(
      adUnitId: "ca-app-pub-6925422502460692/3972363359",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd5 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              showSnackBar();
            },
          );

          isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  showSnackBar() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Ad Viewer",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            child: const Text(
                              "Show Interstitial Ad 1",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              if (isInterstitialAdLoaded) {
                                interstitialAd1.show();
                              } else {
                                showSnackBar();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            child: const Text(
                              "Show Interstitial Ad 2",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              if (isInterstitialAdLoaded) {
                                interstitialAd2.show();
                              } else {
                                showSnackBar();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            child: const Text(
                              "Show Interstitial Ad 3",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              if (isInterstitialAdLoaded) {
                                interstitialAd3.show();
                              } else {
                                showSnackBar();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            child: const Text(
                              "Show Interstitial Ad 4",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              if (isInterstitialAdLoaded) {
                                interstitialAd4.show();
                              } else {
                                showSnackBar();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            child: const Text(
                              "Show Interstitial Ad 5",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              if (isInterstitialAdLoaded) {
                                interstitialAd5.show();
                              } else {
                                showSnackBar();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -50,
                    left: animation.value,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    right: animation.value,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Don't click me! I'm just an animation lol",
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
        bottomNavigationBar: isBottomBannerAdLoaded
            ? SizedBox(
                height: bottomBannerAd.size.height.toDouble(),
                width: bottomBannerAd.size.width.toDouble(),
                child: AdWidget(ad: bottomBannerAd),
              )
            : null,
      ),
    );
  }
}
