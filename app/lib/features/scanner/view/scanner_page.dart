import 'package:app/features/fetch_product/fetch_product.dart';
import 'package:app/features/scanner/scanner.dart';
import 'package:app/features/scanner/view/scanner_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final l10n = context.l10n;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScannerCubit()),
        BlocProvider<ProductCubit>(create: (context) => GetIt.I()),
      ],
      child: const QrCodeScannerView(),
    );
  }
}

class QrCodeScannerView extends StatelessWidget {
  const QrCodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const QrCodeContent(),
    );
  }
}

class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BarcodeScannerWithControllerState createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
      // formats: [BarcodeFormat.qrCode]
      // facing: CameraFacing.front,
      // detectionSpeed: DetectionSpeed.normal
      // detectionTimeoutMs: 1000,
      // returnImage: false,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('With controller')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            onDetect: (barcode) {
              setState(() {
                this.barcode = barcode;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*ValueListenableBuilder(
                        valueListenable: controller.hasTorchState,
                        builder: (context, state, child) {
                          if (state != true) {
                            return const SizedBox.shrink();
                          }
                          // return IconButton(
                          //   color: Colors.white,
                          //   icon: ValueListenableBuilder(
                          //     valueListenable: controller.torchState,
                          //     builder: (context, state, child) {
                          //       switch (state) {
                          //         case TorchState.off:
                          //           return const Icon(
                          //             Icons.flash_off,
                          //             color: Colors.grey,
                          //           );
                          //         case TorchState.on:
                          //           return const Icon(
                          //             Icons.flash_on,
                          //             color: Colors.yellow,
                          //           );
                          //       }
                          //     },
                          //   ),
                          //   iconSize: 32.0,
                          //   onPressed: () => controller.toggleTorch(),
                          // );
                        //},
                      //),*/
                  // IconButton(
                  //   color: Colors.white,
                  //   icon: isStarted
                  //       ? const Icon(Icons.stop)
                  //       : const Icon(Icons.play_arrow),
                  //   iconSize: 32.0,
                  //   onPressed: _startOrStop,
                  // ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      child: FittedBox(
                        child: Text(
                          barcode?.barcodes.first.rawValue ?? 'Scan something!',
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front);
                          case CameraFacing.back:
                            return const Icon(Icons.camera_rear);
                        }
                      },
                    ),
                    iconSize: 32,
                    onPressed: controller.switchCamera,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
