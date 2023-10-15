import 'package:app/features/fetch_product/fetch_product.dart';
import 'package:app/features/scanner/domain/qr_code_scanner_state.dart';
import 'package:app/features/scanner/scanner.dart';
import 'package:app/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeContent extends StatefulWidget {
  const QrCodeContent({super.key});

  @override
  State<QrCodeContent> createState() => _QrCodeContentState();
}

class _QrCodeContentState extends State<QrCodeContent>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  BarcodeCapture? capture;

  bool isStarted = false;

  final MobileScannerController _cameraController = MobileScannerController(
    //facing: CameraFacing.front,
    autoStart: false,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Trick. In this way the controller is stop without try catch and then
    // start again after switching the camera.
    //_init();
  }

  Future<void> _init() async {
    await _cameraController.stop();
    await _cameraController.start();
  }

  @override
  void dispose() {
    //_cameraController.dispose();

    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // App state changed before the controller was initialized.
    if (_cameraController.isStarting) {
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        await _cameraController.stop();
        await _cameraController.start();
      case AppLifecycleState.inactive:
        await _cameraController.stop();
      // ignore: no_default_cases
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (ctx, state) {
        if (state.status.isSuccess) {
          // push
          context.goNamed(AppRoute.addProduct.name, extra: state.product);
          // reset the state
          ctx.read<ProductCubit>().reset();
          ctx.read<QrCodeScannerCubit>().reset();
        }
      },
      builder: (productCtx, state) {
        return BlocConsumer<QrCodeScannerCubit, QrCodeScannerState>(
          listener: (context, state) {
            if (state.code != null) {
              // fetch
              productCtx.read<ProductCubit>().fetch(state.code!);
            }
          },
          builder: (ctx, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                // MobileScanner(
                //   errorBuilder: (context, error, child) {
                //     return ScannerErrorWidget(error: error);
                //   },
                //   controller: _cameraController,
                //   placeholderBuilder: (ctx, child) {
                //     return const Center(
                //       child: SizedBox(
                //         height: 80,
                //         width: 80,
                //         child: CircularProgressIndicator(strokeWidth: 5),
                //       ),
                //     );
                //   },
                //   onDetect: (capture) {
                //     print(capture.barcodes.first.rawValue);
                //     if (capture.barcodes.first.rawValue != null) {
                //       context
                //           .read<QrCodeScannerCubit>()
                //           .setCode(capture.barcodes.first.rawValue!);
                //     }
                //   },
                //   overlay: QRScannerOverlay(
                //     overlayColour: Colors.black.withOpacity(0.5),
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    context.read<QrCodeScannerCubit>().setCode('8076809580748');
                  },
                  // FIXME: l10n
                  child: const Text('Cerca'),
                ),
                // manual
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: TextEditingController(
                                text: '8076809580748',
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Inserisci codice a barre',
                                prefixIcon: Icon(Icons.search_rounded),
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  context
                                      .read<QrCodeScannerCubit>()
                                      .setCode(value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
            // failure
            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text(
            //         'Codice non riconosciuto',
            //       ),
            //       const SizedBox(height: 30),
            //       OutlinedButton(
            //         child: const Text('Riprova'),
            //         onPressed: () {
            //           context.read<QrCodeScannerCubit>().reset();
            //         },
            //       ),
            //     ],
            //   ),
            // );
          },
        );
      },
    );
  }
}

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({required this.overlayColour, super.key});

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    // // Changing the size of scanner cutout dependent on the device size.
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            overlayColour,
            BlendMode.srcOut,
          ), // This one will create the magic
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Align(
                child: Container(
                  height: scanArea,
                  width: scanArea,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          child: CustomPaint(
            foregroundPainter: BorderPainter(),
            child: SizedBox(
              width: scanArea + 25,
              height: scanArea + 25,
            ),
          ),
        ),
      ],
    );
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas
      ..clipPath(path)
      ..drawRRect(
        rrect,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = width,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(size.width - 44, size.height - 44),
              radius: 40,
            ),
          )
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({required this.error, super.key});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';

      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';

      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';

      // ignore: no_default_cases
      default:
        errorMessage = 'Generic Error';
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
