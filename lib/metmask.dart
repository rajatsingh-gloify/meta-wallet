import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  // some static variable
  static const operatingChain = 1337;
  String currentAddress = '';
  List<String> walletAddress = [];
  int currentChain = -1;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();
      walletAddress = await ethereum!.getAccounts.call();

      notifyListeners();
    }
  }

  clear() {
    currentAddress = "";
    currentChain = -1;
    notifyListeners();
  }

  init() {
    if (isEnabled) {
      // clear on account change
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      // clear on chain change
      ethereum!.onChainChanged((chainId) {
        clear();
      });
    }
  }
}
