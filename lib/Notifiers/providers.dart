import 'package:ontologie_et_web_semantique/Notifiers/api_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
   ChangeNotifierProvider(
    create: (context) => ApiService.instance,
    lazy: false,
  ),
];
