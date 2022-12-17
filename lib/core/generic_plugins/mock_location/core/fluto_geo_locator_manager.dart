import 'package:fluto/core/generic_plugins/mock_location/model/location_position_model.dart';
import 'package:fluto/core/pluggable.dart';

class FlutoGeoLocatorManager implements EnableAble {
  FlutoGeoLocatorManager({
    Position? initialMockPosition,
    required Future<Position?> Function() getCurrentPosition,
  })  : _getCurrentPosition = getCurrentPosition,
        _savedPosition = initialMockPosition;

  bool isEnabledLocationMocking = false;

  Position? _savedPosition;
  Position? get savedPosition => _savedPosition;
  void getSavedPostion(Position position) {
    _savedPosition = position;
  }

  final Future<Position?> Function() _getCurrentPosition;

  Future<Position?> getCurrentPosition() async {
    if (isEnabledLocationMocking) {
      return savedPosition;
    } else {
      return await _getCurrentPosition.call();
    }
  }

  @override
  bool get isEnable => isEnabledLocationMocking;

  @override
  void setEnable(bool value) {
    isEnabledLocationMocking = value;
  }
}
