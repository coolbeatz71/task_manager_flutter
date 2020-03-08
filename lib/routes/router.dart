import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:todo_app/views/pages/details/details.dart';
import 'package:todo_app/views/pages/wrapper.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  Wrapper wrapperPage;

  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  )
  Details detailsPage;
}
