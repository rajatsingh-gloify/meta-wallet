// ignore: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dapp/metmask.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaMaskProvider()..init(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Image.network(
              'https://images.unsplash.com/photo-1511406361295-0a1ff814c0ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              fit: BoxFit.cover,
            )),
            // wallpaper
            Center(
              child: Consumer<MetaMaskProvider>(
                builder: (context, provider, child) {
                  late final String text;

                  if (provider.isConnected && provider.isInOperatingChain) {
                    // text = "connected";
                    text =
                        "Wallet Address: ${context.read<MetaMaskProvider>().walletAddress.toString()}";
                  } else if (provider.isConnected &&
                      !provider.isInOperatingChain) {
                    text =
                        "Wrong chain! Please connect to ${MetaMaskProvider.operatingChain}";
                  } else if (provider.isEnabled) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Connect your wallet",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        CupertinoButton(
                          child: SizedBox(
                            width: 400,
                            height: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlaLqecIBKWfIXD4miDzqbUEGDwPCJ95wL0QURY8Ah2DheWJKYyp8a8VG0uT7nHlunBPA&usqp=CAU',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<MetaMaskProvider>().connect();
                          },
                        ),
                      ],
                    );
                  } else {
                    text = "Please use web 3.0 supported Browser";
                  }
                  return Text(
                    text,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _handleConnectRequest() {}
