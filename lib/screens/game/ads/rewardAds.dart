import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdhelperForReward{

  static String get addUnitId => "ca-app-pub-3940256099942544/5224354917";

  RewardedAd? _rewardedAd;

  void loadRewardedAdd() async{
     RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad){
                print("loaded");
            },
            onAdFailedToLoad: (er){
                print("Not loaded");
            }
        )
    );
  }

}