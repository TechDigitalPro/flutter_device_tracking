import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/widget_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/main/main_view_model.dart';

// ignore: must_be_immutable
class MainView extends StatefulWidget {
  MainView({this.selectedIndex, super.key});

  int? selectedIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (viewModel) =>
          viewModel.initialize(context,),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(BuildContext context, MainViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorPrimaryDark);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (result, details) async {
          if (result) return;
          showDialog(
            context: context,
            builder: (BuildContext dlgContext) => const ExitDialog(),
          );
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: ColorUtils.appColorWhite,
              appBar: AppBar(
                backgroundColor: ColorUtils.appColorPrimaryDark,
                elevation: 0,
                titleSpacing: 0,
                title: GestureDetector(
                  onTap: () {
                    
                  },
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView(
                              'test',
                              textColor: ColorUtils.appColorWhite,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.w500,
                              isCentered: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: Container()
              ),
            ),
        ),);
  }
}
